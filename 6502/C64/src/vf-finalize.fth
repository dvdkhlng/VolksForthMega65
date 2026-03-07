
\ *** Block No. 123, Hexblock 7b
7b fthpage

\ The remainder to do after loading the
\ system-dependent part of the sources.

Host  ' Transient 8 + @
  Transient  Forth  Context @ 6 + !
Target

Forth also definitions

(C16 : (16 ) (C64 : (64 ) (X16 : (CX ) (C65n : (65n ) ; immediate

(C16 : (64 ) \ jumps belhind C)
(C64 : (16 )
(X16 : (64 )
(C65n : (64 )
 BEGIN name count dup 0=
 abort" C) missing"  2 = >r
 @ [ Ascii C Ascii ) $100 * + ] Literal
 = r> and UNTIL ; immediate

\ there must be a way to do this with less than O(n^2) code.
(C16 ' (64 dup alias (CX immediate alias (65n immediate )
(C64 ' (16 dup alias (CX immediate alias (65n immediate )
(X16 ' (64 dup alias (16 immediate alias (65n immediate )
(C65n ' (64 dup alias (CX immediate alias (16 immediate )

\ (C65 is a flag defined on top of (C64 or (C65n for both the "C64
\ personality" resp. "native" C65 version.  I.e. it identifies which
\ hardware we run on, wheras (C65n indicates we run under Mega65 ROM.
(C65 : (65 ; immediate )
(C65 \ ) ' (65n dup alias (65

: C)  ; immediate

: forth-83 ;  \ last word in Dictionary



\ *** Block No. 124, Hexblock 7c
7c fthpage

( System dependent Constants      bp/ks)

Vocabulary Assembler
Assembler definitions
Transient  Assembler

PushA  Constant PushA
       \ put A sign-extended on stack
Push0A Constant Push0A
       \ put A on stack
Push   Constant Push
       \ MSB in A and LSB on jsr-stack

RP     Constant RP
UP     Constant UP
SP     Constant SP
IP     Constant IP
N      Constant N
Puta   Constant Puta
W      Constant W
Setup  Constant Setup
Next   Constant Next
xyNext Constant xyNext
(2drop Constant Poptwo
(drop  Constant Pop

Forth definitions
