;; ------------------------------------------
;; BULLET HIT MONSTER -> HEALTH SYSTEM
;; ------------------------------------------

    TXA
    STA temp          ;; save monster index (other object)

    LDX temp

    LDA ObjectHealth,y
    SEC
    SBC #$01
    STA ObjectHealth,y

    BNE +done

    ;; HP reached 0 -> destroy monster
    DestroyObject

+done: