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
add wave -noupdate -format Logic /testbench/dut/mips/dp/decodestage/aeqbD
add wave -noupdate -format Logic /testbench/dut/mips/dp/decodestage/aeqzD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/decodestage/pcnextbrFD
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/fetchstage/pcnextF
add wave -noupdate -format Literal -radix hexadecimal /testbench/dut/mips/dp/instrD
add wave -noupdate -format Literal /testbench/dut/mips/dp/aluoutsrcE
add wave -noupdate -format Logic /testbench/dut/mips/dp/jumpD
add wave -noupdate -format Logic /testbench/dut/mips/dp/branchD
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[31]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[7]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[6]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[5]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[4]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[3]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[2]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[1]}
add wave -noupdate -format Literal -radix hexadecimal {/testbench/dut/mips/dp/decodestage/rf/rf[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {310373 ps} 0}
configure wave -namecolwidth 294
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
WaveRestoreZoom {246605 ps} {343748 ps}
