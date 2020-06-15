; Supports interrupt-driven keyboard input.
; CSC 225, Assignment 5
; Given code, Winter '20

        .ORIG x300

; Reads one character, executing a second program while waiting for input:
;  1. Saves the keyboard entry in the IVT.
;  2. Sets the keyboard entry in the IVT to ISR180.
;  3. Enables keyboard interrupts.
;  4. Returns to the second program.
; NOTE: The first program's state must be swapped with the second's.
TRAP26                  ; TODO: Implement this service routine.
        ST R1 P1R1
        ST R2 P1R2
        ST R3 P1R3
        ST R4 P1R4
        ST R5 P1R5
        ST R7 P1R7
        LDR R1 R6 #0
        ST R1 P1PC
        LDR R1 R6 #1
        ST R1 P1PSR
        
        ;  1. Saves the keyboard entry in the IVT.
        LDI R1 KBIV     ; Load value stored at address of KBIV
        ST R1 SAVEIV    ; Store this value in SAVEIV (Save IV duh)

        ;  2. Sets the keyboard entry in the IVT to ISR180.
        LEA R1 ISR180   ; Place literal address of pointer ISR180 into R1
        STI R1 KBIV     ; Store this value at address stored in KBIV

        ;  3. Enables keyboard interrupts.
        LD R1 RNIY      ; Load Read(no),Interupt(yes) value
        STI R1 KBSR     ; SET keyboard status register value to this R1
        
        ;  4. Returns to the second program.
        LD R1 P2PC
        STR R1 R6 #0
        LD R1 P2PSR
        STR R1 R6 #1
        LD R0 P2R0
        LD R1 P2R1
        LD R2 P2R2
        LD R3 P2R3
        LD R4 P2R4
        LD R5 P2R5
        LD R7 P2R7
        RTI


; Responds to a keyboard interrupt:
;  1. Disables keyboard interrupts.
;  2. Restores the keyboard entry in the IVT.
;  3. Places the typed character in R0.
;  4. Returns to the caller of TRAP26.
; NOTE: The second program's state must be swapped with the first's.
ISR180                  ; TODO: Implement this service routine.
        ST R0 P2R0
        ST R1 P2R1
        ST R2 P2R2
        ST R3 P2R3
        ST R4 P2R4
        ST R5 P2R5
        ST R7 P2R7
        LDR R1 R6 #0
        ST R1 P2PC
        LDR R1 R6 #1
        ST R1 P2PSR
        
        ;  1. Disables keyboard interrupts.
        LD R1 RNIN ; Load Read(no),Interupt(no) value
        STI R1 KBSR ; SET keyboard status register vaule to this R1
        
        ;  2. Restores the keyboard entry in the IVT.
        LD R1 SAVEIV    ; Load value stored in Pointer SAVEIV
        STI R1 KBIV     ; Store this value at address contained in pointer KBIV

        ;  3. Places the typed character in R0.
        LDI R0 KBDR     ; Load value stored at address contained in Pointer KBDR

        ; 4. Returns to the caller of TRAP26.
        LD R1 P1PC
        STR R1 R6 #0
        LD R1 P1PSR
        STR R1 R6 #1
        LD R1 P1R1
        LD R2 P1R2
        LD R3 P1R3
        LD R4 P1R4
        LD R5 P1R5
        LD R7 P1R7
        RTI


; Program 1's data:
P1R1    .FILL x0000     ; TODO: Save the first program's state here.
P1R2    .FILL x0000
P1R3    .FILL x0000
P1R4    .FILL x0000
P1R5    .FILL x0000
P1R7    .FILL x0000
P1PC    .FILL x0000
P1PSR   .FILL x0000

; Program 2's data:
P2R0    .FILL x0000     ; TODO: Save the second program's state here.
P2R1    .FILL x0000
P2R2    .FILL x0000
P2R3    .FILL x0000
P2R4    .FILL x0000
P2R5    .FILL x0000
P2R7    .FILL x0000
P2PC    .FILL x4000     ; Initially, Program 2's PC is 0x4000.
P2PSR   .FILL x8002     ; Initially, Program 2 is unprivileged.

; Shared data:
SAVEIV  .FILL x0000     ; TODO: Save the keyboard's IVT entry here.

; Shared constants:
KBIV    .FILL x0180     ; The keyboard's interrupt vector
KBSR    .FILL xFE00     ; The Keyboard Status Register
KBDR    .FILL xFE02     ; The Keyboard Data Register
KBIMASK .FILL x4000     ; The keyboard interrupt bit's mask

; KBSR Read-able&Interrupt-able values
RYIY    .FILL xC000     
RYIN    .FILL x8000
RNIY    .FILL x4000
RNIN    .FILL x0000

        .END
