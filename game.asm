##################################################################### 
# 
# CSCB58 Winter 2022 Assembly Final Project 
# University of Toronto, Scarborough 
# 
# Student: Runyu Yue, 1007391298, yuerunyu, runyu.yue@mail.utoronto.ca 
# 
# Bitmap Display Configuration: 
# - Unit width in pixels: 8 (update this as needed)  
# - Unit height in pixels: 8 (update this as needed) 
# - Display width in pixels: 512 (update this as needed) 
# - Display height in pixels: 512 (update this as needed) 
# - Base Address for Display: 0x10008000 ($gp) 
# 
# Which milestones have been reached in this submission? 
# (See the assignment handout for descriptions of the milestones) 
# - Milestone 3 (choose the one the applies) 
# 
# Which approved features have been implemented for milestone 3? 
# (See the assignment handout for the list of additional features) 
# 1. health
# 2. fail condition 
# 3. win condition
# 4. moving enemies
# 5. disapearing platforms
# 6. dashing once in mid air(by pressing j and k)

# Link to video demonstration for final submission: 
# - https://play.library.utoronto.ca/watch/aa918bc02d1ca30fc3f265e683d4ba1d 
# 
# Are you OK with us sharing the video with people outside course staff? 
# - yes , and please share this project github link as well! 
# 
# Any additional information that the TA needs to know: 
# - I allow jump in midway with unlimited times
# 
##################################################################### 

# Bitmap display starter code 
# 
# Bitmap Display Configuration: 
# - Unit width in pixels: 8           
# - Unit height in pixels: 8 
# - Display width in pixels: 512 
# - Display height in pixels: 512 
# - Base Address for Display: 0x10008000 ($gp) 
# 
.eqv  BASE_ADDRESS  0x10008000 
.eqv	ROU 		0xcd9a5b
.eqv	YELLOW		0xFFFF00
.eqv	RED		0xFF0000
.eqv	BLUE		0x3f51b5
.eqv	WHITE		0xFFFFFF
.eqv	BLACK		0x000000
.eqv	GREEN		0x00FF00
 
 
 .data
 	counter:	.word 0
 	dash:	.word 1
 	characters: .word 0:10
 	lines: .word 0:20
 	gravity: .word 1
 	move_up: .word 0
 	ifup:	.word 0
 	destination: .word 0:2
 	health:	.word 8
