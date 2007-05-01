
stepsize 10000000

vector interrupts interrupts[7] interrupts[6] interrupts[5] interrupts[4] interrupts[3] interrupts[2] interrupts[1] interrupts[0]

vector memadr memadr[28] memadr[27] memadr[26] memadr[25] memadr[24] memadr[23] memadr[22] memadr[21] memadr[20] memadr[19] memadr[18] memadr[17] memadr[16] memadr[15] memadr[14] memadr[13] memadr[12] memadr[11] memadr[10] memadr[9] memadr[8] memadr[7] memadr[6] memadr[5] memadr[4] memadr[3] memadr[2]

vector memdata memdata[31] memdata[30] memdata[29] memdata[28] memdata[27] memdata[26] memdata[25] memdata[24] memdata[23] memdata[22] memdata[21] memdata[20] memdata[19] memdata[18] memdata[17] memdata[16] memdata[15] memdata[14] memdata[13] memdata[12] memdata[11] memdata[10] memdata[9] memdata[8] memdata[7] memdata[6] memdata[5] memdata[4] memdata[3] memdata[2] memdata[1] memdata[0]

vector membyteen membyteen[3] membyteen[2] membyteen[1] membyteen[0]

ana ph1
ana ph2
ana memen
ana memrwb
ana memdata
ana membyteen
ana memadr


u memdata[0]
u memdata[1]
u memdata[2]
u memdata[3]
u memdata[4]
u memdata[5]
u memdata[6]
u memdata[7]
u memdata[8]
u memdata[9]
u memdata[10]
u memdata[11]
u memdata[12]
u memdata[13]
u memdata[14]
u memdata[15]
u memdata[16]
u memdata[17]
u memdata[18]
u memdata[19]
u memdata[20]
u memdata[21]
u memdata[22]
u memdata[23]
u memdata[24]
u memdata[25]
u memdata[26]
u memdata[27]
u memdata[28]
u memdata[29]
u memdata[30]
u memdata[31]
h memdone
l interrupts[0]
l interrupts[1]
l interrupts[2]
l interrupts[3]
l interrupts[4]
l interrupts[5]
l interrupts[6]
l interrupts[7]
h reset
u ph2
h ph1
assert memen x
assert memrwb x
assert memadr xxxxxxxxxxxxxxxxxxxxxxxxxxx
assert membyteen xxxx



s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen x
assert memrwb x
assert memadr xxxxxxxxxxxxxxxxxxxxxxxxxxx
assert membyteen xxxx



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[19]
l memdata[20]
l memdata[21]
l memdata[22]
l memdata[23]
l memdata[24]
l memdata[25]
l memdata[26]
l memdata[27]
l memdata[28]
h memdata[29]
l memdata[30]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001

l reset


s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[16]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000001
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[16]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[4]
h memdata[16]
l memdata[17]
h memdata[18]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000010
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[4]
l memdata[16]
h memdata[17]
l memdata[18]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[16]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[16]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[12]
l memdata[17]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[12]
h memdata[17]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[11]
h memdata[12]
l memdata[17]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[11]
l memdata[12]
h memdata[17]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
l memdata[17]
h memdata[18]
h memdata[22]
h memdata[26]
h memdata[27]
h memdata[31]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001010
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
h memdata[17]
l memdata[18]
l memdata[22]
l memdata[26]
l memdata[27]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 1



s 1

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

u memdata[29]
u memdata[17]
u memdata[4]
u memdata[2]
u memdata[0]
u memdata[31]
u memdata[31]
u memdata[30]
u memdata[29]
u memdata[28]
u memdata[27]
u memdata[26]
u memdata[25]
u memdata[24]
u memdata[23]
u memdata[22]
u memdata[21]
u memdata[20]
u memdata[19]
u memdata[18]
u memdata[17]
u memdata[16]
u memdata[15]
u memdata[14]
u memdata[13]
u memdata[12]
u memdata[11]
u memdata[10]
u memdata[9]
u memdata[8]
u memdata[7]
u memdata[6]
u memdata[5]
u memdata[4]
u memdata[3]
u memdata[2]
u memdata[1]
u memdata[0]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memdata 00000000000000000000000000010101
assert memen 1
assert memrwb 0
assert memadr 000000000000000000000000101
assert membyteen 1111



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[19]
l memdata[20]
l memdata[21]
l memdata[22]
l memdata[23]
l memdata[24]
l memdata[25]
l memdata[26]
l memdata[27]
l memdata[28]
h memdata[29]
l memdata[30]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[1]
h memdata[2]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001011
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[1]
l memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h memdata[0]
h memdata[2]
h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001

h reset


s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 3

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001

l reset


s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[3]
h memdata[16]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000001
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[3]
l memdata[16]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
h memdata[16]
h memdata[18]
h memdata[21]
h memdata[22]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000010
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
l memdata[16]
l memdata[18]
l memdata[21]
l memdata[22]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[5]
h memdata[13]
h memdata[21]
h memdata[22]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000011
assert membyteen 0001



s 1



s 1

l memdata[5]
l memdata[13]
l memdata[21]
l memdata[22]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[5]
h memdata[11]
h memdata[13]
l memdata[17]
h memdata[18]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000100
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[5]
l memdata[11]
l memdata[13]
h memdata[17]
l memdata[18]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
h memdata[5]
h memdata[11]
h memdata[13]
l memdata[17]
h memdata[18]
h memdata[21]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000101
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
l memdata[5]
l memdata[11]
l memdata[13]
h memdata[17]
l memdata[18]
l memdata[21]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[3]
h memdata[16]
h memdata[18]
h memdata[21]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000110
assert membyteen 0001



s 1



s 1

