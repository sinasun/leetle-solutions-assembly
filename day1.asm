section .data
    question db "Enter an integer: "
    array_start db "["
    array_separator db ", "
    array_end db "]"
    fizz db "'Fizz'"
    buzz db "'Buzz'"
    fizzbuzz db "'FizzBuzz'"
    testn db "15"
section .bss
    num_str resb 16
    num resb 16
    buffer resb 10

section .text
    global _start

_start:

    call _printQuestion
    call _getNumStr
    call _printArrayStart
    ; convert num str to int
    lea esi, [num_str]
    call string_to_int ; saves the number into eax
    
    mov ecx, eax ; keep the number of iter in num
    mov eax, 1 ; start from 1
    l1:
      push ecx
      push eax
      mov edx, 0
      mov ecx, 15
      div ecx ; it saves the reminder in edx
      cmp edx, 0
      je printFizzBuzz
      pop eax
      push eax
      mov edx, 0
      mov ecx, 3
      div ecx ; it saves the reminder in edx
      cmp edx, 0
      je printFizz
      pop eax
      push eax
      mov edx, 0
      mov ecx, 5
      div ecx ; it saves the reminder in edx
      cmp edx, 0
      je printBuzz
      pop eax
      push eax
      jmp printN
      

      printFizzBuzz:
        call _printFizzBuzz
        jmp endLoop
      printFizz:
        call _printFizz
        jmp endLoop
      printBuzz:
        call _printBuzz
        jmp endLoop
      printN:
        lea esi, [buffer]
        call int_to_string
        call _printBuffer
        jmp endLoop
        
      endLoop:
      call _printArraySeparator
      pop eax
      pop ecx
      inc eax
      cmp eax, ecx
      jle l1
      
finish:  
    call _printArrayEnd
    mov eax, 1
    mov ebx, ebx
    int 0x80

_printQuestion:

    mov eax, 4
    mov ebx, 1
    mov ecx, question
    mov edx, 18
    int 0x80
    ret


_printArrayStart:

    mov eax, 4
    mov ebx, 1
    mov ecx, array_start
    mov edx, 1
    int 0x80
    ret

_printArrayEnd:

    mov eax, 4
    mov ebx, 1
    mov ecx, array_end
    mov edx, 1
    int 0x80
    ret


_printArraySeparator:

    mov eax, 4
    mov ebx, 1
    mov ecx, array_separator
    mov edx, 2
    int 0x80
    ret


_printFizz:

    mov eax, 4
    mov ebx, 1
    mov ecx, fizz
    mov edx, 6
    int 0x80
    ret


_printBuzz:

    mov eax, 4
    mov ebx, 1
    mov ecx, buzz
    mov edx, 6
    int 0x80
    ret


_printFizzBuzz:

    mov eax, 4
    mov ebx, 1
    mov ecx, fizzbuzz
    mov edx, 10
    int 0x80
    ret

_printBuffer:
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 10
    int 0x80
    ret

_getNumStr:
    
    mov eax, 3
    mov ebx, 0
    lea ecx, [num_str]
    mov edx, 16
    int 0x80
    ret

; https://stackoverflow.com/questions/19309749/nasm-assembly-convert-input-to-integer
; with some changes from here so it doesn't need the length: https://cratecode.com/info/x86-assembly-nasm-user-input-output
; Input:
; ESI = pointer to the string to convert
; Output:
; EAX = integer value
string_to_int:
    xor   ebx, ebx
    .convert_loop:
        movzx eax, byte [esi]
        test  eax, eax
        jz    .done
        cmp   al, '0'
        jb    .done
        cmp   al, '9'
        ja    .done
        sub   al, '0'
        imul  ebx, 10
        add   ebx, eax
        inc   esi
        jmp   .convert_loop
    .done:
        mov   eax, ebx
        ret
; Input:
; EAX = integer value to convert
; ESI = pointer to buffer to store the string in (must have room for at least 10 bytes)
; Output:
; EAX = pointer to the first character of the generated string
int_to_string:
    add esi,9
    mov byte [esi],0

    mov ebx,10         
    .next_digit:
      xor edx,edx         ; Clear edx prior to dividing edx:eax by ebx
      div ebx             ; eax /= 10
      add dl,'0'          ; Convert the remainder to ASCII 
      dec esi             ; store characters in reverse order
      mov [esi],dl
      test eax,eax            
      jnz .next_digit     ; Repeat until eax==0
      mov eax,esi
      ret


