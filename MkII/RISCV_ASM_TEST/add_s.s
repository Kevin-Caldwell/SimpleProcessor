.global main

main: 
	addi s0, zero, 1
	slli s1, s0, 1
	lui s3, 0xFFF
	addi s3, s3, 10
	jal sample_j
END: ebreak


sample_j: addi s0, zero, 1
	jr ra

.data
LIST: .word 0x000FFFF0