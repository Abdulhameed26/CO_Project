.data
	Chioses: .asciiz "For bubble sort for integer enter 1\nfor selection sort for integer enter 2\nfor bubble sort for char enter 3\n"
	space:              .asciiz " "         # a space string.
    	newline:            .asciiz "\n"        # a newline string.
    	colonsp:            .asciiz ": "        # a colon string with space.
    	array:              .word   0 : 1000    # an array of word, for storing values.
    	size:               .word    5           # actual count of the elements in the array.
    	params_info_str:    .asciiz "Input number of values to be sorted (0 < N < 1000): "
    	instruct:           .asciiz "Input value for each iteration: \n"
    	input_values_loop_iter_string:      .asciiz "Your Input value # "
    	sorted_array_string:                .asciiz "Sorted:\n"
	msg_inputList:      .asciiz "Please enter positive numbers in ascending order and a 0 to terminate\n"
	msg_searchList:     .asciiz "Please enter a number to initSearch for\n"
	msg_YES:            .asciiz " - YES\n"
	msg_NO:             .asciiz " - NO\n"
	receive_values_loop_iter_string:    .asciiz "Input value#"
    unsorted_array_string:              .asciiz "Unsorted:\n"

    getArray:	.asciiz "Enter Values To Array Line By Line\n"
	setArraysize:	.asciiz "Enter size of Array\n"

     arraysizeinBytes:	.asciiz "size of Array In bytes: "
	arraysize:	.asciiz "size of Array: "
	
	
	label:		.asciiz "Enter Value here\nPress 0 if You Want bubble sort\nPress 1 if You Want Selection sort\nPress 2 if You Want Merge sort\n"
	zero: 		.asciiz "bubble sort has selected\n"
	one:  		.asciiz "Selection sort has selected\n"
	two:  		.asciiz "Merge sort has selected\n"
	def:  		.asciiz "Not valid re-enter your value\n\n\n"
	

	
	len:		.asciiz "len: "
	counter:	.asciiz "counter: "
.text
        #main function#############################################################################
	main:
	# assign 3 variable 1 ,2 and 3 to select a algoritham we do
	addi $t0,$zero,1         #t0 = 1 to do bubble sort 
	addi $t1,$zero,2         #t1 = 2 to do selection sort
	addi $t3,$zero,3         #t3 = 3 to do binary search
	# to tell system we will print a string
	li $v0,4                 
	la $a0,Chioses         # print message For bubble sort enter 1\nfor selection sort enter 2\nfor binary search enter 3\n
	syscall                # run 
	li $v0,5               # scan integer from user 
	syscall                #run
	move $t2,$v0           #move user input to t2 to can acsess it directly
	beq $t0,$t2,bub        #branch if equal (if user input equal 1 i will do bubble sort)
	beq $t1,$t2,sel        #branch if equal (if user input equal 2 i will do selection sort)
	beq $t3,$t2,bubble_chars  #branch if equal (if user input equal 3 i will do binary search)
	jal exit               # call function exit to exit my program
	jal exit
	#bubble sort#############################################################################
	bub:                   #function bubble sort 
	params_info:
        li  $v0, 4             
        la  $a0, params_info_str    #print message Input number of values to be sorted (0 < N < 1000):
        syscall               	     #run						
    	
    	params:
        li  $v0, 5               # scan integer from user (number of element we will sort)
        syscall                 #run
        la  $t0, size           # load address of size to $t0.
        sw  $v0, 0($t0)         # store returned value in $v0 to size.
    	
    	receive_values_loop_info:
        li  $v0, 4              
        la  $a0, instruct       #print message Input value for each iteration: \n
        syscall                 #run
        
    	receive_values_loop_prep:
        la  $t0, array          # load array to $t0.
        lw  $t1, size           # load size to $t1.
        li  $t2, 0              # loop runner, starting from 0.
    	
    	input_values_loop:
        bge $t2, $t1, input_values_end    # while ($t2 < $t1).
        li  $v0, 4
        la  $a0, input_values_loop_iter_string       #Your Input value #
        syscall                   #run
        li  $v0, 1               #system ready to print integer
        addi $a0, $t2, 1        # counter 
        syscall                  #run
        li  $v0, 4          
        la  $a0, colonsp      #print message : 
        syscall              #run

        li  $v0, 5          
        syscall                  #run
        sw  $v0, 0($t0)         # store returned value from syscall in the array.
        addi    $t0, $t0, 4     # increment array pointer by 4.
        addi    $t2, $t2, 1     # increment loop runner by 1.
        j   input_values_loop   # jump back to the beginning of the loop.

    input_values_end:
    
    jal Bubble_Sort

        li  $v0, 4              
        la  $a0, sorted_array_string    #print message Sorted:\n
        syscall                         #run
        li  $v0, 4          
        la  $a0, newline        # load line to argument register $a0.
        syscall                 #run
        jal print               # call print routine.
        j exit                  # call function exit to exit my program
        Bubble_Sort:
    
    
    
    
    
    
    sort_prep:
        la  $t0, array              # load array to $t0.                 
        lw $t2, size
        add $t2, $t2, -1            # load array size to $t1.
        li  $t1, 0                  # outer loop iter t1

    sort_xloop:                     
        la  $t0, array
        bge $t1,$t2, sort_xloop_end # while (t2 < $t1).

        li $t3, 0                   # inner loop iter t3
        lw $t4, size
        addi $t4, $t4, -1
        sub $t4, $t4, $t1
        
        sort_iloop:                
            bge $t3, $t4, sort_iloop_end

            mul $t5, $t3, 4
            add $t5, $t5, $t0  

            mul $t6, $t3, 4
            add $t6, $t6, $t0
            addi $t6, $t6, 4

            add $a0, $t5, $zero
            add $a1, $t6, $zero
            lw $s2, ($a0)
            lw $s3, ($a1)
            bgt $s2, $s3, swap      # if a[j]>a[j+1] then swap
            L1:
            addi $t3, $t3, 1
            j   sort_iloop          # jump back to the beginning of the sort_iloop.

        sort_iloop_end:
            addi $t1, $t1, 1        # increment loop runner by 1.
            j sort_xloop            # jump back to the beginning of the sort_xloop.

    sort_xloop_end:
        jr $ra








   swap: 
        lw $s0, 0($a0)
        lw $s1, 0($a1)
        
        sw $s0, 0($a1)              # Switching the elements
        sw $s1, 0($a0)
        j L1


