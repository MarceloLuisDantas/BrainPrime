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
addi $t0, $t0, 8
sb $t0, 0($t5)
# [
_1:
lb $t0, 0($t5)
beq $t0, $zero, *_1r
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 4
sb $t0, 0($t5)
# [
_2:
lb $t0, 0($t5)
beq $t0, $zero, *_2r
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 2
sb $t0, 0($t5)
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 3
sb $t0, 0($t5)
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 3
sb $t0, 0($t5)
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 1
sb $t0, 0($t5)
# <
subi $t5, $t5, 4
# -
lb $t0, 0($t5)
subi $t0, $t0, 1
sb $t0, 0($t5)
# ]
lb $t0, 0($t5)
bne $t0, $zero, *_2
_2r:
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 1
sb $t0, 0($t5)
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 1
sb $t0, 0($t5)
# >
addi $t5, $t5, 1
# -
lb $t0, 0($t5)
subi $t0, $t0, 1
sb $t0, 0($t5)
# >
addi $t5, $t5, 2
# +
lb $t0, 0($t5)
addi $t0, $t0, 1
sb $t0, 0($t5)
# [
_3:
lb $t0, 0($t5)
beq $t0, $zero, *_3r
# <
subi $t5, $t5, 1
# ]
lb $t0, 0($t5)
bne $t0, $zero, *_3
_3r:
# <
subi $t5, $t5, 1
# -
lb $t0, 0($t5)
subi $t0, $t0, 1
sb $t0, 0($t5)
# ]
lb $t0, 0($t5)
bne $t0, $zero, *_1
_1r:
# >
addi $t5, $t5, 2
# .
jal *_print_char
# >
addi $t5, $t5, 1
# -
lb $t0, 0($t5)
subi $t0, $t0, 3
sb $t0, 0($t5)
# .
jal *_print_char
# +
lb $t0, 0($t5)
addi $t0, $t0, 7
sb $t0, 0($t5)
# .
jal *_print_char
# .
jal *_print_char
# +
lb $t0, 0($t5)
addi $t0, $t0, 3
sb $t0, 0($t5)
# .
jal *_print_char
# >
addi $t5, $t5, 2
# .
jal *_print_char
# <
subi $t5, $t5, 1
# -
lb $t0, 0($t5)
subi $t0, $t0, 1
sb $t0, 0($t5)
# .
jal *_print_char
# <
subi $t5, $t5, 1
# .
jal *_print_char
# +
lb $t0, 0($t5)
addi $t0, $t0, 3
sb $t0, 0($t5)
# .
jal *_print_char
# -
lb $t0, 0($t5)
subi $t0, $t0, 6
sb $t0, 0($t5)
# .
jal *_print_char
# -
lb $t0, 0($t5)
subi $t0, $t0, 8
sb $t0, 0($t5)
# .
jal *_print_char
# >
addi $t5, $t5, 2
# +
lb $t0, 0($t5)
addi $t0, $t0, 1
sb $t0, 0($t5)
# .
jal *_print_char
# >
addi $t5, $t5, 1
# +
lb $t0, 0($t5)
addi $t0, $t0, 2
sb $t0, 0($t5)
# .
jal *_print_char
# loop
_loop:
li $sc, 100
syscall
j *_loop
