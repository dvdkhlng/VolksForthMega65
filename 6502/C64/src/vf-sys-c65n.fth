
include vf-lbls-cbm.fth

\ *** Block No. 127, Hexblock 7f
7f fthpage

\ Mega65 (C65) ROM labels (extending vf-lbls-cbm)
\ As of this writing, latest stable ROM is 920413 (v0.97)
FF35 >label CURSOR  \ not before ROM v920415
FF32 >label RESET_RUN
FF41 >label GETIO
FF6B >label SETBNK
CHROUT >label ConOut

\ VIC labels

0d020 >label BrdCol
0d021 >label BkgCol

\ From 65site.de, not official Mega65 APIs
00E0 >label pnt
00EC >label pntr
00F4 >label QtSw
00F5 >label Insrt
11FF >label blnon 
1120 >label blnsw
1121 >label blnct
1122 >label gdbln

\ *** Block No. 129, Hexblock 81
81 fthpage

\ C64 c64key? getkey

here >label keybuf  0 c,

Code c64key? ( -- flag)
  keybuf lda
  0= ?[ GETIN jsr  keybuf sta ]?
  tax 0<> ?[  0FF # lda  ]? pha
  Push jmp
end-code

\ todo: need pause  for the multitasker:
\ todo2: CURSOR not working as advertised!
Code getkey  ( -- 8b)
  keybuf lda
  0= ?[ GETIN jsr ]?
  0 # ldx  keybuf stx
  Push0A jmp
end-code

\ *** Block No. 130, Hexblock 82
82 fthpage

\ C64 curon curoff

\ Code curon   ( --)
\   clc   CURSOR jsr
\   xyNext jmp
\ end-code

\ Code curoff   ( --)
\   sec   CURSOR jsr  \ todo: compact.
\   xyNext jmp
\ end-code

Code curon   ( --)
   \ pntr ldy  pnt )Y lda  gdbln sta
   blnsw stx
 xyNext jmp   end-code

Code curoff   ( --)
   \ this produces screen artifacts on backspace.
   iny  blnsw sty ( blnct sty  blnon stx)
 \ gdbln lda  pntr ldy  pnt )Y sta
 1 # ldy  Next jmp   end-code

: c64key  ( -- 8b)
 curon BEGIN pause getkey ?DUP UNTIL
 curoff ;


\ *** Block No. 131, Hexblock 83
83 fthpage

( #bs #cr ..keyboard         clv12.4.87)


14 Constant #bs   0D Constant #cr

: c64decode
 ( addr cnt1 key -- addr cnt2)
  #bs case?  IF  dup  IF del 1- THEN
                            exit  THEN
  #cr case?  IF  dup span ! exit THEN
  >r  2dup +  r@ swap c!  r> emit  1+ ;

: c64expect ( addr len1 -- )
 span !  0
 BEGIN  dup span @  u<
 WHILE  key  decode
 REPEAT 2drop space ;

Input: keyboard   [ here input ! ]
 c64key c64key? c64decode c64expect ;

\ *** Block No. 143, Hexblock 8f
\ ... continued
8f fthpage

Create ink-pot
\ border bkgnd pen  0
  6 c,   6 c,  3 c, 0 c,  \ Forth
 0E c,   6 c,  3 c, 0 c,  \ Edi
  6 c,   6 c,  3 c, 0 c,  \ User


\ C64:Init                     06nov87re

: init-system   \ $FF40 dup $C0 cmove
 \ [ restore ] Literal  dup
 \ $FFFA ! $318 !
;  \ NMI-Vector to RAM

Label first-init
 sei cld
IOINIT jsr  CINT jsr  RESTOR jsr

  \ init. and set I/O-Vectors
 ink-pot    lda BrdCol sta \ border

ink-pot 1+ lda BkgCol sta \ backgrnd

\ ink-pot 2+ lda PenCol sta \ pen ? terminal esc instead?
\ research proper VIC init for C65
  \ 0 # lda  $D01A sta  \ VIC-IRQ off
\ $1B # lda  $D011 sta  \ Textmode on
\ beware of the "hot registers"  semantic!
 \ 02 # lda  d06a sta  \  CBM font, shifted
 \ d8 # lda  d069 sta  
\ 00 # lda  d068 sta
$27 # lda  $D018 sta  \ low/upp +
 cli rts end-code
first-init dup bootsystem 1+ !
               warmboot   1+ !
Code c64init first-init jsr
 xyNext jmp end-code

Code (bye
  0 # lda  \ kernal warm boot
  RESET_RUN jsr
end-code

