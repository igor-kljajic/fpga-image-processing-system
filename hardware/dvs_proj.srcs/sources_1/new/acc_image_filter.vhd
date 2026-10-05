library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity acc_image_filter is
    generic (
        C_S_AXI_DATA_WIDTH : integer := 32;
        C_S_AXI_ADDR_WIDTH : integer := 9
    );
    port (
        reset : in std_logic;
        clk   : in std_logic;

        -- AXI4-Lite write address channel
        s_axi_lite_awaddr  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        s_axi_lite_awprot  : in  std_logic_vector(2 downto 0);
        s_axi_lite_awvalid : in  std_logic;
        s_axi_lite_awready : out std_logic;

        -- AXI4-Lite write data channel
        s_axi_lite_wdata   : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        s_axi_lite_wstrb   : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        s_axi_lite_wvalid  : in  std_logic;
        s_axi_lite_wready  : out std_logic;

        -- AXI4-Lite write response channel
        s_axi_lite_bresp   : out std_logic_vector(1 downto 0);
        s_axi_lite_bvalid  : out std_logic;
        s_axi_lite_bready  : in  std_logic;

        -- AXI4-Lite read address channel
        s_axi_lite_araddr  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        s_axi_lite_arprot  : in  std_logic_vector(2 downto 0);
        s_axi_lite_arvalid : in  std_logic;
        s_axi_lite_arready : out std_logic;

        -- AXI4-Lite read data channel
        s_axi_lite_rdata   : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        s_axi_lite_rvalid  : out std_logic;
        s_axi_lite_rready  : in  std_logic;
        s_axi_lite_rresp   : out std_logic_vector(1 downto 0);

        -- AXI-Stream input
        s_axis_data_in_tdata  : in  std_logic_vector(7 downto 0);
        s_axis_data_in_tvalid : in  std_logic;
        s_axis_data_in_tready : out std_logic;
        s_axis_data_in_tlast  : in  std_logic;

        -- AXI-Stream output
        m_axis_data_out_tdata  : out std_logic_vector(15 downto 0);
        m_axis_data_out_tvalid : out std_logic;
        m_axis_data_out_tready : in  std_logic;
        m_axis_data_out_tlast  : out std_logic
    );
end acc_image_filter;

