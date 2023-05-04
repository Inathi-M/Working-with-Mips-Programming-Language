.data 0x10000000
msg: .asciiz "Enter a sum:\n"
str: .space 1024
msg2: .asciiz "The value is:\n"

.text
.globl main
main:
	lui $s0,0x1000
	addi $s1,$s0,0x0 #address of msg in $s1
	addi $s2,$s0,0xe #address of str in $s2
	addi $s4,$s0,0x40e #address of msg2 in $s4
#print a string
	addi $v0,$0,4 #syscode 4 for printing a string
	addi $a0,$s1,0 #address in $a0
	syscall
#read a string
	addi $v0,$0,8
	addi $a0,$s1,0
	addi $a1,$0,1024
	syscall

	addi $t1,$s1,0 #address reserve
	addi $t2,$0,43 #+ ascii value
	addi $t4,$0,0 #for temp value
	addi $t5,$0,10 #formultiplication
	addi $s3,$0,0 #total sum
loop: lb $s2,0($t1)
	addi $t1,$t1,1
	beq $s2,$t5,done_sum #if it has \n then jump to done_sum
	sll $0,$0,0 #noop
	beq $s2,$t2,add_sum
	sll $0,$0,0 #no op
	addi $t3,$s2,-48
	mul $t4,$t4,$t5
	sll $0,$0,0 #no op
	add $t4,$t4,$t3
	j loop
sll $0,$0,0 #no op
add_sum:
	add $s3,$s3,$t4
	addi $t4,$0,0
j loop
sll $0,$0,0 #no op
done_sum:

         add $s3,$s3,$t4
	#print a message
	addi $a0,$s4,0
	addi $v0,$0,4
	syscall
	#print a sum value
	addi $v0,$0,1
	addi $a0,$s3,0
	syscall


#exit Code
addi $v0,$0,10
syscall