print:
    print_loop_prep:
        la  $t0, array
        lw  $t1, size
        li  $t2, 0
    print_loop:
        bge $t2, $t1, print_end
        li  $v0, 1
        lw  $a0, 0($t0)
        syscall             #run
        li  $v0, 4
        la  $a0, space      #print space
        syscall             #run
        addi    $t0, $t0, 4
        addi    $t2, $t2, 1
        j   print_loop      
    print_end:
        li  $v0, 4
        la  $a0, newline     #print new line
        syscall              #run
        jr  $ra
        jal exit           # call function exit to exit my program
		
	
		
			
				
					
						
							
								
									
							#----------------------------------------------- Selection  Sort -------------------------#			
											
												
													
														
															
																	
	sel:


   jal params_info
    jal params
    jal receive_values_loop_info
                                #             
        li  $v0, 4              # print new line
        la  $a0, newline       
        syscall             

###      input loop
    jal receive_values_loop_prep
    receive_values_loop:
        bge $t2, $t1, receive_values_end    # while ($t2 < $t1).
        li  $v0, 4              # prompt at every iteration during input
        la  $a0, receive_values_loop_iter_string 
        syscall             
        li  $v0, 1          
        addi    $a0, $t2, 1     # load (iter + 1) to argument register $a0.
        syscall             
        li  $v0, 4          
        la  $a0, colonsp        
        syscall             

        li  $v0, 5          
        syscall                 # USER INPUT
        sw  $v0, 0($t0)         # store the user input in the array.
        addi    $t0, $t0, 4     # increment array pointer by 4.
        addi    $t2, $t2, 1     # increment loop iter by 1.
        j receive_values_loop   # jump back to the beginning of the loop.

    receive_values_end:
        la $a0, unsorted_array_string
        li $v0, 4
        syscall
        jal print               # printing user input values

        jal selectionSort
        jal print
        j exit


###  Selection sort
#-----------------------------------selection Sort------------------------------------------#
	
	li	$t2,0
	
	
	#	$t0	=	size	*	4	= 	n	bytes
	
		
	
