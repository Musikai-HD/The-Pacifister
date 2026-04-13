;;; =========================================
;;; TELEPORT ENEMY TO RANDOM X POSITION
;;; =========================================

;;; requires:
;;; randomSeed (1 byte)

;;; update RNG seed
    LDA randomSeed
    ASL
    EOR randomSeed
    STA randomSeed

;;; get random X
    LDA randomSeed
    AND #$F0          ; keep within screen range (0–240)
    STA Object_x_hi,x

;;; optional: keep Y fixed (top of screen)
;;; LDA #$F0
;;; STA Object_y_hi,x