l memdata[3]
l memdata[16]
l memdata[18]
l memdata[21]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000000111
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[1]
l memdata[2]
h memdata[3]
h memdata[5]
h memdata[13]
l memdata[17]
h memdata[18]
h memdata[21]
h memdata[22]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001000
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
l memdata[3]
l memdata[5]
l memdata[13]
h memdata[17]
l memdata[18]
l memdata[21]
l memdata[22]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[1]
l memdata[2]
l memdata[17]
h memdata[23]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001001
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
h memdata[17]
l memdata[23]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 2



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001010
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[1]
l memdata[2]
h memdata[3]
h memdata[5]
h memdata[13]
h memdata[21]
h memdata[22]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001100
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
l memdata[3]
l memdata[5]
l memdata[13]
l memdata[21]
l memdata[22]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
h memdata[5]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[16]
l memdata[17]
h memdata[18]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001101
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
l memdata[5]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[1]
l memdata[2]
h memdata[5]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[21]
h memdata[22]
h memdata[23]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001110
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
l memdata[5]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[21]
l memdata[22]
l memdata[23]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[16]
h memdata[18]
h memdata[21]
h memdata[22]
h memdata[26]
h memdata[27]
h memdata[31]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000001111
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[16]
l memdata[18]
l memdata[21]
l memdata[22]
l memdata[26]
l memdata[27]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
h memdata[9]
h memdata[26]
h memdata[27]
l memdata[29]
h memdata[31]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010000
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
l memdata[9]
l memdata[26]
l memdata[27]
h memdata[29]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[1]
l memdata[2]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010001
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
h memdata[17]
l memdata[28]
h memdata[29]


s 1



s 1

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

u memdata[29]
u memdata[17]
u memdata[1]
u memdata[31]
u memdata[31]
u memdata[30]
u memdata[29]
u memdata[28]
u memdata[27]
u memdata[26]
u memdata[25]
u memdata[24]
u memdata[23]
u memdata[22]
u memdata[21]
u memdata[20]
u memdata[19]
u memdata[18]
u memdata[17]
u memdata[16]
u memdata[15]
u memdata[14]
u memdata[13]
u memdata[12]
u memdata[11]
u memdata[10]
u memdata[9]
u memdata[8]
u memdata[7]
u memdata[6]
u memdata[5]
u memdata[4]
u memdata[3]
u memdata[2]
u memdata[1]
u memdata[0]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memdata 00000000000000000000000000000111
assert memen 1
assert memrwb 0
assert memadr 000000000000000000010000000
assert membyteen 1111



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[19]
l memdata[20]
l memdata[21]
l memdata[22]
l memdata[23]
l memdata[24]
l memdata[25]
l memdata[26]
l memdata[27]
l memdata[28]
h memdata[29]
l memdata[30]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010010
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
h memdata[9]
h memdata[26]
h memdata[27]
h memdata[31]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010100
assert membyteen 0001



s 1



s 1

h memdata[0]
l memdata[9]
l memdata[26]
l memdata[27]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010101
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1



s 1



s 1

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010110
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[17]
h memdata[29]


s 1



s 1

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

u memdata[29]
u memdata[17]
u memdata[1]
u memdata[31]
u memdata[31]
u memdata[30]
u memdata[29]
u memdata[28]
u memdata[27]
u memdata[26]
u memdata[25]
u memdata[24]
u memdata[23]
u memdata[22]
u memdata[21]
u memdata[20]
u memdata[19]
u memdata[18]
u memdata[17]
u memdata[16]
u memdata[15]
u memdata[14]
u memdata[13]
u memdata[12]
u memdata[11]
u memdata[10]
u memdata[9]
u memdata[8]
u memdata[7]
u memdata[6]
u memdata[5]
u memdata[4]
u memdata[3]
u memdata[2]
u memdata[1]
u memdata[0]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memdata 00000000000000000000000000000111
assert memen 1
assert memrwb 0
assert memadr 000000000000000000010000001
assert membyteen 1111



s 1



s 1

h memdata[0]
l memdata[1]
h memdata[2]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
l memdata[16]
h memdata[17]
l memdata[18]
l memdata[19]
l memdata[20]
l memdata[21]
l memdata[22]
l memdata[23]
l memdata[24]
l memdata[25]
l memdata[26]
l memdata[27]
l memdata[28]
h memdata[29]
l memdata[30]
l memdata[31]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010101
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010110
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

h memdata[1]
h memdata[3]
h memdata[4]
h memdata[5]
h memdata[6]
h memdata[7]
h memdata[8]
h memdata[9]
h memdata[10]
h memdata[11]
h memdata[12]
h memdata[13]
h memdata[14]
h memdata[15]
l memdata[17]
h memdata[28]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010101
assert membyteen 0001



s 1



s 1

l memdata[1]
l memdata[3]
l memdata[4]
l memdata[5]
l memdata[6]
l memdata[7]
l memdata[8]
l memdata[9]
l memdata[10]
l memdata[11]
l memdata[12]
l memdata[13]
l memdata[14]
l memdata[15]
h memdata[17]
l memdata[28]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 4

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001



s 1



s 1

l memdata[0]
l memdata[2]
l memdata[17]
l memdata[29]


s 2

l ph1


s 1

h ph2


s 1



s 3

l ph2


s 1

h ph1
assert memen 1
assert memrwb 1
assert memadr 111111100000000000000010110
assert membyteen 0001



s 1



s 1

h memdata[0]
h memdata[2]
h memdata[17]
h memdata[29]


s 2

l ph1


s 1

h ph2


s 4

l ph2


s 1

h ph1
assert memen 0
assert memrwb 1
assert memadr 000000000000000000000000000
assert membyteen 0001
