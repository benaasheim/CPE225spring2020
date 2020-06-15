; Implements integer I/O utilities.
; CSC 225, Assignment 4
; Given code, Winter '20

        .ORIG x5000     ; NOTE: Do not alter these addresses. They are
        .FILL GETI      ;       hardcoded within "calculator.asm", since the
        .FILL OUTI      ;       assembler cannot resolve cross-file labels.

; Reads one integer in the range {-9, ..., 9}.
;  Takes no arguments.
;  Returns the read integer in R0.
;  TODO: Implement this subroutine.
GETI    getc
        ; set value of r4 to 45 (ASCII value of negative sign)
        st r4 PSHR4
        ld  r4 ASCIId
        add r4 r4 r0
        BRnp posi
        getc
        ld r4 ASCIIn
        add r0 r0 r4
        not r0 r0
        add r0 r0 #1
        ld r4 PSHR4
        ret

posi    ld r4 ASCIIn
        add r0 r0 r4
        ld r4 PSHR4
        ret


; Prints one integer in the range {-9, ..., 9}.
;  Takes the integer in R0.
;  Returns no values.
;  TODO: Implement this subroutine.
OUTI    st r5 PSHR5
        st r4 PSHR4
        st r0 PSHR0
        and r5 r0 r0
        BRzp psit

        ;print "-"
        ld r0 ASCIIdp
        out

        ; make r5 positive (for printing)
        not r5 r5
        add r5 r5 #1
    
psit    ; convert to ASCII
        ld r4 ASCIInp
        add r0 r5 r4
        out
        ld r0 PSHR0
        ld r4 PSHR4
        ld r5 PSHR5
        ret
        
ASCIId  .FILL #-45
ASCIIdp  .FILL #45
ASCIIn  .FILL #-48
ASCIInp  .FILL #48
PSHR0   .FILL x0000
PSHR4   .FILL x0000
PSHR5   .FILL x0000
        .END
