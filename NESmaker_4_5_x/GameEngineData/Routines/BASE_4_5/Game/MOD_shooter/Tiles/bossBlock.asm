	CPX player1_object
	BNE +notPlayer1
			Dec myLives
	LDA myLives
	BNE +myLivesNotZero
		JMP RESET ;; game over.
		;;;; also could warp to game over screen here instead.
+myLivesNotZero:

	LDA continueMap
	STA warpMap
	
	LDA continueScreen
	STA currentNametable
	AND #%00001111
	STA camX_hi
	
	LDX player1_object
	STA Object_screen,x
	
	LDA #$02 ;; this is continue type warp.
	STA screenTransitionType ;; is of warp type

	
	LDA #$00
	STA camX
	sta camX_lo
	
	
	
	
	LDA updateScreenData
	AND #%11111011
	STA updateScreenData
	LDA scrollByte
	AND #%00111110
	ORA #%00000010
	STA scrollByte
	LDA #$00
	STA scrollOffsetCounter
	
	LDA gameHandler
	ORA #%10000000
	STA gameHandler ;; this will set the next game loop to update the screen.
	
	LDA #$05 
	STA bossHealth ;; resets boss health for this level.

+skipHurt
	JMP +done
	+notPlayer1
	
	LDA Object_flags,x
	AND #%00000100 ;; is it a player weapon?
	BEQ +notPlayerWeapon ;; player weapon was not ticked.
		;; it WAS a player weapon.
		DestroyObject
		DEC bossHealth
        LDA bossHealth
        BNE +notPlayerWeapon

            ;; === BOSS DEFEATED ===

            INC bossesKilled

            LDA bossesKilled
            ASL A
            ASL A
            CLC
            ADC #$05
            STA bossHealth

            LDA #$01
            STA bossByte

            ;; === WARP ===
            LDA screenUpdateByte
            ORA #%00000100
            STA screenUpdateByte

            LDA warpToMap
            STA warpMap
            
            LDA warpToScreen
            STA currentNametable
            
            LDX player1_object
            STA Object_screen,x
            
            LDA #$01
            STA screenTransitionType

            LDA gameHandler
            ORA #%10000000
            STA gameHandler

            JMP +done
			

+notPlayerWeapon
	
	
+done