selectionSort:		
			
		add	$s0,$t2,0	#	Min
		add	$s1,$t2,4	#	j	Counter of InnerLoop
		
		
		# li	$v0,4
		# la	$a0,space
		# syscall
	
		# li 	$v0,1
		# move	$a0,$t2
		# syscall
		
		# li	$v0,4
		# la	$a0,newline
		# syscall
		
		
		
	InnerSelection:		bge	$s1,$t0,endInner
		lw	$s3,array($s0)
		lw	$s4,array($s1)
		
		slt	$s2,$s4,$s3
		beq	$s2,0,skpCondition	
			add	$s0,$s1,0
		skpCondition:
	add	$s1,$s1,4
	j	InnerSelection
	endInner:
		
		
		lw	$s6,array($s0)
		lw	$s7,array($t2)
		
		
		
		
		sw	$s6,array($t2)
		sw	$s7,array($s0)
		
		
	
	add	$t2,$t2,4
	j	selectionSort




	



#--------------------------------------------------------------------------#
  

exit:
    li  $v0, 10                 # 10 = exit syscall.
    syscall                     # issue a system call.

###       Printing
jal print



				# Bubble Chars


bubble_chars:

.data
	prompt: .asciiz  "\n\nEnter up to 10 characters: "  # Prompt asking for user input
	newLine: .asciiz "\n"                               # Newline character
	theString: .asciiz "           "                    # A ten character string initially filled with whitespace


.text 
    la $a0, prompt   # Load address of prompt from memory into $a0
    li $v0, 4        # Load Opcode: 4 (print string) 
    syscall          # Init syscall


    
    #  Read User Input into address of theString
    la $a0,theString  # Load address of theString into syscall argument a0
    li $a1,11         # Load sizeOfInput+1 into syscall argument a1
    li $v0,8          # Load Opcode: 8 (Read String)
    syscall

    #  Define total num of chars
    li $s7,10           # s7 upper index

    #  Call procedures 
    jal uppercase  
    jal sort
    jal print_chars
    j exit




  #Loops through the ten elements of chars gathered from user input and if ascii is in range between 97  and 122, it will subtract 32 and store back

uppercase:

    la $s0, theString    # Load base address to theString into $t0
    add $t6,$zero,$zero  # Set index i = 0 ($t6)



    lupper:
        #  Check for sentinal val and if true
        #  branch to done to jump back to ra
 
        beq $t6,$s7,done 

        #  Load Array[i]
        add $s2,$s0,$t6 #
        lb  $t1,0($s2)

        #  if char is within lowercase 
        #  range.
        
        sgt  $t2,$t1,96
        slti $t3,$t1,123
        and $t3,$t2,$t3
     
        #  else, don't store byte
        
        beq $t3,$zero,isUpper
        addi $t1,$t1,-32
        sb   $t1, 0($s2)

        isUpper:

        addi $t6,$t6,1
        j lupper


sort:   
  
    add $t0,$zero,$zero 
 
    loop:

        beq $t0,$s7,done

        sub $t7,$s7,$t0
        addi $t7,$t7,-1


        add $t1,$zero,$zero


        jLoop:

            beq $t1,$t7,continue

            add $t6,$s0,$t1
            lb  $s1,0($t6)
            lb  $s2,1($t6)

            sgt $t2, $s1,$s2
            beq $t2, $zero, good
            sb  $s2,0($t6)
            sb  $s1,1($t6)

            good:
            addi $t1,$t1,1
            j jLoop

        continue:
        addi $t0,$t0,1
        j loop

print_chars:

    la $a0,newLine
    li $v0,4
    syscall 
    add $t6,$zero,$zero # Set index i = 0 $t6

    lprint:
        beq $t6,$s7,done  
        add $t1,$s0,$t6 
        lb $a0, 0($t1)  # Load argument
        li $v0, 11      # Load opcode
        syscall         # Call syscall
        addi $t6,$t6,1  
        j lprint

done:
    jr $ra

jal exit
















#######################################################################################################################################
#					.data

#msg_iputsize:		.asciiz " enter number of items\n"
#msg_inputitems:		.asciiz " enter ordered chars accoreding to ascii values\n"
#theString: 			.asciiz "                              "
#prompt: 			.asciiz  "\n\nEnter up to 10 characters: "
#msg_found:          .asciiz " - FOUND\n"
#msg_notfound:       .asciiz " - NOTFOUND\n"

#					.text

#main:				li 		$v0, 4 
#					la 		$a0, msg_inputsize
#					syscall
					
