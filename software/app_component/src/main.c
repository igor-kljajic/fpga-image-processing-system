#include "xparameters.h"


#include <xil_io.h>
#include <xil_printf.h>
#include <xil_types.h>
#include <xstatus.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#include "xaxidma.h"
#include "xinterrupt_wrap.h"
#include "xtmrctr.h"

#include <xil_cache.h>

#include "xil_util.h"

typedef struct ProcessingParams {
    
    u16 ImgW;
    u16 ImgH;
    u16 FilterRadius;   // mask = 2 * FilterRadius + 1
    u16 FilterCoeffsScale;
    u16 FilterCtrl;
    _Bool Border;
    s16* FilterCoeffs;
}ProcessingParams;



#define DMA_TRANSFER_TIMEOUT 1000000

#define REG_CTRL    0x0
#define REG_RADIUS    0x4
#define REG_IMG_W   0x8
#define REG_IMG_H   0xC
#define REG_COEFF_SCALE 0x10
#define REG_COEFF_W0 0x14

static XAxiDma AxiDma;
XTmrCtr AxiTimerInst;


volatile u32 TxDone;
volatile u32 RxDone;

static void ImageFIlterSW(u8* DataBuffer, u8* ResultBuffer, ProcessingParams Params);
static int  ImageFIlterHW(u8* DataBuffer, u16* ResultBuffer, ProcessingParams Params);

static int DmaConfigure(XAxiDma_Config* AxiDmaConfigPtr, XAxiDma* AxiDmaPtr);
static int DmaStartTransfers(XAxiDma* AxiDmaPtr, u8* TxBuffer, u32 TxSize, u8* RxBuffer, u32 RxSize);
static int DmaWaitTransfers(volatile u32* TxFlag, volatile u32* RxFlag, u32 Timeout);

static int ConfigureFilter(UINTPTR BaseAddress, ProcessingParams Params);

static int CheckData(u16* ResultBuffer, u8* ReferentBuffer, ProcessingParams Params);

static void TxIntrHandler(void *Callback);
static void RxIntrHandler(void *Callback);

void GetProcessingParams(ProcessingParams* Params);
void PrintProcessingParams(ProcessingParams Params);
uint32_t CalcValidBytes(uint16_t ImgH, uint16_t ImgW, uint16_t radius);

