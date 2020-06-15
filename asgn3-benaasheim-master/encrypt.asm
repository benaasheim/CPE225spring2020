; Encrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Winter '20

; TODO: Complete this program.

; R0 input character
; R1 String length
; R2 encrypted character
; R6 contains start address of unencrypted string
; R7 contains start address of encrypted string


        .orig x3000
        lea r6 StrSt
        add r6 r6 #2
        lea r0 KeyMssg
        puts
        getc
        add r2 r0 #-15
        add r2 r2 #-15
        add r2 r2 #-15
        add r2 r2 #-3
        out
ent     getc
        add r0 r0 #-10
        BRnp ent
        add r0 r0 #10
        out

        lea r0 UnMssg
        puts
        ; add each character to unencrypted string
loop    getc                ; character into r0
        out
        add r1 r0 r2
        str r1 r6 #0        ; store value of r0 at the address in r6
        add r6 r6 #1        ; add 1 to r6
        add r1 r1 #1        ; add 1 to r1
        add r0 r0 #-10      ; subtract 10 from r4
        BRp loop            ; repeat if char was not just \n


        lea r0 EnMssg
        puts
        lea r0 StrSt
        add r0 r0 #2
        puts
        
        lea r6 StrSt
        add r6 r6 #2
        ; clears storagespace
clearL  and r1 r1 #0
        str r1 r6 #0        ; store value of r0 at the address in r6
        add r6 r6 #1        ; add 1 to r6
        ldr r1 r6 #0            ; check if the next is zero
        BRnp clearL         ; if not zero repeat
        HALT
KeyMssg .STRINGZ "Encryption key (0-9): "
UnMssg  .STRINGZ "Unencrypted string: "
EnMssg  .STRINGZ "Encrypted string: "
StrSt   .STRINGZ "-"
        .END
