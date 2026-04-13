    ;; =========================
    ;; Bullet Timer
    ;; =========================
    LDA bulletTimer
    BEQ +skipBullet
        DEC bulletTimer
+skipBullet:

    ;; =========================
    ;; Parry Active Timer
    ;; =========================
    LDA parryTimer
    BEQ +checkCooldown

        DEC parryTimer

        ;; if parry just ended
        LDA parryTimer
        BNE +doneParry

            LDA #$00
            STA isParrying

+doneParry:

+checkCooldown:

    ;; =========================
    ;; Parry Cooldown Timer
    ;; =========================
    LDA parryCooldown
    BEQ +done

        DEC parryCooldown

+done: