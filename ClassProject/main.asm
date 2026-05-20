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

balance DWORD 0
MAX_ALLOWED DWORD 20
amount DWORD 0
correctGuesses DWORD 0
missedGuesses DWORD 0
name BYTE 16 DUP(0)

namePrompt BYTE "Please enter your name: ",0
balanceMsg BYTE "Your available balance is: $",0
addPrompt BYTE "Please enter the amount you would like to add: ",0
addErrMsg BYTE "Error: Maximum allowable credit is $20.00.",0dh,0ah,
               "Please enter a different amount and try again.",0dh,0ah,0
guessPrompt BYTE "Please enter your guess (1-10): ",0
winMsg BYTE "Congratulations! You guessed correctly! You win $2!",0dh,0ah,0
lossMsg1 BYTE "Sorry, the correct number was: ",0
lossMsg2 BYTE ". Better luck next time!",0dh,0ah,0
playAgainMsg BYTE "Would you like to play again? (y/n): ",0
statHeader BYTE "*** MY STATISTICS ***",0dh,0ah,0dh,0ah,0
statNameLbl BYTE "Player Name:      ",0
statBalLbl BYTE "Available Credit: $",0
statPlayedLbl BYTE "Games Played:     ",0
statCorrectLbl BYTE "Correct Guesses:  ",0
statMissedLbl BYTE "Missed Guesses:   ",0
statWonLbl BYTE "Money You Won:    $",0
statLostLbl BYTE "Money You Lost:   $",0
pressEnterMsg BYTE 0dh,0ah,"Press Enter to return to the main menu...",0

.code
main PROC

    mov edx, OFFSET team
    call WriteString

    mov edx, OFFSET namePrompt
    call WriteString
    mov edx, OFFSET name
    mov ecx, 15
    call ReadString

    call Randomize

    menuLoop:
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
        mov edx, OFFSET balanceMsg
        call WriteString
        mov eax, balance
        call WriteDec
        call Crlf
        jmp endSwitch

    choice2:
        mov edx, OFFSET addPrompt
        call WriteString
        call ReadInt
        mov amount, eax
        cmp eax, MAX_ALLOWED
        jg addCreditErr
        add balance, eax
        jmp endSwitch

    addCreditErr:
        mov edx, OFFSET addErrMsg
        call WriteString
        jmp endSwitch

    choice3:
        sub balance, 1

        mov eax, 10
        call RandomRange
        inc eax
        mov ebx, eax

        mov edx, OFFSET guessPrompt
        call WriteString
        call ReadInt

        cmp eax, ebx
        jz correctGuess

    wrongGuess:
        inc missedGuesses
        mov edx, OFFSET lossMsg1
        call WriteString
        mov eax, ebx
        call WriteDec
        mov edx, OFFSET lossMsg2
        call WriteString
        jmp playAgain

    correctGuess:
        add balance, 2
        inc correctGuesses
        mov edx, OFFSET winMsg
        call WriteString

    playAgain:
        mov edx, OFFSET playAgainMsg
        call WriteString
        call ReadChar
        mov bl, al
        call ReadChar      ; drain trailing newline
        call Crlf
        cmp bl, 'y'
        jz choice3
        cmp bl, 'Y'
        jz choice3
        jmp endSwitch

    choice4:
        mov edx, OFFSET statHeader
        call WriteString

        mov edx, OFFSET statNameLbl
        call WriteString
        mov edx, OFFSET name
        call WriteString
        call Crlf

        mov edx, OFFSET statBalLbl
        call WriteString
        mov eax, balance
        call WriteDec
        call Crlf

        mov edx, OFFSET statPlayedLbl
        call WriteString
        mov eax, correctGuesses
        add eax, missedGuesses
        call WriteDec
        call Crlf

        mov edx, OFFSET statCorrectLbl
        call WriteString
        mov eax, correctGuesses
        call WriteDec
        call Crlf

        mov edx, OFFSET statMissedLbl
        call WriteString
        mov eax, missedGuesses
        call WriteDec
        call Crlf

        mov edx, OFFSET statWonLbl
        call WriteString
        mov eax, correctGuesses
        add eax, eax
        call WriteDec
        call Crlf

        mov edx, OFFSET statLostLbl
        call WriteString
        mov eax, correctGuesses
        add eax, missedGuesses
        call WriteDec
        call Crlf

        mov edx, OFFSET pressEnterMsg
        call WriteString
        call ReadChar
        call Crlf
        jmp endSwitch

    choice5:
        exit

    endSwitch:
    jmp menuLoop

main ENDP
END main
