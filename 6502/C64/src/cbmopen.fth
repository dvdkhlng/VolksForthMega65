
\ include vf-lbls-cbm.fth
100 fthpage

\ Todo: all of these need error processing similar to teh
\ "no device" errors produced in the IEC code.

Code cbmopen  ( lfn ga sa fname fnlen -- status )
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

Code cbmgetio  ( -- in out)
 SP 2dec txa  SP )Y sta
   (C65n GETIO jsr )
   (C65n \ ) 3 # ldy  \ in=keyb out=screen
 txa phy  0 # ldx  SP X) sta
 pla Push0A jmp  end-code

: cbmtype ( adr n lfn -- flag )
   cbmgetio nip >r  cbmchkout
   0 -rot  bounds  ?DO
      I c@ cbmbasout
      i/o-status? ?dup IF nip LEAVE THEN
   LOOP pause
   r> cbmchkout ;
: cbminput ( adr n lfn -- flag )
   cbmgetio drop >r  cbmchkin
   0 -rot  bounds  ?DO
      cbmbasin I c!
      i/o-status? ?dup IF nip LEAVE THEN
   LOOP pause
   r> cbmchkin ;
