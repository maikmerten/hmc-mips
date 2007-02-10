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
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/rsD
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/rtD
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/rsE
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/rtE
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/writeregE
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/writeregM
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/writeregW
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/regwriteE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/regwriteM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/regwriteW
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/memtoregE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/memtoregM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/memwriteM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/branchD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/jumpregD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/instrackF
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/dataackM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/exception
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/hiloaccessD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/mdrunE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/activeexception
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/memstallexception
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/executecleared
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/multdivDE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/datamissM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/instrmissF
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/branchstallD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/lwstallD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/brstallexception
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/flushD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/stallW
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/flushM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/stallM
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/stallE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/stallD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/stallF
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/forwardbE
add wave -noupdate -format Literal /testbench/dut/mips/dp/h/forwardaE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/forwardbD
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/flushE
add wave -noupdate -format Logic /testbench/dut/mips/dp/h/forwardaD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45158758 ps} 0}
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
WaveRestoreZoom {45110186 ps} {45207330 ps}
