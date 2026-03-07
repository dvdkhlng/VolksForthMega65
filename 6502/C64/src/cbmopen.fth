
\ include vf-lbls-cbm.fth
100 fthpage

Code cbmopen  ( lfn ga sa fname fnlen -- )
  (C65n txa SETBNK jsr ( )
   5 # lda  Setup jsr
   N 8 + lda  N 6 + ldx  N 4 + ldy  SETLFS jsr
  N     lda  N 2 + ldx  N 3 + ldy  SETNAM jsr
  OPEN jsr  xyNext jmp  end-code

Code cbmclose  ( lfn -- )
  SP X) lda  CLOSE jsr
  (xydrop jmp  end-code

Code cbmchkin  ( lfn -- )
  SP X) lda  tax  CHKIN jsr  (xydrop jmp  end-code

Code cbmchkout  ( lfn -- )
  SP X) lda  tax  CHKOUT jsr  (xydrop jmp  end-code

Code cbmclrchn  ( -- )
  CLRCHN jsr  xyNext jmp  end-code

Code cbmbasout  ( chr -- )
  SP X) lda  CHROUT jsr  (xydrop jmp  end-code

Code cbmbasin  ( -- chr )
  CHRIN jsr  Push0A jmp  end-code
