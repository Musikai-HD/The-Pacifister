;;; =========================================
;;; TELEPORT ENEMY TO RANDOM Y POSITION
;;; =========================================

;;; requires:
;;; randomSeed (1 byte)

;;; update RNG seed
    LDA randomSeed
    ASL
    EOR randomSeed
    STA randomSeed

;;; get random Y
    LDA randomSeed
    AND #$E0          ; keep within vertical range (~0–224)
    STA Object_y_hi,x

;;; optional: keep X fixed
;;; LDA #$80
;;; STA Object_x_hi,x