int main(void)
{
    int Status;

    u8 *PlaceHolder;
    u8 *DataBuffer;
    u8 *ReferentBuffer;
    u16 *ResultBuffer;

    ProcessingParams Params;

    u32 startTime, stopTime, swTicks, hwTicks, swTime, hwTime;
   
    // AXI Timer Init
    Status = XTmrCtr_Initialize(&AxiTimerInst, XPAR_AXI_TIMER_0_BASEADDR);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    // Set auto-reload option 
    XTmrCtr_SetOptions(&AxiTimerInst, 0, XTC_AUTO_RELOAD_OPTION);
   

    while(1){
        
        xil_printf("\r\n########## New processing ##########\r\n");

        GetProcessingParams(&Params);
        PrintProcessingParams(Params);

        // Calculate new picture's dimensions
        u32 ImgSizeIn = Params.ImgH * Params.ImgW;
    
        u32 OutW = Params.ImgW - 2 * Params.FilterRadius;
        u32 OutH = Params.ImgH - 2 * Params.FilterRadius;
        u32 ImgSizeOut = OutW * OutH;
    
        // Input buffer allocation  
        PlaceHolder = (u8*) malloc(ImgSizeIn + 8); // +8 for header
        if (PlaceHolder == NULL) {
            xil_printf("ERROR: Cannot allocate Data buffer\r\n");
            return XST_FAILURE;
        }
        xil_printf("\r\n Data (placeholder) buffer address: %x \r\n", PlaceHolder);

        DataBuffer = PlaceHolder + 8; // size: ImgSizeIn
    
        // Output buffer allocation 
        ResultBuffer = (u16*) malloc(ImgSizeOut * sizeof(u16));
        if (ResultBuffer == NULL) {
            xil_printf("ERROR: Cannot allocate Result buffer\r\n");
            return XST_FAILURE;
        }
        xil_printf("\r\n Result buffer address: %x \r\n", ResultBuffer);

        // Referent buffer allocation 
        ReferentBuffer = (u8*) malloc(ImgSizeOut * sizeof(u8));
        if (ReferentBuffer == NULL) {
            xil_printf("ERROR: Cannot allocate Referent buffer\r\n");
            return XST_FAILURE;
        }
        xil_printf("\r\n Referent buffer address: %x \r\n\n", ReferentBuffer);

        // Use mwr function in debug console to write image from .bin file to DataBuffer
        //    connect
        //    target
        //    target 2        
        //    mwr -size b -bin -file "C:/Users/Igor/Desktop/dvs25_projekat_g3/lena_128.bin"    0x1218C0            16384
        //                            full_path_to_file                                     data_buff_addr   transfer_size_bytes
        //    mwr -size b -bin -file "C:/Users/Igor/Desktop/dvs25_projekat_g3/lena_512.bin"    0x1218C0           262144
        //                            full_path_to_file                                     data_buff_addr   transfer_size_bytes
        
        xil_printf("\r\nStart processing \r\n");
   
        // Software processing
        xil_printf("  Software processing started...\r\n");

        XTmrCtr_Reset(&AxiTimerInst, 0);
        XTmrCtr_Start(&AxiTimerInst, 0);
        startTime = XTmrCtr_GetValue(&AxiTimerInst, 0);

        ImageFIlterSW(DataBuffer, ReferentBuffer, Params);

        XTmrCtr_Stop(&AxiTimerInst, 0);
        stopTime = XTmrCtr_GetValue(&AxiTimerInst, 0);
    
        swTicks = stopTime - startTime;
        // Conversion to microseconds (100MHz)
        swTime = swTicks / 50;

        xil_printf("  SW Ticks: %u          Time: %u us\r\n", swTicks, swTime);
   
        // Hardware processing
        xil_printf("  Hardware processing started...\r\n");

        XTmrCtr_Reset(&AxiTimerInst, 0);
        XTmrCtr_Start(&AxiTimerInst, 0);
        startTime = XTmrCtr_GetValue(&AxiTimerInst, 0);

        // Measure both configuration and transfer
        Status = ImageFIlterHW(DataBuffer, ResultBuffer, Params);

        XTmrCtr_Stop(&AxiTimerInst, 0);
        stopTime = XTmrCtr_GetValue(&AxiTimerInst, 0);

        hwTicks = stopTime - startTime;
    
        if (Status != XST_SUCCESS) {
            xil_printf("ERROR: HW failed\r\n");
        } else {
            // Conversion to microseconds (100MHz)
            hwTime = hwTicks / 50;
            xil_printf("  HW Ticks: %u          Time: %u us\r\n", hwTicks, hwTime);
        
            // Calculate acceleration
            xil_printf("  Acceleration: %ux\r\n", swTime / hwTime);
        }
        
        /*
        // Check data
        Status = CheckData(ResultBuffer, ReferentBuffer, Params);
        if (Status != XST_SUCCESS) {
            xil_printf("ERROR: Data check failed\r\n");
            return XST_FAILURE;
        }

        xil_printf("Data check OK\r\n\n");
        */

        xil_printf("Number of output image's byte size: %u\r\n", 
            CalcValidBytes(Params.ImgH, Params.ImgW, Params.FilterRadius));

        // Use mrd function in debug console to read image from ResultBuffer to .bin file
        //   HW0:   mrd -size b -bin -file "C:/Users/Igor/Desktop/dvs25_projekat_g3/slikaX.bin"    0x1258C8            31752
        //                              full_path_to_file                                       result_buff_addr   transfer_size_bytes
        //   SW:    mrd -size b -bin -file "C:/Users/Igor/Desktop/dvs25_projekat_g3/slikaX.bin"    0x12D0F0            15876
        //                              full_path_to_file                                       referent_buff_addr   transfer_size_bytes
   
        free(PlaceHolder);
        free(ResultBuffer);
        free(ReferentBuffer);

        // Clear console
        xil_printf("\033[2J\033[H");
    }

    return XST_SUCCESS;
}

