\ This implements disk access using OPEN, SETNAM, SETLFS and friends
\ It is likely slower than using IEC bus access, however, on C65 the
\ floppy is no ton the IEC bus and can only be accessed using the
\ higher level file descriptor based APIs.

\ *** Block No. 140, Hexblock 8c
8c fthpage

( s#>s+t  x,x                 28may85re)

165 | Constant 1.t
1EA | Constant 2.t
256 | Constant 3.t

| : (s#>s+t ( sector# -- sect track)
(C65 dup 617 u> 4 and + 28 /mod ; )
(C65 \ )   dup 1.t u< IF 15 /mod exit THEN
(C65 \ ) 3 +  dup 2.t u< IF 1.t - 13 /mod 11 +
(C65 \ )                            exit THEN
(C65 \ )      dup 3.t u< IF 2.t - 12 /mod 18 +
(C65 \ )                            exit THEN
(C65 \ ) 3.t - 11 /mod 1E +  ; \ )

| : s#>t+s  ( sector# -- track sect )
 (s#>s+t  1+ swap ;

: (sectcmd)  ( sect track -- ud )
   base push  decimal
   0 <# #s drop bl hold #s bl hold
   ascii 0 hold bl hold 2drop 0d 0 #s  bl hold ;
: rdcmd ( track sect -- adr count)
   (sectcmd) ascii 1 hold   ascii u hold #> ;
: wrcmd ( track sect -- adr count)
   (sectcmd) ascii 2 hold   ascii u hold #> ;

\ *** Block No. 141, Hexblock 8d
8d fthpage

( readsector writesector      28may85re)

100 | Constant b/sek

: derror?  ( -- flag )
   cbmgetio drop
   f cbmchkin cbmbasin dup Ascii 0 =
   IF drop BEGIN cbmbasin D = UNTIL false
   ELSE BEGIN emit cbmbasin dup D = UNTIL emit true THEN
   swap cbmchkin ;

| Create doclose  0  ] r> cbmclose ;
: pushclose ( lfn -- )
   r> swap >r  doclose >r >r  ;
: readsector  ( adr tra# sect# -- flag)
   d disk d " #" count cbmopen  d pushclose
   f disk 2swap f -rot rdcmd cbmopen  f pushclose
   derror? ?dup ?exit
   b/sek d cbminput bf and ;

: writesector  ( adr tra# sect# -- flag)
   d disk d " #" count cbmopen  d pushclose
   f disk f " b-p 13 0" count cbmopen  f pushclose
   rot b/sek d cbmtype ?dup ?exit
   wrcmd f cbmtype ?dup ?exit
   derror?  cbmclrchn ;


\ *** Block No. 142, Hexblock 8e
8e fthpage

( 1541r/w                     28may85re)

\ : diskopen  ( -- flag)
 \ disk 0D busopen  Ascii # bus! busoff
 \ derror? ;
\ 
\ : diskclose ( -- )
 \ disk 0D busclose  busoff ;

: 1541r/w  ( adr blk file r/wf -- flag)
 swap Abort" no file"
 -rot  blk/drv /mod  dup (drv ! 3 u>
 IF . ." beyond capacity" nip exit  THEN
 \ diskopen  IF  drop nip exit  THEN
 0 swap   2* 2* 4 bounds
 DO  drop  2dup I rot
     IF    s#>t+s readsector
     ELSE  s#>t+s writesector THEN
     >r b/sek + r> dup  IF  LEAVE  THEN
 LOOP   -rot  2drop  ( diskclose)  ;

' 1541r/w  Is   r/w


\ *** Block No. 143, Hexblock 8f
8f fthpage

\ index findex ink-pot         05nov87re

: index ( from to --)
 1+ swap DO
   cr  I 3 .r  I block 28 type
   stop?  IF LEAVE THEN  LOOP ;

: findex ( from to --)
 \ diskopen  IF  2drop  exit  THEN
 1+ swap DO  cr  I 3 .r
   pad dup I 2* 2* s#>t+s readsector
   >r 28 type
   r> stop? or IF LEAVE THEN
 LOOP  ( diskclose)  ;
