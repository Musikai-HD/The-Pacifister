;; sprite drawing routine.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; For horizontal scrolling games, extra attention has to be taken to draw 
;;; sprites off screen if they are no longer in the camera render area.

	LDA gameHandler
	AND #%01000000
	BEQ doDrawThisSprite
	JMP doneDrawingThisSprite
doDrawThisSprite:
	;;;; loaded into x is the object calling this routine.
	LDA Object_x_hi,x
	SEC
	SBC camX
	STA tempA

	LDA Object_y_hi,x
	STA tempB

	LDA Object_type,x
	BEQ +isPlayerObject
		JMP +isNotPlayerObject
	+isPlayerObject
    ;; default palette = 00000000
    LDA #%00000000

    ;; if parrying, switch to palette #%00000010
    LDA isParrying
    BEQ +usePalette
        LDA #%00000010
	+usePalette:
		STA temp3   ;; store palette

		;; DRAW PLAYER OBJECT
		DrawSprite tempA, tempB, #$00, temp3
			LDA tempA
			CLC
			ADC #$08
			STA temp1

		DrawSprite temp1, tempB, #$01, temp3
			LDA tempB
			CLC
			ADC #$08
			STA temp2

		DrawSprite tempA, temp2, #$10, temp3
		DrawSprite temp1, temp2, #$11, temp3

		JMP doneDrawingThisSprite
	+isNotPlayerObject
	;;; CHECK OTHER OBJECTS
	CMP #$01
	BEQ +isLaser
		JMP +isNotLaser
	+isLaser
		;;; DRAW LASER OBJECT, game object 1
		DrawSprite tempA, tempB, #$02, #%00000000
		JMP doneDrawingThisSprite
	+isNotLaser
	CMP #$02
	BEQ +isMonsterWeapon
		JMP +isNotMonsterWeapon
	+isMonsterWeapon
		LDA vBlankTimer
		AND #%00100000
		BEQ +isEvenFrame
			JMP +isOddFrame
		+isEvenFrame
			;;; DRAW MONSTER WEAPON, game object 2
			DrawSprite tempA, tempB, #$20, #%00000010
			JMP doneDrawingThisSprite
		+isOddFrame
			;;; DRAW MONSTER WEAPON, game object 2
			DrawSprite tempA, tempB, #$21, #%00000010
			JMP doneDrawingThisSprite
	+isNotMonsterWeapon
	CMP #$10
	BEQ +isAlien
		JMP +isNotAlien
	+isAlien
		;;; DRAW ALIEN, monster object #$10 (monster number 1)
		DrawSprite tempA, tempB, #$80, #%00000010
			LDA tempA
			CLC
			ADC #$08
			STA temp1
		DrawSprite temp1, tempB, #$81, #%00000010
			LDA tempB
			CLC
			ADC #$08
			STA temp2
		DrawSprite tempA, temp2, #$90, #%00000010
		DrawSprite temp1, temp2, #$91, #%00000010
		JMP doneDrawingThisSprite
	+isNotAlien
	CMP #$11
	BEQ +isAlienShooter
		JMP +isNotAlienShooter
	+isAlienShooter
		;;; DRAW ALIEN SHOOTER, monster object #$11 (monster number 2)
		DrawSprite tempA, tempB, #$80, #%00000011
			LDA tempA
			CLC
			ADC #$08
			STA temp1
		DrawSprite temp1, tempB, #$81, #%00000011
			LDA tempB
			CLC
			ADC #$08
			STA temp2
		DrawSprite tempA, temp2, #$90, #%00000011
		DrawSprite temp1, temp2, #$91, #%00000011
		JMP doneDrawingThisSprite
	+isNotAlienShooter
doneDrawingThisSprite:
	RTS
	
	
	
		
evaluateTileAgainstCameraPosition:

	LDA Object_x_hi,x
	STA pointer
	LDA Object_screen,x
	AND #%00001111
	STA pointer+1
	
	LDA pointer
	
				
	Compare16 pointer+1, pointer, camX_hi, camX
	; arg0 = high byte of first value
	; arg1 = low byte of first value
	; arg2 = high byte of second value
	; arg3 = low byte of second value

	+
	JMP checkRightForDrawingOffCamera
	
	++		
		DestroyObject
		LDA #$01		
		RTS
checkRightForDrawingOffCamera
	LDA Object_x_hi,x
	CLC
	ADC self_right
	STA pointer
	LDA Object_screen,x
	ADC #$00
	AND #%00001111
	STA pointer+1

	LDA camX
			
	STA pointer5
	LDA camX+1
	clc
	ADC #$01
	STA temp
	Compare16 pointer+1, pointer, temp, pointer5; camX
	+
	LDA #$01
	rts
	++
	LDA #$00
	rts
	