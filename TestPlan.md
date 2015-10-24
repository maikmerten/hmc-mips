# Introduction #

This page covers the testing status of all of the operations availible to the MIPS processor and reference assembly test file numbers where a given operaion is checked.  Test tracking for exceptions needs to be added as well.

# Details #

**Operation Tests**

| **Operation** | **Test where checked** |
|:--------------|:-----------------------|
| **Shifts**    |                        |
| sll           | 004                    |
| srl           | 004                    |
| sra           | 004                    |
| sllv          | 004                    |
| srlv          | 004                    |
| srav          | 004                    |
| **Moves**     |                        |
| mfhi          |       not yet implemented |
| mthi          |       not yet implemented |
| mflo          |       not yet implemented |
| mtlo          |       not yet implemented |
| **Arithmetic** |                        |
| mult          |       not yet implemented |
| multu         |      not yet implemented |
| div           |        not yet implemented |
| divu          |       not yet implemented |
| add           |        000             |
| addu          |       002              |
| sub           |        001             |
| subu          |       003              |
| and           |     001                |
| or            |     001                |
| xor           |     003                |
| nor           |     003                |
| slt           |     001                |
| sltu          |     003                |
| **Arithmetic Immediate** |                        |
| addi          |    000                 |
| addiu         |    002                 |
| slti          |    002                 |
| sltiu         |    002                 |
| andi          |    003                 |
| ori           |    002                 |
| xori          |    002                 |
| lui           |    002                 |
| **Jump/Branch** |                        |
| j             |      001               |
| jal           |      005               |
| beq           |      000               |
| bne           |      005               |
| blez          |      005               |
| bgtz          |      005               |
| bltz          |     005                |
| bgez          |      005               |
| jr            |      005               |
| jalr          |      005               |
| **Branch and Link** |                        |
| bltzal        |    005                 |
| bgezal        |    005                 |
| **Coprocessor** |                        |
| mfc0          |    006                 |
| mtc0          |    006                 |
| **Load Operations** |                        |
| lb            |     008                |
| lh            |    008                 |
| lw            |    001                 |
| lbu           |    008                 |
| lhu           |    008                 |
| **Store Operations** |                        |
| sb            |     007                |
| sh            |     007                |
| sw            |     000                |
| **Traps**     |                        |
| syscall       |  not yet tested        |
| break         |   not yet tested       |
| rfe           |     not yet implemented |
| **Other**     |                        |
| nop           |       -                |


**Exception Tests**

| Interrupt: Int |  |
|:---------------|:-|
| Address Error (Load): AdEL |  |
| Address Error (Store): AdES |  |
| Syscall        |  |
| Breakpoint: Bp |  |
| Reserved instruction: RI |  |
| Coprocessor unusable: CpU |  |
| Overflow: Ov   |  |


**Corner Case Tests**

Overflows:
  * Largest positve and negative numbers allowed do not overflow
  * Largest positive/negative numbers plus/minus 1 do overflow
  * Test for commands add, sub, addi

Stalls:
  * Test for proper stalls (lw in particular, also mult/div)

Branch Delays:
  * Test branches in branch delay slots
  * Test stalls in branch delay slots
  * Test exceptions in branch delay slots (make sure returns from exceptions work properly)