static void ImageFIlterSW(u8* DataBuffer, u8* ResultBuffer, ProcessingParams Params)
{
    int i, j, ky, kx;
    int kernelDim = 2 * Params.FilterRadius + 1;
    int out_width = Params.ImgW - 2 * Params.FilterRadius;
    
    // Fixed-point to float
    float scale = (float)Params.FilterCoeffsScale / 4096.0f;

    if (Params.FilterCtrl & 0x0002) { // bypass
        for (int i = 0; i < Params.ImgH; i++) {
            for (int j = 0; j < Params.ImgW; j++) {
                int idx = i * Params.ImgW + j;
                ResultBuffer[idx] = DataBuffer[idx]; // copy
            }
        }
        return;
    }

    for (i = Params.FilterRadius; i < Params.ImgH - Params.FilterRadius; i++) {
        for (j = Params.FilterRadius; j < Params.ImgW - Params.FilterRadius; j++) {
            float sum = 0.0f;
            
            // Convolution
            for (ky = -Params.FilterRadius; ky <= Params.FilterRadius; ky++) {
                for (kx = -Params.FilterRadius; kx <= Params.FilterRadius; kx++) {
                    int y_in = i + ky;
                    int x_in = j + kx;
                    
                    u8 pixelVal = DataBuffer[y_in * Params.ImgW + x_in];
                    int k_idx = (ky + Params.FilterRadius) * kernelDim + (kx + Params.FilterRadius);
                    float float_coeff = (float)Params.FilterCoeffs[k_idx] / 32768.0f;
                    sum += (float)pixelVal * float_coeff;
                }
            }

            // Scaling and saturation
            sum = sum * scale;
            if (sum < 0.0f) sum = 0.0f;
            if (sum > 255.0f) sum = 255.0f;

            // Calculate index
            int out_i = i - Params.FilterRadius;
            int out_j = j - Params.FilterRadius;
            ResultBuffer[out_i * out_width + out_j] = (u8)sum;
        }
    }
}

static int ImageFIlterHW(u8* DataBuffer, u16* ResultBuffer, ProcessingParams Params)
{
    int Status;
    int ImageSizeIn = Params.ImgH * Params.ImgW;
    
    int OutW = Params.ImgW - 2 * Params.FilterRadius;
    int OutH = Params.ImgH - 2 * Params.FilterRadius;
    int ImageSizeOut = OutW * OutH * sizeof(u16);

    TxDone = 0;
    RxDone = 0;

    XAxiDma_Config *AxiDmaConfigPtr;
    AxiDmaConfigPtr = XAxiDma_LookupConfig(XPAR_XAXIDMA_0_BASEADDR);
    if (!AxiDmaConfigPtr) {
        xil_printf("  HW CONFIG ERROR: No config found for %d\r\n", XPAR_XAXIDMA_0_BASEADDR);

        return XST_FAILURE;
    }

    Status = DmaConfigure(AxiDmaConfigPtr, &AxiDma);
    if (Status != XST_SUCCESS)
    {
        xil_printf("  HW CONFIG ERROR: DMA configuration failed\r\n");
        return XST_FAILURE;        
    }
   
    Status = ConfigureFilter(XPAR_ACC_IMAGE_FILTER_0_BASEADDR, Params);

    Status = DmaStartTransfers(&AxiDma, DataBuffer, ImageSizeIn, (u8*)ResultBuffer, ImageSizeOut);
    if (Status != XST_SUCCESS)
    {
        xil_printf("  HW CONFIG ERROR: Starting DMA transfers failed\r\n");
        return XST_FAILURE;        
    }

    Status = DmaWaitTransfers(&TxDone, &RxDone, DMA_TRANSFER_TIMEOUT);
    if (Status != XST_SUCCESS)
    {
        xil_printf("  HW PROC ERROR: Completing DMA transfers failed\r\n");
        return XST_FAILURE;        
    }

    // Disable TX and RX interrupts
    XDisconnectInterruptCntrl(AxiDmaConfigPtr->IntrId[0], AxiDmaConfigPtr->IntrParent);
    XDisconnectInterruptCntrl(AxiDmaConfigPtr->IntrId[1], AxiDmaConfigPtr->IntrParent);
    XAxiDma_Reset(&AxiDma);
    
    // Wait for reset to finish
    int timeout = 10000;
    while (timeout > 0) {
        if (XAxiDma_ResetIsDone(&AxiDma)) {
            break;
        }
        timeout--;
    }

    return XST_SUCCESS;
}