#					li		$v0, 5
#					syscall
#					move 	$s3,$v0
					
#					li 		$v0, 4 
					
#					la 		$a0, prompt   
				      
#					syscall  
#					la	    $s1,theString  
#					li      $a1,11         
#					li      $v0,8          
#					syscall			
#					
#	
#
#
#search:                                                  
#					la 		$s1, theString
#					add 	$s5,  theString,$s3   


#splitStep:

#					move    $s6, $s1                
#					move    $s7, $s5                
#					move    $t0, $s4                
#					move    $t9, $s4    
#					li      $v1, 2      
#					div     $t9, $v1    
#					mflo    $t9         
#					add     $t9, $t9, $v1
    


#checkHigher:
#					li      $v1, 2  
#					div     $t0, $v1
#					mflo    $v1     
#					mflo    $t0     
#
#					blez    $t0, remainderStep    
#    
#					j       loopCheck 
    

#checkLower:
#					li      $v1, 2    
#					div     $t0, $v1  
#					mflo    $v1       
#					mflo    $t0       
#					mfhi    $t1       

#					blez    $t0, failStep 
    
#					j       loopCheck     
    


#failStep:
					blez    $t1, no           
    


#loopCheck:
#					beq     $s6, $s7, no   
#					blez    $t9, no        

#					mul     $v1, $t0, 1    
#					add     $t4, $s6, $v1  

#					lw      $a1, ($t7)     
#					lw      $a2, ($t4)     

#					sub     $t9, $t9, 1    
#					beq     $a2, $a1, yes   
#					sub     $t1, $a1, $a2   
#					blez    $t1, searchLower 
#					bgez    $t1, searchHigher 
    


#remainderStep:
#					mfhi    $t8                    
#					bgtz    $t8, incrementCounter  
#					j       loopCheck              
    


#incrementCounter:
#					add     $t0, $v1, $t8          
    
#					j       loopCheck       
    

#searchLower:
#					move    $s7, $t4   
    
#					j       checkLower    
    


#searchHigher:
					move    $s6, $t4   
    
#					j       checkHigher
    


#yes:
#					li      $v0, 1    
#					lw      $a0, ($t4)   
#					syscall            

#					li      $v0, 4        
#					la      $a0, msg_found     
#					syscall                 
    


#no:
#					li      $v0, 1      
#					lw      $a0, ($t7)  
#					syscall              

#					li      $v0, 4       
#					la      $a0, msg_notfound  
#					syscall                         


#exit:
#					li      $v0, 10            
#					syscall   






#===============================================================#
##################### Declare all variables #####################
#===============================================================#


#    .data
#    .align 2
#
#    
#msg_inputList:      .asciiz "Please enter positive numbers in ascending order and a 0 to terminate\n"
#msg_searchList:     .asciiz "Please enter a number to initSearch for\n"
#msg_YES:            .asciiz " - YES\n"
#msg_NO:             .asciiz " - NO\n"


#===============================================================#
######################### Program Code ##########################
#===============================================================#


  #  .text
   # .globl main
    
    
#===============================================================#

#main:
  #  li          $v0, 4                  # syscall 4 (print_str)
  #  la          $a0, msg_inputList      # load the input message
  #  syscall                             # execute message print

  #  li          $v0, 9                  # syscall 9 (sbrk)
  #  la          $a0, 4                  # 4 bytes allocated for ints
  #  syscall                             # execute memory allocation
 #   move        $s1, $v0                # store the start address of heap

  #  li          $s4, 0                  # set list items counter to 0
    
#===============================================================#

#inputList:
  #  li          $v0, 5                  # syscall 5 (read_int)
 #   syscall                             # execute int reading
 #   move        $t1, $v0                # store int in $t1
 #   blez        $v0, initSearchList     # start search items input if 0 is input

  #  li          $v0, 9                  # syscall 9 (sbrk)
  #  la          $a0, 4                  # 4 bytes allocated for ints
 #   syscall                             # execute memory allocation

  #  li          $t0, 4                  # 4 bytes for an int
   # mul         $t0, $s4, $t0           # length of the input storage address space
   # add         $t0, $t0, $s1           # calculate end of address space
  #  move        $s5, $t0                # store end of address space
  #  sw          $t1, ($t0)              # store the input on the heap
  #  addi        $s4  $s4, 1             # counter++
    
 #   j           inputList               # take next input
    
