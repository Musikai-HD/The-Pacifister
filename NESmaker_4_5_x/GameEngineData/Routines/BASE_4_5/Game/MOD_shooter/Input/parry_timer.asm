;;; Activate Parry (call when player presses parry button)
LDA gameHandler
AND #%10000000   ;; or your transition flag
BNE +skipAllObjects

    ;; if still on cooldown, do nothing
    LDA parryCooldown
    BNE +alreadyActive

        ;; start parry
        LDA #$01
        STA isParrying
        PlaySound #$10, #03
        

        ;; set active parry time (15 frames)
        LDA #$0F
        STA parryTimer

        ;; start cooldown (60 frames)
        LDA #$3C
        STA parryCooldown

+alreadyActive:
+skipAllObjects:

    RTS