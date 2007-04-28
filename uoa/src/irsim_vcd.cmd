

s 0

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


s 2000

assert memen x
assert memrwb x
assert memadr 0 0 0 x x x x x x x x x x x x x x x x x x x x x x x x x x x 0 0
assert membyteen x x x x



s 2000

l ph1


s 1000

h ph2


s 4000

l ph2


s 1000

h ph1


s 1000

assert memen x
assert memrwb x
assert memadr 0 0 0 x x x x x x x x x x x x x x x x x x x x x x x x x x x 0 0
assert membyteen x x x x



s 1000



s 2000

l ph1


s 1000

h ph2


s 4000

l ph2


s 1000

h ph1


s 1000

assert memen 0
assert memrwb 1
assert memadr 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
assert membyteen 0 0 0 1

