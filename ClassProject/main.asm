; ------------------------------------------------------------
; Program Description : a guessing game program
; Authors: Nam Pham, Caleb Alberto
; Creation Date : 4/14
; Language: IA-32 x86
; Assembler: Microsoft Macro Assembler (MASM)
; ----------------------------------------------------------


INCLUDE Irvine32.inc

.data
team BYTE " *** ASSEMBLY WARRIORS *** ",0dh,0ah,0dh,0ah,0

menu BYTE " *** MAIN MENU *** ", 0dh,0ah,0dh,0ah,
          09h,"1: Display my available credit", 0dh, 0ah,
          09h,"2: Add credits to my account", 0dh, 0ah,
          09h,"3: Play the guessing game" ,0dh, 0ah,
          09h,"4: Display my statistic", 0dh, 0ah,
          09h,"5: To exit", 0dh, 0ah,0

.code
main PROC

    mov edx, OFFSET team
    call WriteString

    mov edx, OFFSET menu
    call WriteString

    exit
main ENDP
END main