architecture Behavioral of acc_image_filter is

    ---------------------------------------------------------------------------
    -- Design constants
    ---------------------------------------------------------------------------
    constant WINDOW_SIZE       : integer := 9;
    constant WINDOW_LAST       : integer := WINDOW_SIZE - 1;
    constant COEFFICIENT_COUNT : integer := WINDOW_SIZE * WINDOW_SIZE;
    constant PIPELINE_LENGTH   : integer := 6;
    constant MAX_IMAGE_WIDTH   : integer := 1920;
    constant PIXEL_MAX_VALUE   : integer := 255;

    constant ADDR_LSB : natural := (C_S_AXI_DATA_WIDTH / 32) + 1;

    constant REG_CTRL_ADDR        : std_logic_vector(6 downto 0) := "0000000";
    constant REG_RADIUS_ADDR      : std_logic_vector(6 downto 0) := "0000001";
    constant REG_IMG_W_ADDR       : std_logic_vector(6 downto 0) := "0000010";
    constant REG_IMG_H_ADDR       : std_logic_vector(6 downto 0) := "0000011";
    constant REG_COEFF_SCALE_ADDR : std_logic_vector(6 downto 0) := "0000100";
    constant REG_COEFF_START_ADDR : std_logic_vector(6 downto 0) := "0000101";

    ---------------------------------------------------------------------------
    -- Types
    ---------------------------------------------------------------------------
    type coefficient_array_t is array (0 to COEFFICIENT_COUNT-1) of std_logic_vector(15 downto 0);

    type pixel_row_t    is array (0 to WINDOW_LAST) of std_logic_vector(7 downto 0);
    type pixel_window_t is array (0 to WINDOW_LAST) of pixel_row_t;

    type line_buffer_t is array (0 to MAX_IMAGE_WIDTH-1) of std_logic_vector(63 downto 0);

    type product_row_t    is array (0 to WINDOW_LAST) of signed(24 downto 0);
    type product_matrix_t is array (0 to WINDOW_LAST) of product_row_t;
    type row_sum_array_t  is array (0 to WINDOW_LAST) of signed(27 downto 0);
    type pipeline_flags_t is array (0 to PIPELINE_LENGTH-1) of std_logic;

    type read_state_t  is (READ_ADDRESS, READ_DATA);
    type write_state_t is (WRITE_ADDRESS, WRITE_DATA, WRITE_STALLED);

    ---------------------------------------------------------------------------
    -- AXI4-Lite registers and control signals
    ---------------------------------------------------------------------------
    signal control_reg     : std_logic_vector(15 downto 0);
    signal radius_reg      : std_logic_vector(15 downto 0);
    signal image_width_reg : std_logic_vector(15 downto 0);
    signal image_height_reg: std_logic_vector(15 downto 0);
    signal scale_reg       : std_logic_vector(15 downto 0);
    signal coefficient_reg : coefficient_array_t;

    signal axi_awready_i : std_logic;
    signal axi_wready_i  : std_logic;
    signal axi_bvalid_i  : std_logic;
    signal axi_arready_i : std_logic;
    signal axi_rvalid_i  : std_logic;

    signal stored_awaddr : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal stored_araddr : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    signal write_addr    : std_logic_vector(C_S_AXI_ADDR_WIDTH-ADDR_LSB-1 downto 0);
    signal read_addr     : std_logic_vector(C_S_AXI_ADDR_WIDTH-ADDR_LSB-1 downto 0);
    signal write_enable  : std_logic;

    signal read_state  : read_state_t;
    signal write_state : write_state_t;

    ---------------------------------------------------------------------------
    -- AXI-Stream and image-processing signals
    ---------------------------------------------------------------------------
    signal input_data  : std_logic_vector(7 downto 0);
    signal input_valid : std_logic;
    signal input_ready : std_logic;
    signal input_last  : std_logic;

    signal output_data  : std_logic_vector(15 downto 0);
    signal output_valid : std_logic;
    signal output_ready : std_logic;
    signal output_last  : std_logic;

    signal filtered_data : std_logic_vector(15 downto 0);
    signal bypass_data   : std_logic_vector(15 downto 0);

    signal pixel_column : unsigned(31 downto 0);
    signal pixel_row    : unsigned(31 downto 0);

    signal pixel_window : pixel_window_t;
    signal line_buffer  : line_buffer_t;

    signal products       : product_matrix_t;
    signal row_sums       : row_sum_array_t;
    signal convolution_sum: signed(31 downto 0);
    signal scaled_result  : signed(47 downto 0);

    signal valid_delay : pipeline_flags_t;
    signal last_delay  : pipeline_flags_t;

