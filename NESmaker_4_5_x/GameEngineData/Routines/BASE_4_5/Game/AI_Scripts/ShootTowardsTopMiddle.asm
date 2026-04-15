;;; aim towards top-middle of screen ($80, $00)

    TYA
    PHA
    TXA
    PHA
    STA tempx
    
        ; current object position
        LDA Object_x_hi,x
        STA tempA
        LDA Object_y_hi,x
        STA tempB

        ; target position = top-middle
        LDA #$80        ; center X
        STA tempC
        LDA #$20        ; top Y
        STA tempD
        
        LDX tempx
        
    MoveTowardsPoint tempA, tempC, tempB, tempD

    ; preserve movement flags (same as your original)
    LDA Object_direction,x
    AND #%00000111
    ORA #%00001000
    STA Object_direction,x
    
    PLA
    TAX
    PLA
    TAY