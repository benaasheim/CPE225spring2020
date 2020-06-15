; Performs stack-based arithmetic.
; CSC 225, Assignment 4
; Given code, Winter '20

        .ORIG x3000

MAIN    LEA R1, STACK   ; Initialize R1, the stack pointer.

LOOP    LEA R0, PROMPT  ; Print the prompt.
        PUTS
        GETC            ; Read the command into R0.
        OUT

        ; If the command is an 'a'...
IFP     LD  R3, ASCIIA
        ADD R3, R0, R3
        BRnp ELIFM
        and r0 r0 #0
        jsr POP
        add r0 r0 r2
        jsr POP
        add r0 r0 r2
        and r2 r0 r0
        jsr PUSH
        BRnzp ENDIF

        ; Else if the command is an 's'...
ELIFM   LD  R3, ASCIIS
        ADD R3, R0, R3
        BRnp ELIFN
        and r0 r0 #0
        jsr POP
        add r0 r0 r2
        jsr POP
        not r0 r0
        add r0 r0 #1
        add r2 r2 r0
        jsr PUSH
        BRnzp ENDIF

        ; Else if the command is an 'n'...
ELIFN   LD  R3, ASCIIN
        ADD R3, R0, R3
        BRnp ELIFQ
        jsr POP
        not r2 r2
        add r2 r2 #1
        jsr PUSH
        BRnzp ENDIF

        ; Else if the command is a 'q'...
ELIFQ   LD  R3, ASCIIQ
        ADD R3, R0, R3
        BRnp ELSE
        getc
        out
        BRnzp DONE

        ; Else, assume the command is '#'...
ELSE    JSR GETI
        and r2 r2 #0
        add r2 r2 r0
        JSR PUSH
        JSR OUTI
        BRnzp ENDIF


ENDIF   GETC            ; Consume the newline.
        OUT
        BRnzp LOOP      ; Loop back.

DONE    LEA R0, RESSTR  ; Pop and print an integer.
        PUTS
        JSR POP
        ADD R0, R2, #0
        JSR OUTI
        LEA R0, ENDSTR
        PUTS
        HALT            ; Halt.


; Space for a stack with capacity 16:
        .BLKW #16
STACK   .FILL x00

; Shared constants:
PROMPT  .STRINGZ "Enter a command (#N/a/s/n/q): "
RESSTR  .STRINGZ "Value on top of the stack: "
ENDSTR  .STRINGZ "\n"
ASCIIA  .FILL x-61
ASCIIS  .FILL x-73
ASCIIN  .FILL x-6E
ASCIIQ  .FILL x-71

; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH    ST  R7, PSHR7
        LDI R7, PSHADDR
        JSRR R7
        LD  R7, PSHR7
        RET
PSHR7   .FILL x0000
PSHADDR .FILL x4000

POP     ST  R7, POPR7
        LDI R7, POPADDR
        JSRR R7
        LD  R7, POPR7
        RET
POPR7   .FILL x0000
POPADDR .FILL x4001

GETI    ST  R7, GETR7
        LDI R7, GETADDR
        JSRR R7
        LD  R7, GETR7
        RET
GETR7   .FILL x0000
GETADDR .FILL x5000

OUTI    ST  R7, OUTR7
        LDI R7, OUTADDR
        JSRR R7
        LD  R7, OUTR7
        RET
OUTR7   .FILL x0000
OUTADDR .FILL x5001


        .END
