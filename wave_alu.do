onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /testbench/clk
add wave -noupdate -format Logic -radix hexadecimal /testbench/reset
add wave -noupdate -format Literal -radix hexadecimal /testbench/writedata
add wave -noupdate -format Literal -radix hexadecimal /testbench/dataadr
add wave -noupdate -format Logic -radix hexadecimal /testbench/memwrite
add wave -noupdate -format Literal /testbench/dut/dcache/RAM
add wave -noupdate -format Literal /testbench/dut/dcache/byteen
add wave -noupdate -format Logic /testbench/dut/mips/dp/stallF
add wave -noupdate -format Logic /testbench/dut/mips/dp/stallD
add wave -noupdate -format Logic -radix hexadecimal /testbench/dut/mips/dp/pcsrcFD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/pcnextFD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/pcnextbrFD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/pcF
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/instrF
add wave -noupdate -format Logic /testbench/dut/mips/jumpD
add wave -noupdate -format Logic /testbench/dut/mips/dp/flushE
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/srca2D
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/srcb2D
add wave -noupdate -format Logic /testbench/dut/mips/dp/forwardaD
add wave -noupdate -format Logic /testbench/dut/mips/dp/forwardbD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/alu/a
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/alu/b
add wave -noupdate -format Literal /testbench/dut/mips/dp/aluoutsrcE
add wave -noupdate -format Literal /testbench/dut/mips/dp/alu/control
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/alu/aluresult
add wave -noupdate -format Logic /testbench/dut/mips/dp/jumpD
add wave -noupdate -format Logic /testbench/dut/mips/dp/branchD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/pcbranchsrcD
add wave -noupdate -format Logic /testbench/dut/mips/dp/rdsrcD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/rf/rd1
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/rf/rd2
add wave -noupdate -format Logic /testbench/dut/mips/dp/rdsrcD
add wave -noupdate -format Literal {/testbench/dut/mips/dp/rf/rf[31]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[7]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[6]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[5]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[4]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[3]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[2]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/rf/rf[1]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7075934 ps} 0}
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
WaveRestoreZoom {6988719 ps} {7156719 ps}
