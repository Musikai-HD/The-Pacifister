;;; =========================================
;;; ENEMY SUBROUTINE: SPAWN + SHOOT DOWN
;;; =========================================

    TYA
    PHA
    TXA
    PHA
    STA tempx

        ; spawn position (enemy position)
        LDA Object_x_hi,x
        STA tempA

        LDA Object_y_hi,x
        STA tempB

        LDA #$02        ; projectile object ID
        STA tempC

        LDA #$00        ; action step
        STA tempD

        LDA Object_screen,x
        STA tempz

        CreateObjectOnScreen tempA, tempB, tempC, tempD, tempz

        ; ---------------------------------
        ; SWITCH TO NEWLY CREATED OBJECT
        ; ---------------------------------
        LDX tempx

        ; ---------------------------------
        ; FORCE DOWNWARD DIRECTION
        ; ---------------------------------

        LDA #$04        ; DOWN (NESMaker standard)
        STA Object_direction,x

    PLA
    TAX
    PLA
    TAY