begin

    ---------------------------------------------------------------------------
    -- AXI4-Lite interface
    ---------------------------------------------------------------------------

    s_axi_lite_awready <= axi_awready_i;
    s_axi_lite_wready  <= axi_wready_i;
    s_axi_lite_bvalid  <= axi_bvalid_i;
    s_axi_lite_arready <= axi_arready_i;
    s_axi_lite_rvalid  <= axi_rvalid_i;

    s_axi_lite_bresp <= "00";
    s_axi_lite_rresp <= "00";

    read_addr <= s_axi_lite_araddr(C_S_AXI_ADDR_WIDTH-1 downto ADDR_LSB)
                 when s_axi_lite_arvalid = '1'
                 else stored_araddr(C_S_AXI_ADDR_WIDTH-1 downto ADDR_LSB);

    write_addr <= s_axi_lite_awaddr(C_S_AXI_ADDR_WIDTH-1 downto ADDR_LSB)
                  when s_axi_lite_awvalid = '1'
                  else stored_awaddr(C_S_AXI_ADDR_WIDTH-1 downto ADDR_LSB);

    write_enable <= '1'
                    when ((write_state = WRITE_ADDRESS and
                           s_axi_lite_awvalid = '1' and
                           s_axi_lite_wvalid = '1') or
                          (write_state = WRITE_DATA and
                           s_axi_lite_wvalid = '1'))
                    else '0';

    -- Register write logic
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                control_reg      <= (others => '0');
                radius_reg       <= (others => '0');
                image_width_reg  <= (others => '0');
                image_height_reg <= (others => '0');
                scale_reg        <= (others => '0');

                for index in coefficient_reg'range loop
                    coefficient_reg(index) <= (others => '0');
                end loop;
            elsif write_enable = '1' and s_axi_lite_wstrb(1 downto 0) = "11" then
                case write_addr is
                    when REG_CTRL_ADDR =>
                        control_reg <= s_axi_lite_wdata(15 downto 0);
                    when REG_RADIUS_ADDR =>
                        radius_reg <= s_axi_lite_wdata(15 downto 0);
                    when REG_IMG_W_ADDR =>
                        image_width_reg <= s_axi_lite_wdata(15 downto 0);
                    when REG_IMG_H_ADDR =>
                        image_height_reg <= s_axi_lite_wdata(15 downto 0);
                    when REG_COEFF_SCALE_ADDR =>
                        scale_reg <= s_axi_lite_wdata(15 downto 0);
                    when others =>
                        if unsigned(write_addr) >= unsigned(REG_COEFF_START_ADDR) and
                           unsigned(write_addr) < unsigned(REG_COEFF_START_ADDR) + COEFFICIENT_COUNT then
                            coefficient_reg(
                                to_integer(unsigned(write_addr) - unsigned(REG_COEFF_START_ADDR))
                            ) <= s_axi_lite_wdata(15 downto 0);
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Register read multiplexer
    process(read_addr, control_reg, radius_reg, image_width_reg,
            image_height_reg, scale_reg, coefficient_reg)
        variable coefficient_index : integer;
    begin
        s_axi_lite_rdata <= (others => '0');
        coefficient_index := to_integer(unsigned(read_addr) - unsigned(REG_COEFF_START_ADDR));

        case read_addr is
            when REG_CTRL_ADDR =>
                s_axi_lite_rdata(15 downto 0) <= control_reg;
            when REG_RADIUS_ADDR =>
                s_axi_lite_rdata(15 downto 0) <= radius_reg;
            when REG_IMG_W_ADDR =>
                s_axi_lite_rdata(15 downto 0) <= image_width_reg;
            when REG_IMG_H_ADDR =>
                s_axi_lite_rdata(15 downto 0) <= image_height_reg;
            when REG_COEFF_SCALE_ADDR =>
                s_axi_lite_rdata(15 downto 0) <= scale_reg;
            when others =>
                if coefficient_index >= 0 and coefficient_index < COEFFICIENT_COUNT then
                    s_axi_lite_rdata(15 downto 0) <= coefficient_reg(coefficient_index);
                end if;
        end case;
    end process;

    -- Read-channel state machine
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                axi_arready_i <= '0';
                axi_rvalid_i  <= '0';
                read_state    <= READ_ADDRESS;
            else
                case read_state is
                    when READ_ADDRESS =>
                        axi_arready_i <= '1';
                        if axi_arready_i = '1' and s_axi_lite_arvalid = '1' then
                            stored_araddr <= s_axi_lite_araddr;
                            axi_arready_i <= '0';
                            axi_rvalid_i  <= '1';
                            read_state    <= READ_DATA;
                        end if;

                    when READ_DATA =>
                        if s_axi_lite_rready = '1' and axi_rvalid_i = '1' then
                            axi_rvalid_i  <= '0';
                            axi_arready_i <= '1';
                            read_state    <= READ_ADDRESS;
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Write-channel state machine
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                axi_awready_i <= '0';
                axi_wready_i  <= '0';
                axi_bvalid_i  <= '0';
                write_state   <= WRITE_ADDRESS;
            else
                case write_state is
                    when WRITE_ADDRESS =>
                        axi_awready_i <= '1';
                        axi_wready_i  <= '1';

                        if axi_awready_i = '1' and s_axi_lite_awvalid = '1' then
                            stored_awaddr <= s_axi_lite_awaddr;

                            if axi_wready_i = '1' and s_axi_lite_wvalid = '1' then
                                axi_bvalid_i <= '1';

                                if s_axi_lite_bready = '0' then
                                    axi_awready_i <= '0';
                                    axi_wready_i  <= '0';
                                    write_state   <= WRITE_STALLED;
                                end if;
                            else
                                axi_awready_i <= '0';
                                write_state   <= WRITE_DATA;

                                if s_axi_lite_bready = '1' and axi_bvalid_i = '1' then
                                    axi_bvalid_i <= '0';
                                end if;
                            end if;
                        elsif s_axi_lite_bready = '1' and axi_bvalid_i = '1' then
                            axi_bvalid_i <= '0';
                        end if;

                    when WRITE_DATA =>
                        if axi_wready_i = '1' and s_axi_lite_wvalid = '1' then
                            axi_bvalid_i <= '1';

                            if s_axi_lite_bready = '0' then
                                axi_awready_i <= '0';
                                axi_wready_i  <= '0';
                                write_state   <= WRITE_STALLED;
                            else
                                axi_awready_i <= '1';
                                axi_wready_i  <= '1';
                                write_state   <= WRITE_ADDRESS;
                            end if;
                        elsif s_axi_lite_bready = '1' and axi_bvalid_i = '1' then
                            axi_bvalid_i <= '0';
                        end if;

                    when WRITE_STALLED =>
                        if s_axi_lite_bready = '1' and axi_bvalid_i = '1' then
                            axi_bvalid_i <= '0';
                            axi_awready_i <= '1';
                            axi_wready_i <= '1';
                            write_state <= WRITE_ADDRESS;
                        end if;
                end case;
            end if;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- AXI-Stream interface
    ---------------------------------------------------------------------------

    input_data  <= s_axis_data_in_tdata;
    input_valid <= s_axis_data_in_tvalid;
    input_last  <= s_axis_data_in_tlast;
    output_ready <= m_axis_data_out_tready;

    s_axis_data_in_tready  <= input_ready;
    m_axis_data_out_tdata  <= output_data;
    m_axis_data_out_tvalid <= output_valid;
    m_axis_data_out_tlast  <= output_last;

    input_ready <= '0' when reset = '1' else
                   output_ready when control_reg(1) = '1' else
                   m_axis_data_out_tready or (not output_valid);

    output_valid <= input_valid when control_reg(1) = '1' else valid_delay(PIPELINE_LENGTH-1);
    output_last  <= input_last  when control_reg(1) = '1' else last_delay(PIPELINE_LENGTH-1);

    bypass_data <= x"00" & input_data;
    output_data <= bypass_data when control_reg(1) = '1' else filtered_data;

    -- Input pixel position counters
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pixel_column <= (others => '0');
                pixel_row    <= (others => '0');
            elsif input_ready = '1' and input_valid = '1' then
                if pixel_column = unsigned(image_width_reg) - 1 then
                    pixel_column <= (others => '0');

                    if pixel_row = unsigned(image_height_reg) - 1 then
                        pixel_row <= (others => '0');
                    else
                        pixel_row <= pixel_row + 1;
                    end if;
                else
                    pixel_column <= pixel_column + 1;
                end if;
            end if;
        end if;
    end process;

    -- Pipeline control flags
    process(reset, clk)
    begin
        if reset = '1' then
            valid_delay <= (others => '0');
            last_delay  <= (others => '0');
        elsif rising_edge(clk) then
            if output_ready = '1' or output_valid = '0' then
                for stage in 1 to PIPELINE_LENGTH-1 loop
                    valid_delay(stage) <= valid_delay(stage-1);
                    last_delay(stage)  <= last_delay(stage-1);
                end loop;

                if pixel_row = unsigned(image_height_reg) - 1 and
                   pixel_column = unsigned(image_width_reg) - 1 and
                   input_valid = '1' and input_ready = '1' then
                    last_delay(0) <= '1';
                else
                    last_delay(0) <= '0';
                end if;

                if pixel_row >= 2 * unsigned(radius_reg) and
                   pixel_row <= unsigned(image_height_reg) - 1 and
                   pixel_column >= 2 * unsigned(radius_reg) and
                   pixel_column <= unsigned(image_width_reg) - 1 and
                   input_valid = '1' and input_ready = '1' then
                    valid_delay(0) <= '1';
                else
                    valid_delay(0) <= '0';
                end if;
            end if;
        end if;
    end process;

    ---------------------------------------------------------------------------
    -- Image-processing datapath
    ---------------------------------------------------------------------------

    -- Update the line buffer and the 9 x 9 pixel window
    process(reset, clk)
    begin
        if reset = '1' then
            pixel_window <= (others => (others => (others => '0')));
        elsif rising_edge(clk) then
            if input_ready = '1' and input_valid = '1' then
                for row_index in pixel_window'range loop
                    for column_index in WINDOW_LAST downto 1 loop
                        pixel_window(row_index)(column_index) <=
                            pixel_window(row_index)(column_index-1);
                    end loop;
                end loop;

                pixel_window(0)(0) <= input_data;
                pixel_window(1)(0) <= line_buffer(to_integer(pixel_column))(7 downto 0);
                pixel_window(2)(0) <= line_buffer(to_integer(pixel_column))(15 downto 8);
                pixel_window(3)(0) <= line_buffer(to_integer(pixel_column))(23 downto 16);
                pixel_window(4)(0) <= line_buffer(to_integer(pixel_column))(31 downto 24);
                pixel_window(5)(0) <= line_buffer(to_integer(pixel_column))(39 downto 32);
                pixel_window(6)(0) <= line_buffer(to_integer(pixel_column))(47 downto 40);
                pixel_window(7)(0) <= line_buffer(to_integer(pixel_column))(55 downto 48);
                pixel_window(8)(0) <= line_buffer(to_integer(pixel_column))(63 downto 56);

                line_buffer(to_integer(pixel_column)) <=
                    line_buffer(to_integer(pixel_column))(55 downto 0) & input_data;
            end if;
        end if;
    end process;

    -- Convolution arithmetic pipeline
    process(reset, clk)
        variable row_accumulator   : signed(27 downto 0);
        variable active_dimension : integer range 3 to WINDOW_SIZE;
        variable coefficient_index: integer range 0 to COEFFICIENT_COUNT-1;
    begin
        if reset = '1' then
            convolution_sum <= (others => '0');
            scaled_result   <= (others => '0');

            for row_index in products'range loop
                for column_index in products(row_index)'range loop
                    products(row_index)(column_index) <= (others => '0');
                end loop;
            end loop;
        elsif rising_edge(clk) then
            if output_ready = '1' or output_valid = '0' then
                active_dimension := to_integer(unsigned(radius_reg)) * 2 + 1;

                -- Register pixel-coefficient products
                for row_index in products'range loop
                    for column_index in products(row_index)'range loop
                        if row_index < active_dimension and column_index < active_dimension then
                            coefficient_index :=
                                (active_dimension * active_dimension - 1) -
                                (row_index * active_dimension + column_index);

                            products(row_index)(column_index) <=
                                signed('0' & pixel_window(row_index)(column_index)) *
                                signed(coefficient_reg(coefficient_index));
                        else
                            products(row_index)(column_index) <= (others => '0');
                        end if;
                    end loop;
                end loop;

                -- Accumulate each product row
                for row_index in row_sums'range loop
                    row_accumulator := (others => '0');
                    for column_index in products(row_index)'range loop
                        row_accumulator :=
                            row_accumulator + resize(products(row_index)(column_index), 28);
                    end loop;
                    row_sums(row_index) <= row_accumulator;
                end loop;

                -- Combine row sums and apply the output scale
                convolution_sum <= resize(row_sums(0), 32) + row_sums(1) + row_sums(2) +
                                   row_sums(3) + row_sums(4) + row_sums(5) +
                                   row_sums(6) + row_sums(7) + row_sums(8);

                scaled_result <= convolution_sum * signed(scale_reg);
            end if;
        end if;
    end process;

    -- Convert the fixed-point pipeline result to the selected output format
    process(clk)
        variable shifted_result : signed(47 downto 0);
    begin
        if rising_edge(clk) then
            if reset = '1' then
                filtered_data <= (others => '0');
            elsif control_reg(1) = '0' and
                  (output_ready = '1' or output_valid = '0') then
                if control_reg(0) = '0' then
                    shifted_result := shift_right(scaled_result, 27);

                    if shifted_result > PIXEL_MAX_VALUE then
                        filtered_data <= x"00FF";
                    elsif shifted_result < 0 then
                        filtered_data <= x"0000";
                    else
                        filtered_data <= x"00" & std_logic_vector(shifted_result(7 downto 0));
                    end if;
                else
                    shifted_result := shift_right(scaled_result, 20);
                    filtered_data <= std_logic_vector(resize(shifted_result, 16));
                end if;
            end if;
        end if;
    end process;

end Behavioral;