static int CheckData(u16* ResultBuffer, u8* ReferentBuffer, ProcessingParams Params)
{
    int RowIndex = 0;
    int ColIndex = 0;

    int OutW = Params.ImgW - 2 * Params.FilterRadius;
    int OutH = Params.ImgH - 2 * Params.FilterRadius;

    // Invalidate cache
    Xil_DCacheInvalidateRange((UINTPTR)ResultBuffer, OutW * OutH * sizeof(u16));

    int mode = Params.FilterCtrl & 0x01;
    int error_count = 0;

    for (RowIndex = 0; RowIndex < OutH; RowIndex++){
        for (ColIndex = 0; ColIndex < OutW; ColIndex++){

            int linear_idx = RowIndex * OutW + ColIndex;
            u8 sw_pixel = ReferentBuffer[linear_idx];
            u8 hw_pixel = 0;

            if (mode == 0) {
                // Bottom 8 bits are value
                hw_pixel = (u8)(ResultBuffer[linear_idx] & 0xFF);
            } else {
                // Q9.7
                s16 raw_hw_val = (s16)ResultBuffer[linear_idx];
                int integer_val = raw_hw_val >> 7;
                
                // Saturation (same as SW)
                if (integer_val < 0) integer_val = 0;
                if (integer_val > 255) integer_val = 255;
                
                hw_pixel = (u8)integer_val;
            }

            // Compare with tolerance +/- 1
            if (abs((int)hw_pixel - (int)sw_pixel) > 1) {
                if (error_count < 10) { 
                    xil_printf("DATA CHECK ERROR: HW Row: %d Col: %d | HW Val: %d, SW Exp: %d\r\n",
                                RowIndex, ColIndex, hw_pixel, sw_pixel);
                }
                error_count++;
            }
        }
    }
    
    if (error_count > 0) {
        xil_printf("TOTAL ERRORS: %d\r\n", error_count);
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

static int DmaConfigure(XAxiDma_Config* AxiDmaConfigPtr, XAxiDma* AxiDmaPtr)
{
    int Status;
   
    /* DMA configuration */

    Status = XAxiDma_CfgInitialize(AxiDmaPtr, AxiDmaConfigPtr);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: DMA initialization failed %d\r\n", Status);
        return XST_FAILURE;
    }

    if (XAxiDma_HasSg(AxiDmaPtr)) {
        xil_printf("    ERROR: DMA configure in SG mode \r\n");
        return XST_FAILURE;
    }

    /* Configure DMA interrupts */
    Status = XSetupInterruptSystem(AxiDmaPtr, &TxIntrHandler,
                                  AxiDmaConfigPtr->IntrId[0], AxiDmaConfigPtr->IntrParent,
                                  XINTERRUPT_DEFAULT_PRIORITY);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: Cannot configure DMA TX interrupt\r\n");
        return XST_FAILURE;
    }

    Status = XSetupInterruptSystem(AxiDmaPtr, &RxIntrHandler,
                                   AxiDmaConfigPtr->IntrId[1], AxiDmaConfigPtr->IntrParent,
                                   XINTERRUPT_DEFAULT_PRIORITY);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: Cannot configure DMA RX interrupt\r\n");
        return XST_FAILURE;
    }

    XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);
    XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);

    return XST_SUCCESS;
}

