.data
	pro: .asciiz "Enter n and formulae:\n"
	out: .asciiz "The values are:\n"
	space: .asciiz "\n"
	inBuffer: .space 20000
	.align 2
	Array: .space 20000
	
.text
main:

	#prompt user to enter input
	li $v0, 4
	la $a0, pro 
	syscall
	

	li $v0, 5 	
	syscall
	
	
	move $s0, $v0	
	
	addi $t0, $zero, 0	
	addi $t1, $zero, 0 	
	addi $t3, $zero, 0	
	
readerLoop:
	beq $t0, $s0, then

	li $v0, 5 		
	syscall
	
	move $t2, $v0
	sw $t2, Array($t1)
	
	add $t3, $t3, $t2
	
	addi $t0, $t0, 1	
	addi $t1, $t1, 4	
	
	j readerLoop
	
then:
	li $v0, 4
	la $a0, out 
	syscall
	
	addi $t0, $zero, 0	
	addi $t1, $zero, 0 	
	
outputLoop:
	beq $t0, $s0, print
	
	lw $t4, Array($t1)
	
	li $v0, 1
	move $a0, $t4
	syscall
	li $v0, 4
	la $a0, space 
	syscall
	
	addi $t0, $t0, 1
	addi $t1, $t1, 4	
	
	j outputLoop

print:
	li $v0, 1
	move $a0, $t3
	syscall
	
exit:
	
	li $v0, 10
	syscall
