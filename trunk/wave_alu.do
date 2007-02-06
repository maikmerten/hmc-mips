onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/ph1
add wave -noupdate -format Logic /testbench/ph2
add wave -noupdate -format Logic -radix hexadecimal /testbench/reset
add wave -noupdate -format Logic /testbench/dut/mips/cop0/exception
add wave -noupdate -format Literal -radix hexadecimal /testbench/writedata
add wave -noupdate -format Literal -radix hexadecimal /testbench/dataadr
add wave -noupdate -format Logic -radix hexadecimal /testbench/memwrite
add wave -noupdate -format Logic /testbench/dut/mips/dp/stallF
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/pcF
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/instrF
add wave -noupdate -format Literal /testbench/dut/mips/dp/aluoutsrcE
add wave -noupdate -format Logic /testbench/dut/mips/dp/jumpD
add wave -noupdate -format Logic /testbench/dut/mips/dp/branchD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16971000 ps} 0}
configure wave -namecolwidth 256
configure wave -valuecolwidth 73
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ps} {26250 ns}
