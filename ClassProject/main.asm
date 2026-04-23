; ------------------------------------------------------------
; Program Description : a guessing game program
; Authors: Nam Pham, Caleb Alberto, Kailyn Vu
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
          09h,"5: To exit", 0dh, 0ah, 0dh, 0ah,0

invMsg BYTE "Not a valid choice",0dh,0ah,0
isOne Byte "You have chosen option 1",0dh,0ah,0
isTwo Byte "You have chosen option 2",0dh,0ah,0
isThree Byte "You have chosen option 3",0dh,0ah,0
isFour Byte "You have chosen option 4",0dh,0ah,0
isFive Byte "You have chosen option 5",0dh,0ah,0

.code
main PROC

    mov edx, OFFSET team
    call WriteString

    mov edx, OFFSET menu
    call WriteString

    call ReadInt
    cmp eax, 1
    jz choice1
    cmp eax, 2
    jz choice2
    cmp eax, 3
    jz choice3
    cmp eax, 4
    jz choice4
    cmp eax, 5 
    jz choice5

    mov edx, OFFSET invMsg
    call WriteString
    jmp endSwitch

    choice1:
        mov edx, OFFSET isOne
        call WriteString
        jmp endSwitch

    choice2:
        mov edx, OFFSET isTwo
        call WriteString
        jmp endSwitch

    choice3:
        mov edx, OFFSET isThree
        call WriteString
        jmp endSwitch

    choice4:
        mov edx, OFFSET isFour
        call WriteString
        jmp endSwitch

    choice5:
        mov edx, OFFSET isFive
        call WriteString
        jmp endSwitch


    endSwitch:

    exit
main ENDP
END main