static int DmaStartTransfers(XAxiDma* AxiDmaPtr, u8* TxBuffer, u32 TxSize, u8* RxBuffer, u32 RxSize)
{
    int Status;

    /* Flush TX buffer before DMA transfer to make sure that DDR and Cache are in sync */
    Xil_DCacheFlushRange((UINTPTR)TxBuffer, TxSize);
    Xil_DCacheFlushRange((UINTPTR)RxBuffer, RxSize);

    /* Start DMA tranfers */
    Status = XAxiDma_SimpleTransfer(AxiDmaPtr, (UINTPTR) RxBuffer,
                                    RxSize, XAXIDMA_DEVICE_TO_DMA);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: Starting RX DMA failed %d\r\n", Status);
        return XST_FAILURE;
    }

    Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR) TxBuffer,
                                    TxSize, XAXIDMA_DMA_TO_DEVICE);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: Starting TX DMA failed %d\r\n", Status);
        return XST_FAILURE;
    }

    return XST_SUCCESS;
}

static int DmaWaitTransfers(volatile u32* TxFlag, volatile u32* RxFlag, u32 Timeout)
{
    int Status;
    /* Wait for TX done or timeout */
    Status = Xil_WaitForEventSet(Timeout, 1, TxFlag);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: Transmit failed %d\r\n", Status);
        return XST_FAILURE;
    }
    xil_printf("    Transmit done\r\n");

    /* Wait for RX done or timeout */
    Status = Xil_WaitForEventSet(Timeout, 1, RxFlag);
    if (Status != XST_SUCCESS) {
        xil_printf("    ERROR: Receive failed %d\r\n", Status);
        return XST_FAILURE;
    }
    xil_printf("Receive done\r\n");

    return XST_SUCCESS;
}

static int ConfigureFilter(UINTPTR BaseAddress, ProcessingParams Params)
{
    u16 ReadValue;
   
    Xil_Out16(BaseAddress + REG_CTRL, Params.FilterCtrl);

    ReadValue = Xil_In16(BaseAddress + REG_CTRL);
    if(ReadValue != Params.FilterCtrl)
        return XST_FAILURE;

    Xil_Out16(BaseAddress + REG_RADIUS, Params.FilterRadius);

    ReadValue = Xil_In16(BaseAddress + REG_RADIUS);
    if(ReadValue != Params.FilterRadius)
        return XST_FAILURE;

    Xil_Out16(BaseAddress + REG_IMG_H, Params.ImgH);

    ReadValue = Xil_In16(BaseAddress + REG_IMG_H);
    if(ReadValue != Params.ImgH)
        return XST_FAILURE;

    Xil_Out16(BaseAddress + REG_IMG_W, Params.ImgW);

    ReadValue = Xil_In16(BaseAddress + REG_IMG_W);
    if(ReadValue != Params.ImgW)
        return XST_FAILURE;

    Xil_Out16(BaseAddress + REG_COEFF_SCALE, Params.FilterCoeffsScale);

    ReadValue = Xil_In16(BaseAddress + REG_COEFF_SCALE);
    if(ReadValue != Params.FilterCoeffsScale)
        return XST_FAILURE;

    for (int i = 0; i < 81; i++){
        s16 coeff;
        
        if (i < (2*Params.FilterRadius + 1)*(2*Params.FilterRadius + 1)) coeff = Params.FilterCoeffs[i];
        else coeff = 0x0000;
        
        Xil_Out16(BaseAddress + REG_COEFF_W0 + (i*4), coeff);

        ReadValue = Xil_In16(BaseAddress + REG_COEFF_W0 + (i * 4));
        if(ReadValue != (u16)coeff)
            return XST_FAILURE;
    }


    return XST_SUCCESS;
}


static void TxIntrHandler(void *Callback)
{
    u32 IrqStatus;
    XAxiDma *AxiDmaInst = (XAxiDma *)Callback;

    /* Read pending interrupts */
    IrqStatus = XAxiDma_IntrGetIrq(AxiDmaInst, XAXIDMA_DMA_TO_DEVICE);

    /* Acknowledge pending interrupts */
    XAxiDma_IntrAckIrq(AxiDmaInst, IrqStatus, XAXIDMA_DMA_TO_DEVICE);

    /* Set TX done only if transmit chain is completed */
    if ((IrqStatus & XAXIDMA_IRQ_IOC_MASK))
    {
        TxDone = 1;
    }

    return;
}