#===============================================================#

#initSearchList:
 #   li          $v0, 4                  # syscall 4 (print_str)
 #   la          $a0, msg_searchList     # load the search items input message
 #   syscall                             # execute message print

  #  li          $s2, 0                  # set search items counter to 0
    
#===============================================================#

#searchList:
 #   li          $v0, 5                  # syscall 5 (read_int)
 #   syscall                             # execute int reading
  #  move        $t1, $v0                # move int to $t1
   # blez        $v0, initSearch         # start search if 0 was entered

  #  li          $v0, 9                  # syscall 4 (sbrk)
 #   la          $a0, 4                  # 4 bytes allocated for ints
   # syscall                             # execute memory allocation

  #  li          $t0, 4                  # 4 bytes for an int
 #   add         $t2, $s4, $s2           # length of the list is counter1 + counter 2
 #   mul         $t0, $t2, $t0           # length of the input storage address space
 #   add         $t0, $t0, $s1           # calculate end of address spaces
 #   move        $s3, $t0                # store end of address space
   # sw          $t1, ($t0)              # store input on the heap
   # addi        $s2, $s2, 1             # counter++

   # j           searchList              # take next input
    
#===============================================================#

#initSearch:
  #  move        $t6, $s5                # store end address of input items
  #  move        $t7, $s3                # store end address of search items
    
#===============================================================#

#search:                                                  
  #  move        $t5, $s5                # store end address of input items
   # beq         $t7, $t6, exit          # if there's nothing to search, exit
    
#===============================================================#

#splitStep:

  #  move        $s6, $s1                # min is the start address of the heap
  #  move        $s7, $s5                # max is the end address of the heap
 #   move        $t0, $s4                # store the input list counter
 #   move        $t9, $s4                # store the input list counter
  #  li          $v1, 2                  # store 2
  #  div         $t9, $v1                # divide the counter by 2
  #  mflo        $t9                     # move result of division to $t9
  #  add         $t9, $t9, $v1
    
#===============================================================#

#checkHigher:
  #  li          $v1, 2                  # store 2
 #   div         $t0, $v1                # divide the counter by 2
 #   mflo        $v1                     # store the division result
  #  mflo        $t0                     # move the counter out

 #   blez        $t0, remainderStep      # counter is at 0, check remainer step
    
 #   j           loopCheck               # run the looping check
    
#===============================================================#

#checkLower:
  #  li          $v1, 2                  # store 2
  #  div         $t0, $v1                # divide the counter by 2
 #   mflo        $v1                     # store the division result
 #   mflo        $t0                     # move the counter out
  #  mfhi        $t1                     # move Hi to $t1

 #   blez        $t0, failStep           # If the counter equals zero and so does the division remainder then print no
    
 #   j           loopCheck               # run the looping check
    
#===============================================================#

#failStep:
 #   blez        $t1, no                 # failed, return no
    
#===============================================================#

#loopCheck:
 #   beq         $s6, $s7, no            # max and min are now the same, didn't find the number
  #  blez        $t9, no                 # lower counter is 0, we didn't find the number

 #   mul         $v1, $t0, 4             # multiply counter by 4 to get the address space length
 #   add         $t4, $s6, $v1           # add the address space length to get the end address

#    lw          $a1, ($t7)              # get value of $t7
#    lw          $a2, ($t4)              # get value of $t4

#    sub         $t9, $t9, 1             # counter--

#    beq         $a2, $a1, yes           # we found it! yay
#    sub         $t1, $a1, $a2           # is it greater than or less than the point?
#    blez        $t1, searchLower        # it's less than, run the search on the lower segment
#    bgez        $t1, searchHigher       # it's greater than, run the search on the higher segment
    
#===============================================================#

#remainderStep:
#    mfhi        $t8                     # store result
#    bgtz        $t8, incrementCounter   # there's a remainder, move on to deal with it
#    j           loopCheck               # no remainder, run the search
    
#===============================================================#

#incrementCounter:
#    add         $t0, $v1, $t8           # counter++
    
#    j           loopCheck               # run the search
    
#===============================================================#

#searchLower:
#    move        $s7, $t4                # max point is now the old midpoint
    
#    j           checkLower              # search lower segment
    
#===============================================================#

#searchHigher:
#    move        $s6, $t4                # min point is now the old max
    
