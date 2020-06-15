; Implements stack operations.
; CSC 225, Assignment 4
; Given code, Winter '20

        .ORIG x4000     ; NOTE: Do not alter these addresses. They are
        .FILL PUSH      ;       hardcoded within "calculator.asm", since the
        .FILL POP       ;       assembler cannot resolve cross-file labels.

; Pushes one element onto the stack.
;  Takes the stack pointer in R1, element to push in R2.
;  Returns the stack pointer in R1.
;  TODO: Implement this subroutine.
PUSH    add r1 r1 #-1
        str r2 r1 #0
        ret

; Pops one element off of the stack.
;  Takes the stack pointer in R1.
;  Returns the stack pointer in R1, popped element in R2.
;  TODO: Implement this subroutine.
POP     ldr r2 r1 #0
        add r1 r1 #1
        ret
        
PSHR3   .FILL x0000
        .END