static void RxIntrHandler(void *Callback)
{
    u32 IrqStatus;
    XAxiDma *AxiDmaInst = (XAxiDma *)Callback;

    /* Read pending interrupts */
    IrqStatus = XAxiDma_IntrGetIrq(AxiDmaInst, XAXIDMA_DEVICE_TO_DMA);

    /* Acknowledge pending interrupts */
    XAxiDma_IntrAckIrq(AxiDmaInst, IrqStatus, XAXIDMA_DEVICE_TO_DMA);

    /* Set RX done only if receive chain is completed */
    if ((IrqStatus & XAXIDMA_IRQ_IOC_MASK))
    {
        RxDone = 1;
    }

    return;
}

void GetProcessingParams(ProcessingParams* Params) {

    u16 ImgW, ImgH;
    u16 bypass, mode, radius, filterChoice;
    float scaleInput;

    printf("Enter image width: ");
    scanf("%hu", &ImgW);
    printf("\nEnter image height: ");
    scanf("%hu", &ImgH);

    Params->ImgW = ImgW;
    Params->ImgH = ImgH;

    printf("\nEnter bypass bit (0 or 1): ");
    scanf("%hu", &bypass);

    if (bypass == 1) {
        Params->FilterCtrl = 0x0002; // bypass
        Params->FilterRadius = 0;
        Params->FilterCoeffsScale = 0;
        Params->FilterCoeffs = NULL;
        Params->Border = FALSE;
        return;
    }

    // If not bypass
    printf("\nSelect mode (0 or 1): ");
    scanf("%hu", &mode);
    Params->FilterCtrl = mode;

    printf("\nEnter scale factor (real number, e.g. 0.333): ");
    scanf("%f", &scaleInput);
    Params->FilterCoeffsScale = (u16)lround(scaleInput * (1 << 12));

    printf("\nEnter filter radius (1,2,3,4): ");
    scanf("%hu", &radius);
    Params->FilterRadius = radius;

    printf("\nChoose filter:\n");
    printf("1 - Box\n");
    printf("2 - Gaussian\n");
    printf("3 - LoG\n");
    printf("4 - Sharp Box\n");
    printf("5 - Sharp Gaussian\n");
    printf("6 - Manual coefficients\n");
    scanf("%hu", &filterChoice);

    u16 maskSize = 2 * radius + 1;
    u16 numCoeffs = maskSize * maskSize;
    Params->FilterCoeffs = (s16*)malloc(numCoeffs * sizeof(s16));

    switch(filterChoice) {
        case 1: // Box filter
            for (int i = 0; i < numCoeffs; i++) {
                float w = 1.0f / numCoeffs;
                Params->FilterCoeffs[i] = (s16)lround(w / scaleInput * (1 << 15));
            }
            break;

        case 2: { // Gaussian filter
            float sigma;
            printf("\nEnter sigma for Gaussian: ");
            scanf("%f", &sigma);
            int idx = 0;
            double sum = 0.0;
            double* temp = (double*)malloc(numCoeffs * sizeof(double));
            for (int y = -radius; y <= radius; y++) {
                for (int x = -radius; x <= radius; x++) {
                    double w = exp(-(x*x + y*y) / (2.0 * sigma * sigma)) / (2.0 * M_PI * sigma * sigma);
                    temp[idx++] = w;
                    sum += w;
                }
            }
            // Normalize so sum = 1
            for (int i = 0; i < numCoeffs; i++) {
                double wNorm = temp[i] / sum;
                Params->FilterCoeffs[i] = (s16)lround(wNorm / scaleInput * (1 << 15));
            }
            free(temp);
            break;
        }

        case 3: { // LoG filter
            float sigma;
            printf("\nEnter sigma for LoG: ");
            scanf("%f", &sigma);
            int idx = 0;
            double* temp = (double*)malloc(numCoeffs * sizeof(double));
            for (int y = -radius; y <= radius; y++) {
                for (int x = -radius; x <= radius; x++) {
                    double r2 = x*x + y*y;
                    double w = (-1.0 / (M_PI * pow(sigma,4))) * (1.0 - r2/(2.0*sigma*sigma)) * exp(-r2/(2.0*sigma*sigma));
                    temp[idx++] = w;
                }
            }
            // Scale (Normalize optional, LoG usually sums to ~0) 
            for (int i = 0; i < numCoeffs; i++) {
                Params->FilterCoeffs[i] = (s16)lround(temp[i] / scaleInput * (1 << 15));
            }
            free(temp);
            break;
        }

        case 4: { // Sharp Box
            float k;
            printf("\nEnter sharpening factor k: ");
            scanf("%f", &k);

            double w = 1.0 / numCoeffs; // Box weight
            int idx = 0;
            for (int y = -radius; y <= radius; y++) {
                for (int x = -radius; x <= radius; x++) {
                    double coeff = -k * w;
                    if (x == 0 && y == 0) {
                        coeff = (1.0 + k) - k * w;
                    }
                    Params->FilterCoeffs[idx++] = (s16)lround(coeff / scaleInput * (1 << 15));
                }
            }
            break;
        }

        case 5: { // Sharp Gaussian
            float sigma, k;
            printf("\nEnter sigma for Gaussian: ");
            scanf("%f", &sigma);
            printf("\nEnter sharpening factor k: ");
            scanf("%f", &k);

            int idx = 0;
            double sum = 0.0;
            double* temp = (double*)malloc(numCoeffs * sizeof(double));

            // Compute Gaussian kernel
            for (int y = -radius; y <= radius; y++) {
                for (int x = -radius; x <= radius; x++) {
                    double w = exp(-(x*x + y*y) / (2.0 * sigma * sigma)) / (2.0 * M_PI * sigma * sigma);
                    temp[idx++] = w;
                    sum += w;
                }
            }
            // Normalize Gaussian
            for (int i = 0; i < numCoeffs; i++) {
                temp[i] /= sum;
            }

            // Apply sharpening formula
            idx = 0;
            for (int y = -radius; y <= radius; y++) {
                for (int x = -radius; x <= radius; x++) {
                    double coeff = -k * temp[idx];
                    if (x == 0 && y == 0) {
                        coeff = (1.0 + k) - k * temp[idx];
                    }
                    Params->FilterCoeffs[idx] = (s16)lround(coeff / scaleInput * (1 << 15));
                    idx++;
                }
            }
            free(temp);
            break;
        }

        case 6: // Manual input
            for (int i = 0; i < numCoeffs; i++) {
                float w;
                printf("\nEnter coefficient %d: ", i);
                scanf("%f", &w);
                Params->FilterCoeffs[i] = (s16)lround(w / scaleInput * (1 << 15)); //  (w / scaleInput * (1 << 15))
            }
            break;

        default:
            printf("\nUnknown option.\n");
            break;
    }

    Params->Border = FALSE;
}


