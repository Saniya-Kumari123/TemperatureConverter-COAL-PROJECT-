.data
menu: .asciiz "\nWhich operation do you want to perform:
\n1) Celsius to Fahrenheit
\n2) Fahrenheit to Celsius
\n3) Celsius to Kelvin
\n4) Fahrenheit to Kelvin
\n5) Kelvin to Celsius
\n6) Kelvin to Fahrenheit
\n7) Exit\nEnter your choice: "
input: .asciiz "Enter temperature: "
output: .asciiz "Converted temperature: "

.text
.globl main

main:
    li $v0, 4
    la $a0, menu
    syscall

    
    li $v0, 5
    syscall
    move $t0, $v0

   
 beq $t0, 1, celsius_to_fahrenheit
  beq $t0, 2, fahrenheit_to_celsius
    beq $t0, 3, celsius_to_kelvin
    beq $t0, 4, fahrenheit_to_kelvin
    beq $t0, 5, kelvin_to_celsius
    beq $t0, 6, kelvin_to_fahrenheit
    beq $t0, 7, exit

   
    j exit

celsius_to_fahrenheit:
    jal get_temperature
    move $t1, $v0
	
    # Celsius to Fahrenheit: F = (C * 9/5) + 32
	
    mul $t2, $t1, 9
    div $t2, $t2, 5
    addi $t2, $t2, 32
    jal display_result
    j main

fahrenheit_to_celsius:
    jal get_temperature
    move $t1, $v0
	
    #  Fahrenheit to Celsius: C = (F - 32) * 5/9
	
    sub $t2, $t1, 32
    mul $t2, $t2, 5
    div $t2, $t2, 9
    jal display_result
    j main

celsius_to_kelvin:
    jal get_temperature
    move $t1, $v0
#  Celsius to Kelvin  K = C + 273.15
	
    addi $t2, $t1, 273
    jal display_result
    j main

fahrenheit_to_kelvin:
    jal get_temperature
    move $t1, $v0
    # Convert Fahrenheit to Kelvin: K = (F - 32) * 5/9 + 273.15
    sub $t2, $t1, 32
    mul $t2, $t2, 5
    div $t2, $t2, 9
    addi $t2, $t2, 273
    jal display_result
    j main

kelvin_to_celsius:
    jal get_temperature
    move $t1, $v0
    # Convert Kelvin to Celsius: C = K - 273.15
    sub $t2, $t1, 273
    jal display_result
    j main

kelvin_to_fahrenheit:
    jal get_temperature
    move $t1, $v0
    # Convert Kelvin to Fahrenheit: F = (K - 273.15) * 9/5 + 32
    sub $t2, $t1, 273
    mul $t2, $t2, 9
    div $t2, $t2, 5
    addi $t2, $t2, 32
    jal display_result
    j main


get_temperature:
    li $v0, 4
    la $a0, input
    syscall

    li $v0, 5
    syscall
    move $v0, $v0  
    jr $ra

display_result:
    li $v0, 4
    la $a0, output
    syscall

    li $v0, 1
    move $a0, $t2
    syscall
    jr $ra

exit:
    li $v0, 10
    syscall