.text 
start:
	la $t3, counter
	li $t2, 0
	sw $t2, 0($t3)
	la $t3, health
	li $t4, 8
	sw $t4, 0($t3)
	la $t7, characters
	la $t8, lines
 	li $t0, BASE_ADDRESS # $t0 stores the base address for display 
	li $t1, 9216
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	sw $t2, 0($t7)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	
	li $t0, BASE_ADDRESS
	li $t1, 9216
	addi $t1,$t1,512
	add $t2, $t1, $t0
	sw $t2, 0($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, WHITE
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, 63
	sw $t2, 4($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
	li $t0, BASE_ADDRESS	#draw health
	li $t1, 9216
	addi $t1,$t1,512
	addi $t1,$t1,512
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, RED
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, 7
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
	li $t0, BASE_ADDRESS # $t0 stores the base address for display 
	li $t1, 8172
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	sw $t2, 4($t7)
	li $t2, GREEN
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, WHITE
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	
	li $t0, BASE_ADDRESS
	li $t1, 8176
	addi $t1,$t1,436
	add $t2, $t1, $t0
	sw $t2, 8($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, WHITE
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, 20
	sw $t2, 12($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
	la $t5, destination
	li $t0, BASE_ADDRESS
	li $t1, 96
	addi $t1,$t1,3376
	add $t2, $t1, $t0
	sw $t2, 0($t5)
	sw $t2, 16($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLUE
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2,	10
	sw $t2, 4($t5)
	sw $t2, 20($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
	li $t0, BASE_ADDRESS # $t0 stores the base address for display 
	li $t1, 5888
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	sw $t2, 8($t7)
	li $t2, GREEN
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, WHITE
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	
	li $t0, BASE_ADDRESS
	li $t1, 0
	addi $t1,$t1,6400
	add $t2, $t1, $t0
	sw $t2, 24($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, WHITE
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2,	19
	sw $t2, 28($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
fireline:
	li $t0, BASE_ADDRESS
	li $t1, 0
	addi $t1,$t1,4400	#fire at
	add $t2, $t1, $t0
	li $t3, RED
	sw $t3, 0($t2)
	li $t4, 0
drawfire:	
	beq $t4, 160, main_loop #4*length
	addi $t4, $t4, 4
	addi $t2, $t2, 4
	sw $t3, 0($t2)
	j drawfire
	
	
	
main_loop:
	la $t2, counter
	lw $t3, 0($t2)
	beq $t3, 200, disappearp1
finishp1:
	beq $t3, 100, disappearp2
finishp2:
	la $t2, counter
	lw $t3, 0($t2)
	addi $t3, $t3, 1
	sw $t3, 0($t2)
	la $t2, characters
	lw $t3, 0($t2)
	li $t2, BLACK
	lw $t4,512($t3)
	beq $t4, $t2, fd
	lw $t4,516($t3)
	beq $t4, $t2, fd
	lw $t4,520($t3)
	beq $t4, $t2, fd
	la $t1, dash
	li $t2,1
	sw $t2,0($t1)
	
fd:
	jal move_des
	li $t9, 0xffff0000  
	lw $t6, 0($t9) 
	beq $t6, 1, keypress_happened 
after:					#after dealing with pressing keys
	la $t4, move_up
	lw $t3, 0($t4)
	bgt $t3, 0, moveup
	
gra:	
	la $t4, ifup
	lw $t5, 0($t4)
	bne $t5, 0, timedelay	#check if the character has moved up
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t1, BLACK
	add $t5, $t4, 512	#check if the lower ones are white or not out of bounds
	li $t6, BASE_ADDRESS
	addi $t6, $t6, 16384
	bgt $t5, $t6, timedelay
	lw $t6, 0($t5)
	bne $t6, $t1, timedelay
	add $t5, $t4, 516	#check if the lower ones are white or not out of bounds
	li $t6, BASE_ADDRESS
	addi $t6, $t6, 16384
	bgt $t5, $t6, timedelay
	lw $t6, 0($t5)
	bne $t6, $t1, timedelay
	add $t5, $t4, 520	#check if the lower ones are white or not out of bounds
	li $t6, BASE_ADDRESS
	addi $t6, $t6, 16384
	bgt $t5, $t6, timedelay
	lw $t6, 0($t5)
	bne $t6, $t1, timedelay
	la $t3, characters
	lw $t4, 0($t3)
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	addi $t4, $t4, 256	#move down
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	
	
timedelay:
	j checkconditions
finish:
	la $t7, characters
	li $a3, 4
	jal move_enemy
	li $a3, 8
	jal move_enemy
	la $t4, ifup
	li $t5, 0
	sw $t5, 0($t4)
	li $v0, 32 
	li $a0, 100   # Wait one second (1000 milliseconds) 
	syscall
	j main_loop 
	
disappearp2:
	li $t0, BASE_ADDRESS
	li $t1, 8176
	addi $t1,$t1,436
	add $t2, $t1, $t0
	sw $t2, 8($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLACK
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, 20
	sw $t2, 12($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	j finishp2
	
disappearp1:
	li $t0, BASE_ADDRESS
	li $t1, 0
	addi $t1,$t1,6400
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLACK
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2,	19
	sw $t2, 28($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	j finishp1
	
move_des:
	move $a2, $ra
	li $v0, 42 
	li $a0, 0 
	li $a1, 2
	syscall
	li $t1, 1
	beq $t1, $a0, line_right
	j line_left
line_right:
	la $t5, destination
	lw $t2, 0($t5)
	li $t3, 256
	div $t2, $t3
	mfhi $t3
	beq $t3, 255, go_back	#if it is rightest
	lw $t3, 4($t5)
	li $t5, BLACK
	li $t1,4
	mult $t3, $t1
	mflo $t3
	sw $t5, 0($t2)
	add $t2, $t2, $t3
	li $t5, BLUE
	sw $t5, 0($t2)
go_back:
	move $ra, $a2
	jr $ra

line_left:
	la $t5, destination
	lw $t2, 0($t5)
	li $t3, 256
	div $t2, $t3
	mfhi $t3
	beq $t3, 0, line_right	#if it is leftest
	lw $t3, 4($t5)
	li $t5, BLUE
	li $t1,4
	mult $t3, $t1
	mflo $t3
	sw $t5, 0($t2)
	add $t2, $t2, $t3
	li $t5, BLACK
	sw $t5, 0($t2)
	move $ra, $a2
	jr $ra
	
	
	
	
checkconditions:
	la $t3, characters
	lw $t4, 0($t3)
	lw $t1, 4($t3)
	lw $t2, 8($t3)
	addi $t5, $t4, 12
	beq $t5, $t1, game_over
	beq $t5, $t2, game_over
	addi $t5, $t4, 268
	beq $t5, $t1, game_over
	beq $t5, $t2, game_over
	addi $t5, $t4, -12
	beq $t5, $t1, game_over
	beq $t5, $t2, game_over
	addi $t5, $t4, 244
	beq $t5, $t1, game_over
	beq $t5, $t2, game_over
	
	li $t1, RED
	addi $t5, $t4, 12
	lw $t6,0($t5)
	bne $t6, $t1, jump1
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
	
jump1:	addi $t5, $t4, 268
	lw $t6,0($t5)
	bne $t6, $t1, jump2
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
	
jump2:	addi $t5, $t4, 252
	lw $t6,0($t5)
	bne $t6, $t1, jump3
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
	
jump3:	addi $t5, $t4, 512
	lw $t6,0($t5)
	bne $t6, $t1, jump4
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
jump4:
	addi $t5, $t4, 516
	lw $t6,0($t5)
	bne $t6, $t1, jump5
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
jump5:
	addi $t5, $t4, 520
	lw $t6,0($t5)
	bne $t6, $t1, jump6
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
jump6:
	addi $t5, $t4, -4
	blt $t5,0,last
	lw $t6,0($t5)
	bne $t6, $t1, jump7
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
jump7:
	addi $t5, $t4, -256
	blt $t5,0,last
	lw $t6,0($t5)
	bne $t6, $t1, jump8
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
	
jump8:
	addi $t5, $t4, -252
	blt $t5,0,last
	lw $t6,0($t5)
	bne $t6, $t1, jump9
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
jump9:
	addi $t5, $t4, -248
	blt $t5,0,last
	lw $t6,0($t5)
	bne $t6, $t1, jump10
	la $t2, health
	lw $t3, 0($t2)
	addi $t3, $t3, -1
	sw $t3, 0($t2)
jump10:
	
	li $t1, BLUE
	addi $t5, $t4, 512
	lw $t6,0($t5)
	beq $t6, $t1, win
	addi $t5, $t4, 516
	lw $t6,0($t5)
	beq $t6, $t1, win
	addi $t5, $t4, 520
	lw $t6,0($t5)
	beq $t6, $t1, win
	
	li $t0, BASE_ADDRESS	#draw health
	li $t1, 9216
	addi $t1,$t1,512
	addi $t1,$t1,512
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLACK
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, 7
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	li $t0, BASE_ADDRESS	#draw health
	li $t1, 9216
	addi $t1,$t1,512
	addi $t1,$t1,512
	add $t2, $t1, $t0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, RED
	la $t0, health
	lw $t1, 0($t0)
	ble $t1, 0, game_over
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	addi $t2, $t1, -1
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
last:	j finish
	j END


reduce_health:
	la $t4, health
	lw $t5, 0($t4)
	addi $t5, $t5, -2
	sw $t5, 0($t4)

win:
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $t4, 4($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $t4, 8($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	li $t5, BLUE
	li $t4, 2608
	la $t1, BASE_ADDRESS
	add $t4, $t4, $t1
	sw $t5, 0($t4)
	sw $t5, 24($t4)
	sw $t5, 28($t4)
	sw $t5, 52($t4)
	sw $t5, 260($t4)
	sw $t5, 276($t4)
	sw $t5, 288($t4)
	sw $t5, 304($t4)
	sw $t5, 520($t4)
	sw $t5, 528($t4)
	sw $t5, 548($t4)
	sw $t5, 556($t4)
	sw $t5, 780($t4)
	sw $t5, 808($t4)
	addi $t4, $t4, 84
	sw $t5, 0($t4)
	sw $t5, 256($t4)
	sw $t5, 512($t4)
	sw $t5, 768($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 256($t4)
	sw $t5, 264($t4)
	sw $t5, 512($t4)
	sw $t5, 524($t4)
	sw $t5, 768($t4)
	sw $t5, 784($t4)
	sw $t5, 20($t4)
	sw $t5, 276($t4)
	sw $t5, 532($t4)
	sw $t5, 788($t4)
	
	la $t5, destination
	lw $t2, 0($t5)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLACK
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2,	10
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
	li $v0, 32 
	li $a0, 1000   # Wait one second (1000 milliseconds) 
	syscall 
	j cleanandstart		
game_over:
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $t4, 4($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $t4, 8($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	li $t5, GREEN
	li $t4, 2560
	la $t1, BASE_ADDRESS
	add $t4, $t4, $t1
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 12($t4)
	sw $t5, 256($t4)
	sw $t5, 512($t4)
	sw $t5, 768($t4)
	sw $t5, 1024($t4)
	sw $t5, 1280($t4)
	sw $t5, 1284($t4)
	sw $t5, 1288($t4)
	sw $t5, 1292($t4)
	sw $t5, 1036($t4)
	sw $t5, 780($t4)
	sw $t5, 776($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 252($t4)
	sw $t5, 264($t4)
	sw $t5, 504($t4)
	sw $t5, 508($t4)
	sw $t5, 512($t4)
	sw $t5, 516($t4)
	sw $t5, 520($t4)
	sw $t5, 524($t4)
	sw $t5, 756($t4)
	sw $t5, 784($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 252($t4)
	sw $t5, 260($t4)
	sw $t5, 504($t4)
	sw $t5, 508($t4)
	sw $t5, 520($t4)
	sw $t5, 268($t4)
	sw $t5, 16($t4)
	sw $t5, 276($t4)
	sw $t5, 536($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 12($t4)
	sw $t5, 256($t4)
	sw $t5, 512($t4)
	sw $t5, 516($t4)
	sw $t5, 520($t4)
	sw $t5, 524($t4)
	sw $t5, 768($t4)
	sw $t5, 1024($t4)
	sw $t5, 1028($t4)
	sw $t5, 1032($t4)
	sw $t5, 1036($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 12($t4)
	sw $t5, 256($t4)
	sw $t5, 512($t4)
	sw $t5, 768($t4)
	sw $t5, 1024($t4)
	sw $t5, 268($t4)
	sw $t5, 524($t4)
	sw $t5, 780($t4)
	sw $t5, 1028($t4)
	sw $t5, 1032($t4)
	sw $t5, 1036($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 260($t4)
	sw $t5, 520($t4)
	sw $t5, 780($t4)
	sw $t5, 24($t4)
	sw $t5, 276($t4)
	sw $t5, 528($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 12($t4)
	sw $t5, 256($t4)
	sw $t5, 512($t4)
	sw $t5, 516($t4)
	sw $t5, 520($t4)
	sw $t5, 524($t4)
	sw $t5, 768($t4)
	sw $t5, 1024($t4)
	sw $t5, 1028($t4)
	sw $t5, 1032($t4)
	sw $t5, 1036($t4)
	addi $t4, $t4, 32
	sw $t5, 0($t4)
	sw $t5, 256($t4)
	sw $t5, 512($t4)
	sw $t5, 768($t4)
	sw $t5, 1024($t4)
	sw $t5, 516($t4)
	sw $t5, 264($t4)
	sw $t5, 12($t4)
	
	la $t5, destination
	lw $t2, 0($t5)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLACK
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2,	10
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	
	li $v0, 32 
	li $a0, 1000   # Wait one second (1000 milliseconds) 
	syscall 
	j cleanandstart

cleanandstart:
	li $t5, BLACK
	li $t4, 2560
	la $t1, BASE_ADDRESS
	add $t4, $t4, $t1
	li $t3, 1296
cleanloop:
	ble $t3, 0, jump_start
	sw $t5, 0($t4)
	addi $t4, $t4, 4
	subi $t3, $t3, 4
	j cleanloop
jump_start:
	
	j start
	
move_enemy:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $v0, 42 
	li $a0, 0 
	li $a1, 2
	syscall
	li $t1, 1
	beq $t1, $a0, finish_left
	j move_left
finish_left:
	move $t2, $v0
	beq $t2, 1, JUMP_B
	j move_right
	
JUMP_B:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
move_right:
	move $t6, $a3
	la $t3, characters
	add $t3, $t3, $t6
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	div $t4, $t5
	mfhi $t5
	beq $t5, 244, JUMP_B	#if it is rightest
	addi $t4, $t4, 12			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, JUMP_B
	addi $t4, $t4, 256			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, JUMP_B
	lw $t4, 0($t3)
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	addi $t4, $t4, 4	#move to right
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, GREEN
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, WHITE
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	j JUMP_B
	
move_left:
	li $v0, 0
	move $t6, $a3
	la $t3, characters
	add $t3, $t3, $t6
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	div $t4, $t5
	mfhi $t5
	beq $t5, 0, finish_left	#if it is leftest
	subi $t4, $t4, 4			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, finish_left
	addi $t4, $t4, 256			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, finish_left
	lw $t4, 0($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	li $v0, 1
	addi $t4, $t4, -4	#move to left
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, GREEN
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, WHITE
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	j finish_left


moveup:
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t1, BLACK
	li $t2, BASE_ADDRESS
	subi $t5, $t4, 256	#check if the upper ones are black or not out of bounds
	sub $t2, $t5, $t2
	blt $t2, 0, gra
	lw $t6, 0($t5)
	bne $t6, BLACK, gra
	subi $t5, $t4, 252	#check if the upper ones are black or not out of bounds
	blt $t5, 0, gra
	lw $t6, 0($t5)
	bne $t6, BLACK, gra
	subi $t5, $t4, 248	#check if the upper ones are black or not out of bounds
	blt $t5, 0, gra
	lw $t6, 0($t5)
	bne $t6, BLACK, gra
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	la $t3, characters
	addi $t4, $t4, -256	#move up
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	la $t6, ifup
	li $t5, 1	#if moveing up ifup will be 1
	sw $t5, 0($t6)
	la $t4, move_up
	lw $t3, 0($t4)
	subi $t3, $t3, 1
	sw $t3, 0($t4)
	j gra
	

keypress_happened:
	lw $t2, 4($t9) # this assumes $t9 is set to 0xfff0000 from before 
	beq $t2, 0x61, a   # ASCII code of 'a' is 0x61 or 97 in decimal 
	beq $t2, 0x64, d
	beq $t2, 0x77, w
	beq $t2, 0x70, p
	beq $t2, 0x6A, j
	beq $t2, 0x6B, k
	j after
	
j:
	la $t3, dash
	lw $t2, 0($t3)
	bne $t2,1,fld
	li $t2, 0
	sw $t2, 0($t3)
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t2, BLACK
	lw $t3,512($t4)
	bne $t2, $t3, fld
	lw $t3,516($t4)
	bne $t2, $t3, fld
	lw $t3,520($t4)
	bne $t2, $t3, fld
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	div $t4, $t5
	mfhi $t5
	beq $t5, 0, after	#if it is leftest
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	subi $t4, $t4, 4
	div $t4, $t5
	mfhi $t5
	beq $t5, 0, after	#if it is leftest
	lw $t4, 0($t3)	#address of the player
	subi $t4, $t4, 4			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	addi $t4, $t4, 256			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	lw $t4, 0($t3)	#address of the player
	subi $t4, $t4, 8			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	addi $t4, $t4, 256			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	
	lw $t4, 0($t3)	#address of the player
	li $t5, WHITE
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $s1, 0($t3)
	addi $t4, $t4, -8	#move to left
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	li $v0, 32 
	li $a0, 100   # Wait 0.2 second (1000 milliseconds) 
	syscall 
	move $t4, $s1	#address of the player
	li $t5, BLACK
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
fld:
	j after
	
k:
	la $t3, dash
	lw $t2,0($t3)
	bne $t2,1,frd
	li $t2,0
	sw $t2,0($t3)
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t2, BLACK
	lw $t3,512($t4)
	bne $t2, $t3, frd
	lw $t3,516($t4)
	bne $t2, $t3, frd
	lw $t3,520($t4)
	bne $t2, $t3, frd
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	div $t4, $t5
	mfhi $t5
	beq $t5, 244, after	#if it is rightest
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	addi $t4, $t4, 4
	div $t4, $t5
	mfhi $t5
	beq $t5, 244, after	#if it is rightest
	lw $t4, 0($t3)	#address of the player
	addi $t4, $t4, 12			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	addi $t4, $t4, 256			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	lw $t4, 0($t3)	#address of the player
	subi $t4, $t4, 16			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	addi $t4, $t4, 256			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	
	lw $t4, 0($t3)	#address of the player
	li $t5, WHITE
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $s1, 0($t3)
	addi $t4, $t4, 8	#move to right
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	li $v0, 32 
	li $a0, 100   # Wait 0.2 second (1000 milliseconds) 
	syscall 
	move $t4, $s1	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	
frd:
	j after
	
p:
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $t4, 4($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	lw $t4, 8($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	la $t5, destination
	lw $t2, 0($t5)
	li $t3, 256
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t4, BLACK
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2,	10
	sw $t2, 4($t5)
	sw $t2, 20($t8)
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal line
	j start

a:	
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	div $t4, $t5
	mfhi $t5
	beq $t5, 0, after	#if it is leftest
	subi $t4, $t4, 4			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	addi $t4, $t4, 256			#check if the left has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	lw $t4, 0($t3)	#address of the player
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	addi $t4, $t4, -4	#move to left
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	j after
	

d:
	la $t3, characters
	lw $t4, 0($t3)	#address of the player
	li $t5, 256
	div $t4, $t5
	mfhi $t5
	beq $t5, 244, after	#if it is rightest
	addi $t4, $t4, 12			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	addi $t4, $t4, 256			#check if the right has something
	li $t6, BLACK
	lw $t2, 0($t4)
	bne $t2, $t6, after
	lw $t4, 0($t3)
	li $t5, BLACK
	sw $t5, 0($t4)
	sw $t5, 4($t4)
	sw $t5, 8($t4)
	sw $t5, 256($t4)
	sw $t5, 260($t4)
	sw $t5, 264($t4)
	addi $t4, $t4, 4	#move to right
	sw $t4, 0($t3)
	addi $sp, $sp, -4
	sw $t4, 0($sp)
	li $t2, ROU
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	li $t2, RED
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	jal pcharacter
	j after

w:
	la $t4, move_up
	lw $t6, 0($t4)
	bgt $t6, 0, after
	li $t5, 5
	sw $t5, 0($t4)
	j after
	

line:	#gets address to print, color of line, length of lie
	lw $t6, 0($sp)
	addi $sp, $sp, 4
	lw $t4, 0($sp)
	addi $sp, $sp, 4
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	li $t5,0
	li $t3, 4
	
loop:	
	bne $t6,0,loop1
	jr $ra
	
loop1:
	sw $t4,0($t2)
	add $t2, $t2, $t3
	sw $t4,0($t2)
	addi $t5, $t5,1
	bne $t5, $t6, loop
	jr $ra
	
	
 	
pcharacter:		#get the left up corner and the colours to print the char or enemy
	lw $t2, 0($sp)
	addi $sp, $sp, 4
	lw $t1, 0($sp)
	addi $sp, $sp, 4	
	lw $t0, 0($sp)
	addi $sp, $sp, 4
 	sw $t2, 0($t0)  # paint the second unit on the first row green. Why $t0+4? 
 	sw $t1, 4($t0)
 	sw $t2, 8($t0)
 	sw $t1, 256($t0)
 	sw $t2, 260($t0)
 	sw $t1, 264($t0)
 	jr $ra
 
 END:
 	li $v0, 10 # terminate the program gracefully 
 	syscall 