#include <stdio.h>
#include "xil_printf.h"

void PrintProcessingParams(ProcessingParams Params) {
    printf("=== Processing Parameters ===\n");
    printf("Image Width: %u\n", Params.ImgW);
    printf("Image Height: %u\n", Params.ImgH);
    printf("Filter Radius: %u\n", Params.FilterRadius);
    printf("Filter Control: 0x%04X\n", Params.FilterCtrl);
    printf("Filter Coeffs Scale: %u\n", Params.FilterCoeffsScale);
    printf("Border: %s\n", Params.Border ? "TRUE" : "FALSE");

    if (Params.FilterCoeffs != NULL) {
        u16 maskSize = 2 * Params.FilterRadius + 1;
        printf("Filter Coefficients Matrix (%ux%u):\n", maskSize, maskSize);
        int idx = 0;
        for (int y = 0; y < maskSize; y++) {
            for (int x = 0; x < maskSize; x++) {
                printf("%6d ", Params.FilterCoeffs[idx++]);
            }
            printf("\n");
        }
    } else {
        printf("Filter Coefficients: NULL (bypass mode)\n");
    }
}

uint32_t CalcValidBytes(uint16_t ImgH, uint16_t ImgW, uint16_t radius) {

    // Output dimensions
    uint32_t OutH = ImgH - 2 * radius;
    uint32_t OutW = ImgW - 2 * radius;

    // Number of valid pixels
    uint32_t NumPixels = OutH * OutW;

    // Number of valid bytes
    uint32_t NumBytes = NumPixels * 2;

    return NumBytes;
}