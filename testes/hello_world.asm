.text
j *_main
_print_char:
lb $t0, 0($t5)
sll $t0, $t0, 8
ori $t0, $t0, 16
svr $t0, 0($t4)
inc $t4
return
_main:
li $t5, 16
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# [
_1:
lb $t0, 0($t5)
beq $t0, $zero, *_1r
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# [
_2:
lb $t0, 0($t5)
beq $t0, $zero, *_2r
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# <
dec $t5
# <
dec $t5
# <
dec $t5
# <
dec $t5
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# ]
lb $t0, 0($t5)
bne $t0, $zero, *_2
_2r:
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# >
inc $t5
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# >
inc $t5
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# [
_3:
lb $t0, 0($t5)
beq $t0, $zero, *_3r
# <
dec $t5
# ]
lb $t0, 0($t5)
bne $t0, $zero, *_3
_3r:
# <
dec $t5
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# ]
lb $t0, 0($t5)
bne $t0, $zero, *_1
_1r:
# >
inc $t5
# >
inc $t5
# .
jal *_print_char
# >
inc $t5
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# .
jal *_print_char
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# .
jal *_print_char
# .
jal *_print_char
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# .
jal *_print_char
# >
inc $t5
# >
inc $t5
# .
jal *_print_char
# <
dec $t5
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# .
jal *_print_char
# <
dec $t5
# .
jal *_print_char
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# .
jal *_print_char
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# .
jal *_print_char
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# -
lb $t0, 0($t5)
dec $t0
sb $t0, 0($t5)
# .
jal *_print_char
# >
inc $t5
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# .
jal *_print_char
# >
inc $t5
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# +
lb $t0, 0($t5)
inc $t0
sb $t0, 0($t5)
# .
jal *_print_char
# loop
_loop:
li $sc, 100
syscall
j *_loop
