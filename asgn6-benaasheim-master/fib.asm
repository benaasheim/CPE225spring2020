; Recursively computes Fibonacci numbers.
; CSC 225, Assignment 6
; Given code, Winter '20

        .ORIG x4000

; int fib(int)
; takes int n value in R0
; 
; TODO: Implement this function.
FIBFN
        ; Callee Setup
        ; leave space for return value
        add r6 r6 #-1
        ; push return address
        add r6 r6 #-1
        str r7 r6 #0
        ; push dyn link (caller's frame ptr)
        add r6 r6 #-1
        str r5 r6 #0
        ; set new frame pointer
        add r5 r6 #-1
        ; allocate space for locals 
        add r6 r6 #-2
        
        ; the thing
        ldr r0 r5 #4
        BRnz done1
        add r0 r0 #-1
        BRz done2

        ; Caller Setup
        ; push first argument
        ldr r0 r5 #4
        add r6 r6 #-1
        add r0 r0 #-1
        str r0 r6 #0
        ; call subroutine
        jsr FIBFN
        
        ; Caller Teardown
        ; load return value
        ldr r0 r6 #0
        ; perform assignment
        str r0 r5 #0
        ; pop return value
        add r6 r6 #1
        ; pop arguments
        add r6 r6 #1
        
        
        
        ; Caller Setup
        ; push first argument
        ldr r0 r5 #4
        add r6 r6 #-1
        add r0 r0 #-2
        str r0 r6 #0
        ; call subroutine
        jsr FIBFN
        
        ; Caller Teardown
        ; load return value
        ldr r0 r6 #0
        ; perform assignment
        str r0 r5 #-1
        ; pop return value
        add r6 r6 #1
        ; pop arguments
        add r6 r6 #1
        
        ; sum two results
        ldr r2 r5 #0
        ldr r3 r5 #-1
        add r0 r2 r3
        BRnzp done
        
done1   and r0 r0 #0
        BRnzp done
done2   add r0 r0 #1
done        
        ; Callee Teardown
        ; copy r0 into return value
        str r0 r5 #3
        
        ; pop local variables
        add r6 r5 #1
        
        ; pop dynamic link (into r5)
        ldr r5 r6 #0
        add r6 r6 #1
        
        ; pop return addr (into r7)
        ldr r7 r6 #0
        add r6 r6 #1
        
        ret;
        .END
        
        
        
        
        
