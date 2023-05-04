    .data
    .align 2
array:      .space  140
size:       .word   80
string:     .space  20000     
op:         .asciiz "Enter n, followed by n lines of text: \n"
text:       .asciiz "The values are: \n"


    .text
    .globl main
main:
    # prompt user for array length
    li      $v0,4
    la      $a0,op
    syscall


    # read in array count
    li      $v0,5
    syscall
    addi    $s0,$v0,0           # $v0 contains the integer we read

    add     $t0,$zero,$zero     # index of array
    addi    $t1,$zero,1         # counter=1
    la      $s2,string          # load address of string storage area [NEW]

read_string:
    bgt     $t1,$s0,L1          # if ($t1 > length) then array is done -- fly

   

    # get the string
### la      $a0,string          # place to store string [OLD]
    move    $a0,$s2             # place to store string [NEW]
    li      $a1,20
    li      $v0,8
    syscall

    # store pointer to string into array
    sw      $a0,array($t0)

    addi    $t0,$t0,4           # advance offset into pointer array
    addi    $t1,$t1,1           # advance iteration count
    addi    $s2,$s2,20          # advance to next string area [NEW]

    j       read_string

#### here i want to print the array ####
L1:
    add     $t0,$zero,$zero     # index of array
    addi    $t1,$zero,1         # counter = 1

    # output the title
    la      $a0,text
    li      $v0,4
    syscall
    mul $t5,$s0,4
    addi $t0,$t5,-4
    


while:
    bgt     $t1,$s0,done        # more strings to output?  if no, fly
    lw      $t2,array($t0)      # get pointer to string

    # output the string
    li      $v0,4
    move    $a0,$t2
    syscall
  

    addi    $t0,$t0,-4           # advance array index
    addi    $t1,$t1,1           # advance count
    j       while

# new_line -- output a newline char


# program is done
done:
    li      $v0,10
    syscall
