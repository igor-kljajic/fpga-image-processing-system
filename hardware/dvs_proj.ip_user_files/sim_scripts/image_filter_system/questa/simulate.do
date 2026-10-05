onbreak {quit -f}
onerror {quit -f}

vsim  -lib work image_filter_system_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {image_filter_system.udo}

run 1000ns

quit -force