#    j           checkHigher             # search higher segment
    

#restartSearch:
#    sub         $t7, $t7, 4             # counter - 4
    
#    j           search                  # run search
    
#===============================================================#

#yes:
#    li          $v0, 1                  # syscall 1 (print_int)
#    lw          $a0, ($t4)              # load current int
#    syscall                             # execute int printing

#    li          $v0, 4                  # syscall 4 (print_str)
#    la          $a0, msg_YES            # load yes message
#    syscall                             # execute message printing

#    j           restartSearch           # run search on the rest of the search items
    
#===============================================================#

#no:
#    li          $v0, 1                  # syscall 1 (print_int)
#    lw          $a0, ($t7)              # load current int
#    syscall                             # execute int printing

#    li          $v0, 4                  # syscall 4 (print_str)
#    la          $a0, msg_NO             # load no message
#    syscall                             # execute message printing
    
#    j           restartSearch           # run search on the rest of the search items
    
#===============================================================#

#exit:
#    li          $v0, 10                 # syscall 10 (exit)
#    syscall                             # execute exit







############################################# Selection sort char ############################################# 
#SelectionSortChar:
#Prints the prompt string
#li $v0, 4
#la $a0, prompt 
#syscall 

#reads string from user and saves in $a0
#li $v0, 8
#la $a0, buffer
#li $a1, 80
#syscall 

#Prints the result string
#li $v0, 4 
#la $a0, result 
#syscall

#Prints the string entered by the user
#la $a0, buffer 
#li $v0, 4
#syscall     

#li      $t5, 0      # t5 is k = 0

#la      $t7, length     
 #   lw     $t7, 0($t7)     # t7 = length

#addi    $t8, $t7, -1    # t8 = length - 1
#la  $t6, 0($a0) # t6 = address of the array

#outerLoop: slt  $t0, $t5, $t8   # if k < length - 1  t0 = 1
#beq $t0, $zero, breakOuterLoop # k >= (length - 1)
#add $t9, $zero, $t5 # t9 is min = k

#addi    $t1, $t5, 1     # t1 is j = k + 1

#innerLoop: slt  $t0, $t1, $t7   # if j < length t0 = 1
#beq $t0, $zero, breakInnerLoop

#add $s3, $t9, $t9   # s3 = 2 * min
#add $s3, $s3, $s3   # s3 = 4 * min
#add $s3, $a0, $s3   # s3 is address of list[min]
#lb $t2, 0($s3)     # t2 is list[min]

#add $s0, $t1, $t1   # s0 = 2 * j
#add $s0, $s0, $s0   # s0 = 4 * j
#add $s0, $a0, $s0   # s0 is address of list[j]
#lb $t3, 0($s0)     # t3 is list[j]

#slt $t0, $t3, $t2   # if list[j] < list[min] t0 = 1
#beq $t0, $zero, secondIF # skip min = j & ++j and jump to secondIF
#add     $t9, $zero, $t1 # min = j
#j secondIF

#secondIF: beq   $t9, $t5, incrementJ # if min != k swap, else goto incrementJ

# BEGIN SWAP :
#add $s0, $t9, $t9   # s0 = 2 * min
#add $s0, $s0, $s0   # s0 = 4 * min
#add $s0, $s0, $a0   # s0 = address of list[min]
#lb $t4, 0($s0)     # t4 is temp = list[min]


#add $s1, $t5, $t5   # s1 = 2 * k
#add $s1, $s1, $s1   # s1 = 4 * k
#add $s1, $a0, $s1   # s1 = address of list[k]
#lb $s3, 0($s1)     # s3 = list[k]


#sb  $s3, 0($s0)     # list[min] = list[k]

#sb  $t4, 0($s1)     # list[k] = temp 
#addi    $t1, $t1, 1 # ++j
#add $t9, $zero, $t5 # t9 is min = k  
# END SWAP

#j innerLoop 

#incrementJ: addi $t1, $t1, 1    # ++j
#j innerLoop

#breakInnerLoop: addi $t5, $t5, 1 # ++k
#j outerLoop


#breakOuterLoop:             


#Prints the result string
#li $v0, 4 
#la $a0, result 
#syscall

#Prints the string entered by the user
#la $a0, buffer 
#li $v0, 4
#syscall

 #exitProgram:   li $v0, 10  # system call to
#syscall         # terminate program