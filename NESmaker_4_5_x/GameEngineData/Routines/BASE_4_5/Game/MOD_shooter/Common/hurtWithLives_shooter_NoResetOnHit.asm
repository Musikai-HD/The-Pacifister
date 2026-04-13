
	;;;;;;;;;;;;;;;;;; Presumes there is a variable called myLives defined in user variables.
	;;;;;;;;;;;;;;;;;; You could also create your own variable for this.

	LDA gameHandler
	AND #%10000000
	BEQ +canHurtPlayer
		JMP +skipHurt
+canHurtPlayer:
	LDA isParrying
    BEQ +notParrying

    LDA Object_status,x
    AND #%10000000
    BEQ +notParrying        ; NOT parryable → fail parry

        JMP +createParryProjectile


+notParrying:

    Dec myLives
    LDA myLives
    BNE +continueGame

        JMP RESET

+continueGame:

    ; (your respawn / warp code unchanged)

    JMP +skipHurt

createParryProjectile:
;;; Assumes that the projectile you want to create is in GameObject Slot 01.

    TXA
    PHA
    TYA
    PHA
        LDX player1_object
        LDA Object_screen,x
   
        STA tempD
        LDA Object_x_hi,x
            CLC
        ADC #$04
        STA tempA
        LDA Object_y_hi,x
        CLC
        ADC #$04
        STA tempB
        LDA Object_direction,x
        AND #%00000111
        STA tempC
        CreateObjectOnScreen tempA, tempB, #$01, #$00, tempD
            ;;; x, y, object, starting action.
            ;;; and now with that object, copy the player's
            ;;; direction and start it moving that way.
                        ; Determine direction toward TOP-middle (force upward)
            LDA tempA          ; projectile X position
            CMP #$40
            BCC +goUpRight

            CMP #$C0
            BCS +goUpLeft

            ; centered → straight UP
            LDY #$04           ; likely UP (was previously DOWN)
            BNE +setDir

+goUpRight:
            LDY #$03           ; up-right (flipped from your previous)
            BNE +setDir

+goUpLeft:
            LDY #$05           ; up-left (flipped from your previous)

+setDir:
            TYA
            STA Object_direction,x
            LDA DirectionTableOrdered,y
            STA temp1
            TXA
            STA temp
            StartMoving temp, temp1
    PLA
    TAY
    PLA
    TAX

	LDA #$00
	STA isParrying

	STA parryTimer
	STA parryCooldown
    
    JMP +skipHurt

+skipHurt