
\ *** Block No. 0, Hexblock 0

\\ Directory volksFORTH 4of4   26oct87re  \ \ Tu heading left right        20oct87re

.                          0              \ | Variable xpos     | Variable ypos
..                         0              \ | Variable deg      | Variable pen
C16-Tape-Demo              2
C64-Grafic-Demo            6              \ | : 100*/  ( n1 n2 n3 - n4)  &100 */ ;
cload/csave              &13
Tape-Version:LoadScreen  &16              \ : heading     ( - deg)    deg @ ;
Ramdisk                  &21              \ : setheading  ( deg -)    deg ! ;
Supertape                &32
auto-Decompiler          &51              \ : right  ( deg -)
Screenswitch             &61              \  deg @ swap - &360 mod deg ! ;
Grafic                   &64
Math                     &90              \ : left   ( deg -)
Sieve Benchmark         &138              \  deg @ + &360 mod deg ! ;
Grafic-Demo             &144
Sprite-Demo             &160
Sprite-Data             &165              \ ' clrscreen  Alias cs
Sprite-Editor           &166              \ ' pencolor   Alias pc
                                          \ ' background Alias bg
                                          \ ' hires      Alias fullscreen
                                          \ ' window     Alias splitscreen




\ *** Block No. 1, Hexblock 1

\\ Content volksFORTH 4of4     26oct87re  \ \ Tu positions pen home        20oct87re

Directory                       0         \ : xcor    ( - x)     xpos @ 100u/ ;
Content                         1         \ : ycor    ( - y)     ypos @ 100u/ ;

C16-Tape  -Demo           &2-  &5         \ : setx    ( x -)     100* xpos ! ;
C64-Grafic-Demo           &6- &12         \ : sety    ( y -)     100* ypos ! ;
cload csave              &13- &15         \ : setxy   ( x y -)   sety setx ;
Tape-Version:LoadScreen  &16- &20
Ramdisk                  &21- &30         \ : pendown  pen on ;
                              &31 free    \ : penup    pen off ;
Supertape                &32- &50
automatic Decompiler     &51- &60         \ : home
Screens via UserPort C64 &61- &63         \  &160 &96 setxy &90 setheading pendown ;
Grafic  C64 only!!       &64- &88
                              &89 free    \ : draw     clrscreen home &20 window ;
Math                     &90- &96         \ : nodraw   text page ;
                         &97-&100 free
Tape Ramdisk Supertape  &101-&135 shadow
                                          \ ' left       Alias lt
Sieve Benchmark              &138         \ ' right      Alias rt
Grafic-Demo C64 only!!  &144-&155         \ ' setheading Alias seth
Sprite-Demo C64 only!!  &160-&164         \ ' pendown    Alias pd
Sprite-Data                  &165         \ ' penup      Alias pu
Sprite Editor           &166-&168

\ *** Block No. 2, Hexblock 2

\ DemoL:C16Tape-Demo ?dload   clv10oct87  \ \ Tu forward back              20oct87re

\ Demo: 80 Screens in total !!!           \ : tline   ( x1 y1 x2 y2 -)
\ checks if a word is defined:            \  >r >r >r  100u/  r> 100u/
                                          \         r> 100u/  r> 100u/  line ;
| : exists? ( string--flag)
      cr capitalize dup find nip under    \ : forward  ( distance -)
      0= IF ." not " THEN ." found: "     \  >r xpos @ ypos @
      count type ;                        \  over deg @ cos r@ 100*/ + dup xpos !
                                          \  over deg @ sin r> 100*/ + dup ypos !
\ last accessed diskf:                    \  pen @ IF tline ELSE 2drop 2drop THEN ;

| Variable LastDisk   -1 LastDisk !       \ : back     ( distance -)
                                          \  negate forward ;
\ load SCR from DISK, if WORD named
\ STRING is not in Forth Dictionary       \ : turtlestate ( - pen bg pc)
| : ?dload  ( string scr disk--)          \  pen c@ colram c@ dup
  2 pick exists?                          \  &15 and swap &16 / ;
  IF drop drop drop exit THEN
  dup LastDisk @ -                        \ ' forward     Alias fd
  IF flush ."  Insert #" dup .            \ ' back        Alias bk
     key drop  dup LastDisk ! THEN        \ ' turtlestate Alias ts
  drop ."  scr#" dup . cr
  load exists? 0= error" ???" ;
-->

\ *** Block No. 3, Hexblock 3

\ DemoL:?reloc                clv10oct87  \ \ Gr arc ellipse circle        20oct87re

\ relocates system call COLD if necces.   \ : arc     ( hr vr strt end -)
| : ?reloc  ( s0 r0 limit --)             \  >r >r 2dup max &360 swap /
 dup           limit =                    \  r> 2* 2* r> 1+ 2* 2* swap rot >r
 2 pick origin $a + @ = and               \   DO over I 2/ 2/ cos &10005 */
 3 pick origin  8 + @ = and               \      over I 2/ 2/ sin &10005 */
                                          \      plot
 IF drop drop drop exit THEN              \   r@ +LOOP
        ['] limit >body ! \ limit         \  r> 2drop drop ;
            origin $A + ! \ r0
    dup 6 + origin   1+ ! \ task          \ : ellipse ( x y hr vr -)
            origin  8 + ! \ s0            \  2swap c-y ! c-x ! m-flag on
 cold ;                                   \  0 &90 arc m-flag off ;

\ compiles forward references that will   \ : circle  ( x y r -)
\ be loaded later                         \  dup 3 4 */ ellipse ;
| : (forward"    "lit capitalize find
 IF execute
 ELSE count type ."  unsatisfied" quit
 THEN ; restrict
| : forward"  compile (forward" ," ;
 immediate  restrict
-->


\ *** Block No. 4, Hexblock 4

\ DemoL:64kb C16Demo          clv10oct87

\ configures system for 64K if possible

: 64kb $533 @ $fd00 -  ?dup
 IF cr u. ." too small" exit THEN
 limit $fd00 -
 IF $8000 $8400 $fd00 ?reloc THEN ;

\ will be installed as 'RESTART:

: c16demo  cr ." c16-Demo"
  forward" tapeinit"
  0 drive   forward" floppy"
  cr ." Type 'help' to get help"
  cr ." Type '64kb' to use 64kb" ;







-->


\ *** Block No. 5, Hexblock 5

\ DemoL:C16DemoLoad          cclv14oct87  \ \ Math Load-Screen            20oct87re

\ This word load the complete             \ Onlyforth
\ Demo-Version. Will be installed as
\ 'COLD and later as C16DEMO              \ base @  decimal

| : c16DemoLoad                           \    1  2 +thru  \ Trigonometry
  $9000 $9400 $c000 ?reloc                \    3  4 +thru  \ roots
  Forth     " Code"       5 3 ?dload      \    5  6 +thru  \ 100* 100u/
  Forth     " Editor"   $13 3 ?dload
  Forth     " debug"    $2f 3 ?dload      \ base !
  Forth     " help"      $a 1 ?dload
  Forth     " Tapeinit" $10 4 ?dload
  ['] noop    Is 'cold
  ['] c16demo Is 'restart
  forward" Editor" forward" Ediboard"
  1 scr !  0 r# !       save
  $7a00 $7bf0 $8000 ?reloc ;

' c16DemoLoad Is 'cold  save

cr .( Type : cold)
cr .( after all: savesystem!!!)



\ *** Block No. 6, Hexblock 6

\ Graphic-Demo for C64        23oct87re   \ \ Ma sinus-table               20oct87re
                                          \ \    Sinus-Table from FD Vol IV/1
(16 .( Not for C16!) \\ C)
                                          \ | : table    ( values n -)
Onlyforth                                 \  Create 0 DO , LOOP
                                          \  ;code       ( n - value)
\needs buffers      .( Buffers?!)    \\   \  SP X) lda  clc  1 # adc  .A asl  tay
\needs demostart    .( Demostart?!)  \\   \  W )Y lda  SP X) sta
\needs tasks        .( Tasker??!)    \\   \  iny  W )Y lda  1 # ldy  SP )Y sta
\needs help         .( help??!)      \\   \  Next jmp  end-code
\needs graphic      &58 +load
\needs .message2    1 2 +thru             \ 10000 9998 9994 9986 9976 9962 9945 9925
Graphic also                              \  9903 9877 9848 9816 9781 9744 9703 9659
\needs moire        6 +load               \  9613 9563 9511 9455 9397 9336 9272 9205
                                          \  9135 9063 8988 8910 8829 8746 8660 8572
\needs slide  &154 +load  \ the Demo      \  8480 8387 8290 8192 8090 7986 7880 7771
                                          \  7660 7547 7431 7314 7193 7071 6947 6820
 3 5 +thru                                \  6691 6561 6428 6293 6157 6018 5878 5736
                                          \  5592 5446 5299 5150 5000 4848 4695 4540
1 Scr !  0 R# !                           \  4384 4226 4067 3907 3746 3584 3420 3256
                                          \  3090 2924 2756 2588 2419 2250 2079 1908
save                                      \  1736 1564 1392 1219 1045 0872 0698 0523
                                          \  0349 0175 0000

                                          \ &91 | table sintable

\ *** Block No. 7, Hexblock 7

\ demo-version                 06nov87re  \ \ Ma sin, cos, tan             20oct87re

| : (center."  "lit count                 \ | : s180   ( deg -- sin*10000:sin 0-180)
 C/L over - 2/ spaces type cr ;           \  dup &90 >
restrict                                  \    IF &180 swap - THEN
                                          \  sintable ;
| : c."  compile (center." ," ;
immediate restrict                        \ : sin     ( deg -- sin*10000)
                                          \  &360 mod dup 0< IF &360 + THEN
| : .FGes c." Forth Gesellschaft e.V." ;  \  dup &180 >
                                          \     IF &180 - s180 negate
| : .vF83  c." *** volksFORTH-83 ***" ;   \     ELSE s180 THEN ;

| : .(c)   c." (c) 1985-2006"             \ : cos     ( deg -- cos*10000)
c." Bernd Pennemann  Klaus Schleisiek"    \  &360 mod &90 + sin ;
c." Georg Rehfeld  Dietrich Weineck"
c." Claus Vogt  Ewald Rieger "            \ : tan     ( deg -- tan*10000)
c." Carsten  Strotmann  " ;               \  dup sin swap cos ?dup
                                          \    IF &100 swap */ ELSE 3 * THEN ;
| : .source  c." www.forth-ev.de"
      cr     c." volksforth.sf.net" ;


| : wait   BEGIN  key 3 -  UNTIL ;


\ *** Block No. 8, Hexblock 8

\ demo-version                 20oct87re  \ \ Ma sqrt 1                    20oct87re

: .message1  ( -- )   singletask          \ Code d2*  ( d1 - d2)
 page .vF83 cr .(c) cr                    \  2 # lda setup jsr
 c." volksForth is free software"         \  N 2+ asl N 3 + rol  N rol N 1+ rol
 c." see file COPYING in the"             \  SP 2dec N 3 + lda SP )y sta
 c." distribution package"                \  N 2+ lda SP x) sta
 multitask wait ;                         \  SP 2dec N 1+ lda SP )y sta
                                          \  N lda SP x) sta
: .message2  ( -- )                       \  Next jmp end-code
 page c." You now have created a"
 c." worksystem with Editor,"             \ : du< &32768 + rot &32768 + rot rot d< ;
 c." Debugger and Assembler!"             \ | : easy-bits  ( n1 -- n2)
 c." Please insert an empty, formatted"   \  0 DO
 c." Disk and save the new system with"   \   >r d2* d2*  r@ -  dup 0<
 c." SAVESYSTEM <name> (eg. FORTH)"       \     IF   r@ +   r> 2* 1-
 c." as a loadable program file"          \     ELSE        r> 2* 3 +
 cr .vF83 cr                              \     THEN LOOP ;
 c." Information on volksForth from"
 .FGes c." on:" cr .source wait ;         \ | : 2's-bit
                                          \  >r d2* dup 0<
                                          \   IF    d2* r@ - r> 1+
                                          \   ELSE  d2* r@ 2dup u<
                                          \    IF drop r> 1-  ELSE -  r> 1+  THEN
                                          \   THEN ;

\ *** Block No. 9, Hexblock 9

\ demo-version                 20oct87re  \ \ Ma sqrt 2                    20oct87re

graphic  also                             \ | : 1's-bit
                                          \  >r dup 0<
| Variable end?                           \   IF 2drop r> 1+
                                          \   ELSE d2* &32768 r@  du< 0=
: killdemo  ( -)                          \     negate R> +
 killsprites endslide                     \   THEN ;
 singletask  .message2
 ['] 1541r/w Is r/w                       \ : sqrt    ( ud1 - u2)
 ['] noop Is 'cold                        \  0 1  8 easy-bits
 ['] noop Is 'restart                     \  rot drop 6 easy-bits
 ['] (quit   Is 'quit                     \  2's-bit 1's-bit ;
 nographic
 [ ' demostart >name 4 - ] Literal        \ \\
 (forget  save  &16 buffers ;
                                          \ : xx
                                          \  &16 * &62500 um*
                                          \  sqrt 0 <# # # # ascii . hold #s #>
                                          \  type space ;






\ *** Block No. 10, Hexblock a

\ demo-version                 06nov87re  \ \ 100*                         20oct87re

| : demor/w  ( adr blk r/wf - f)          \ Code 100*  ( n1 - n2)
 end? @  0 max  dup small  red colored    \  SP X) lda  N sta  SP )Y lda  N 1+ sta
 -1 end? +!  sprite push  killsprites     \  N asl N 1+ rol  N asl N 1+ rol
 1541r/w ;
                                          \  N lda N 2+ sta  N 1+ lda N 3 + sta
| : demoquit
  BEGIN .status cr query interpret        \  N 2+ asl N 3 + rol  N 2+ asl N 3 + rol
   state @ IF   ."  compiling"            \  N 2+ asl N 3 + rol
           ELSE ."  vF83" THEN
   end? @ 0< dup                          \  clc N lda N  2+ adc N sta
   IF drop                                \   N 1+ lda N 3 + adc N 1+ sta
    cr ." Kill the Demo? n/y "
    key capital Ascii Y =                 \  N 2+  asl N 3 + rol
    dup not IF  del del del  THEN
   THEN                                   \  clc N lda N  2+ adc  SP X) sta
  UNTIL  killdemo ;                       \   N 1+ lda N 3 + adc  SP )Y sta

                                          \  Next jmp end-code






\ *** Block No. 11, Hexblock b

\ demo-version                 20oct87re  \ \ 100/                         20oct87re

: demonstration                           \ Label 4/+
 Onlyforth graphic                        \  N 7 + lsr N 6 + ror N 5 + ror N 4 + ror
 ['] demor/w Is r/w                       \  N 7 + lsr N 6 + ror N 5 + ror N 4 + ror
 ['] killdemo Is 'cold                    \  clc N  lda N 4 + adc N     sta
 slide multitask pause   4 end? !         \   N 1+  lda N 5 + adc N 1+  sta
 ['] demoquit Is 'quit                    \   SP X) lda N 6 + adc SP X) sta
 ['] (error errorhandler !                \   SP )Y lda N 7 + adc SP )Y sta  rts
 ['] noop Is 'abort
 .message1  linien text                   \ Code  100u/  ( u - n)
 key drop  moire text  key drop           \  N stx  N 4 + stx
 ." help" row 1- 0 at abort ;             \  SP X) lda  .A asl N 1+  sta  N 5 + sta
                                          \  SP )Y lda  .A rol SP X) sta  N 6 + sta
' demonstration Is 'cold                  \  txa .A rol        SP )Y sta  N 7 + sta
' killdemo Is 'restart                    \  4/+ jsr
                                          \  N 7 + lsr N 6 + ror N 5 + ror N 4 + ror
                                          \  4/+ jsr
                                          \  Next jmp end-code







\ *** Block No. 12, Hexblock c

\ hires demo words             06nov87re

: linien
 clrscreen yel blu colors hires
 &320 0 DO
    &320 0 DO I &198 J 0 line &35 +LOOP
 &35 +LOOP ;

: moire
 clrscreen ora red colors hires
 &320 0 DO
  I &198 &319 I - 0 line
 3 +LOOP
 &199 0 DO
  &319 &198 I - 0 I line
 2 +LOOP ;










\ *** Block No. 13, Hexblock d

\ cSave cLoad..               clv10oct87  \ \\ for csave cload            clv10oct87

Onlyforth
\needs Code   .( need Assembler!) quit    \ The Assembler must be loaded

$ff90 >label setMsg   $90 >label status
$ffba >label setlfs $ffbd >label setNam   \ set Labels
$FFD8 >label BSAVE  $FFD5 >label BLOAD
Label slPars
 setup jsr (16 rom C)                     \  Save parameter starting at N
 $80 # lda setMsg jsr 0 # lda status sta  \  Enable SysMessages    Status to 0
 N lda sec 8 # sbc  (drv    sta           \  (set drv for derror?
       CC ?[ dex ]? (drv 1+ stx           \  Device#, Sec.Address, File#
 N ldx     N  1+ ldy 1 #  lda setlfs jsr  \  Address-of-Filename Length
 N 4 + ldx N 5 + ldy N 2+ lda setnam jsr  \  Address in XY
 N 6 + ldx N 7 + ldy
 rts end-code
Label slErr \ AR=Kernalerror              \  One of 8 Kernalerrors?
 CC ?[ 0 # lda ]? pha                     \  check Status/destroy EOI-Bit
 status lda $bf # and                     \  send both back as Error Number
 (16 ram C) push jmp end-code
-->


FORTH-GESELLSCHAFT (c) bp/ks/re/we/clv

\ *** Block No. 14, Hexblock e

\ ..cSave cLoad               clv10oct87  \ \\ for ..csave cload          clv10oct87

Code cSave ( f t+1 Name Nlen dev--err)
 5 # lda    SLPars jsr                    \  prepare Parameter     (XR=to+1)
 N 8 + # lda bsave jsr                    \  Pointer to from in AR and BSAVE
 slErr jmp end-code                       \  Error?

Code cLoad ( f Name Nlen dev--t+1 err)
 4 # lda    SLPars jsr                    \  prepare Parametr      (XR=from)
 0 # lda     bload jsr                    \  Load (no Verify) BLOAD
 php pha tya pha txa pha 0 # ldy          \  to+1 will be given back
 SP 2dec pla SP )y sta iny pla SP )Y sta  \  place on the Forth Stack
 pla plp slErr jmp  end-code              \  Error?

-->

\\ possible errors                        \ Errorsources for CBM-Routinen:
 AR CF ST                  Basic  Forth   \ (1) Kernal-Result
 xx  L 00 no error            0     0     \ (2) Status-Register
 00  H 00 stop-key           1e    1e     \ (3) Disk-Errorchannel
 00  L 60 end-of-tape        04    00
 00  L 10 load/verify-error  1d/1c 1d
 00  L 60 Checksumerror      1d    1d
0-8  H 00 Kernal-Error       0-8  0-8
FORTH-GESELLSCHAFT (c) bp/ks/re/we/clv

\ *** Block No. 15, Hexblock f

\ ..cSave cLoad Luxus         clv10oct87  \ \\ for ..csave cload Luxus    clv10oct87


Code .err ( err#-err# ) \ prints message
 SP x) lda 0>=                            \ This routine is using the BASIC
 ?[ (16 tax dex rom $8654 jsr C)          \ Basic-Errormessages, so that the
    (64 .A asl tax rom                    \ messages doesn need to be defined
    $a326 ,x lda $24 sta                  \ again. This is using the BASIC ROM.
    $a327 ,x lda $25 sta dey C) dey       \ The BASIC Rom should only be used if
    [[ iny $24 )y lda php  $7f # and      \ no Site Effects occur, which is the
       $ffd2 jsr plp 0< ?]                \ case here.
    (16 ram C) (64 ram C)
  ]? xyNext jmp end-code


: derr?  ( err# -- flag)
 dup IF cr dup u. .err ." error" THEN     \ creates an Errormessage from Error-
 dup $ff and 5 = not                      \ number
 (drv @ -1 > and                          \ If not "device not presen"
 IF derror? or THEN                       \ if is querying the serial bus for
 (drv @ 0 max (drv ! ;                    \ device error message

\\ for usage after CSAVE and CLOAD.
   The last line is only for
   Compatibility with old version.

\ *** Block No. 16, Hexblock 10

\ TapeVersion:LoadScreen      clv12oct87  \ \\ for TapeVersion            clv01aug87

Onlyforth                                 \ The Tapeversion was developed for C16
                                          \ with 64kB, but also works on the C64
\needs Code  .( ?! Code !?)   quit

              5 +load    \ Ramdisk        \ It conists of 3 parts
             -3 +load    \ csave/load     \    A virtual floppy in memory (Ramdisk)
           1  3 +thru    \ Tape           \    An Interface to the external Device
        (16 $10 +load C) \ superTape      \      Tape Recorder
              4 +load    \ savesys        \    Supertape loader
                                          \      (only for C16)
Onlyforth
Variable autoload   autoload off

: tapeInit  cr cr ." Tape2.00 "
 \if supertape supertape                  \ Initializing:
 ['] ramr/w Is r/w  1 drive               \  init Supertape if possible
 autoload @                               \  redefine and activate R/W
 IF autoload off loadramdisk THEN ;       \  if AUTOLOAD enabled, load Ramdisk

save
' tapeInit Is 'restart
\ restart


\ *** Block No. 17, Hexblock 11

\ store restore               clv24jul87

\ wie push pull abort"

| Create restore 0  ] r> r> ! ;

: store ( addr -- )
 r> swap dup >r @ >r  restore >r >r  ;
 restrict
\ rstack:   restore date address ....

| : back \ -- \ rewinds rstack
 r> BEGIN rdepth WHILE
      r> restore =
      IF r> r> ! THEN REPEAT >r ;

: (restore"    "lit swap IF
   >r clearstack r> back
   errorhandler perform
 exit THEN  drop ;  restrict


: restore"  compile (restore" ," ;
 immediate  restrict


\ *** Block No. 18, Hexblock 12

\ tape-interface              clv01aug87

\needs cload   .( ?! cload ?!)   quit
\needs restore .( ?! restore ?!) quit

Variable device      0 device !
: commodore     1 device ! ; \ device..
: floppy        8 device ! ;


: bload  ( [from name count -- ]to)
  device @ cload derr? restore" load" ;

: bsave  ( [from ]to name count--)
  device @ csave derr? restore" save" ;

: n" ( -- adr count) Ascii " parse ;









\ *** Block No. 19, Hexblock 13

\ Ramdisk TapeInterface       clv29jul87

Onlyforth Ramdisk also

: saveRamDisk
  rd behind id count bsave ;


: loadRamDisk
 rd? 0=
 IF range memtop  rdnew rd THEN
 " RD." count bload drop ;














\ *** Block No. 20, Hexblock 14

\ \if savesystem"             clv01aug87

\needs restore" .( ?! restore" ?!) quit

Onlyforth

: \if name find 0=
 IF [compile] \ THEN drop ; immediate

: savesystem \ -- name must follow
 \ Forth-Kernal a la boot:
   scr store 1 scr ! r#  store 0 r# !
 \ Editor  a la boot
  \if Editor  [ Editor ]
  \if Editor stamp$ store stamp$ off
  \if Editor (pad   store (pad   off
   save
 \ Supertape? if then other routine
  \if supertape device @ 7 =
  \if supertape IF stSavSys exit THEN
 \ now we save
   origin $17 - here n" bsave ;




\ *** Block No. 21, Hexblock 15

\ RD: loadscreen              clv01aug87  \ \\ for RD: loadscreen         clv05aug87

Onlyforth                                 \ This Ramdisk is using a compressed
                                          \ format
(16 $fd00 C) (64 $c000 C)
Constant memtop                           \ To allow switching of ramdisks, the
                                          \ code contains one variable (RD that
Vocabulary Ramdisk                        \ contains a pointer to the ramdisk.
Ramdisk also definitions                  \ All other variables are stored in the
                                          \ Ramdisk Memory area
      1   9 +thru

Onlyforth                                 \ Binaerblocks must be marked with BINARY
                                          \ this Ramdisk support all Block Forth-
                                          \ Words that use R/W











\ *** Block No. 22, Hexblock 16

\ RD: basics                  clv01aug87  \ \\ For RD:                    clv01aug87

Variable (rd     (rd off                  \ \ All Pointers are offsets from First
$31 constant plen
                                          \ rd ==0 ==>   no Ramdisk
: adr>   ( adr--ofs) (rd @ -          ;
: >adr   ( ofs--adr) (rd @ +          ;   \ rd -->Length of Parametrblock
: adr@   ( ofs--adr) >adr @ >adr      ;   \ +2 -->current Block
: rd?    ( -- adr flag )                  \ +4 -->End of last Block+1
   (rd @ dup   dup   @ plen =     and ;   \ +6 -->End of Ramdisk-Area+1
: rd     ( -- adr)                        \ +8 -->Number of current Block
   rd? 0= abort" no Ramdisk" ;            \ +16-->Name
                                          \ End of Parameterblock
| : take   ( adr--   ) adr> 2 >adr !  ;   \      1.RD-Block
                                          \      2.RD-Block
: adr    ( --adr   ) 2   adr@         ;   \        .
: data   ( --adr   ) adr 4 +          ;   \      0000

| : end    ( --adr   ) 4   adr@       ;   \ adr-->current RD-Block (absolute Addr)
: behind ( --adr   ) end 4 +          ;   \    -->Length (incl. 4 bytes RD-Data)
| : end+   ( len--   ) 4   >adr +!    ;   \  2+-->Blocknumber
                                          \  2+-->..Data..
: blk#   ( --adr   ) 8   >adr         ;
: id     ( --adr   ) $10 >adr         ;


\ *** Block No. 23, Hexblock 17

\ RD: new delete len@ len!    clv01aug87  \ \\ for RD:                    clv01aug87

| : ?full      end 6 adr@ b/blk - 4 -     \ NEW checks for enough space and
             u> abort" Ramdisk full" ;    \     set current block to free space

| : new ( --)  end take ?full ;

| : len! ( len--) \ end new block         \ LEN! stores the length of new block
 ?dup 0= ?exit                            \     and patches END
 blk# @   end 2+ !  4 + dup end !         \     If length is=0 nothing happends
 end+  end off ;                          \     Creates 0000 at the End of Ramdisk

| : len@ ( --len) \ gen length            \ LEN@ returns length of current Block
 adr @ dup 0= ?exit 4 - ;                 \     If not available, returns 0


: delete  ( --)                           \ DEL deletes current block and patches
 adr dup @ under + adr behind over -      \     END
 cmove
 negate end+ ;






\ *** Block No. 24, Hexblock 18

\ RD: search binary           clv01aug87  \ \\ for RD:                    clv01aug87

: search ( blk --) \ set current Block    \ SEARCH set current block to searched
 rd BEGIN dup @ + dup @ WHILE             \   Block, if not found, to END
  ( blk adr ) 2dup 2+ @ = UNTIL           \   Blocknumber will be stored in BLK#
 take  blk# ! ;

| : notRD? ( blk--flag) blk/drv u< ;








Onlyforth Ramdisk also

: binary ( blk--blk) \ no ComPand         \ BINARY disables compression of Block
 dup offset @ + notRD? ?exit              \   for example for Binary-Data
 dup block drop update                    \   A binary block will be detected if
 delete new b/blk len! ;                  \   length is $400




\ *** Block No. 25, Hexblock 19

\ RD: cbm>7bit 7bit>cbm       clv01aug87  \ \\ for RD: c>7 7 >c           clv01aug87

Label cbm>7b \ AR=char -- 7bitChar        \ Convert CBM-Chars to 7bit
 $80 # cmp 0< ?[ rts ]?                   \ All chars $c0..$e0 will be $60..80
 $c0 # cmp CS ?[ $e0  # cmp CC ?[         \ All other >=$80 will be $00..20
       $a0 # adc rts ]? ]?
 $1f # and       rts end-code
Label 7b>cbm \ AR=7bitChar -- char
 $60 # cmp CC ?[ rts ]?
 $a0 # sbc rts end-code

Code c>7 sp x) lda cbm>7b jsr putA jmp
Code 7>c sp x) lda 7b>cbm jsr putA jmp
end-code












\ *** Block No. 26, Hexblock 1a

\ RD: cp1 cp2                 clv01aug87  \ \\ for RD: cp1 cp2            clv01aug87

Label cp1 ( from to count--tocount)       \ Start routine for COMPRESS & EXPAND
 3 # lda setup jsr N 2+ lda N 6 + sta
 N 3+ lda N 7 + sta dey  $7f # ldx
 N lda 0=
 ?[ N 1+ lda 0= ?[ pla pla 0 # lda
   push0a jmp ]? ][ N 1+ inc ]? rts

Label cp2                                 \ Endroutine for COMPRESS & EXPAND
 sec N 2+ lda N 6 + sbc pha
     N 3+ lda N 7 + sbc push jmp














\ *** Block No. 27, Hexblock 1b

\ RD: expand compress         clv01aug87  \ \\ for RD: expand compress    clv01aug87

Code expand  cp1  jsr
 [[ [[ N 4 + )y lda 0<
  ?[ $7f # and tay tax bl # lda
   [[ N 2+ )y sta dey 0< ?] iny
   sec txa
   N 2+ adc N 2+ sta CS  ?[ N 3+ inc ]?
  ][ 7b>cbm jsr N 2+ )y sta N 2+ winc ]?
  N 4 + winc  N dec 0= ?] N 1+ dec 0= ?]
  cp2 jmp end-code

Code compress  cp1 jsr
 [[ [[ N 4 + )y lda bl # cmp 0=
  ?[ inx 0=
   ?[ dex txa  N 2+ )y sta N 2+ winc
    $80 # ldx ]?
   ][ $80 # cpx 0>=
    ?[ pha txa N 2+ )y sta N 2+ winc
     $7f # ldx pla ]?
    cbm>7b jsr N 2+ )y sta N 2+ winc ]?
   N 4 + winc N dec 0= ?] N 1+ dec 0= ?]
 $80 # cpx 0>=
 ?[ txa        N 2+ )y sta N 2+ winc ]?
 cp2 jmp end-code

\ *** Block No. 28, Hexblock 1c

\ RD: ramR/W                  clv01aug87  \ \\ for RD:ramR/W              clv01aug87

| : endwrite ( compLen--)                 \ ENDWRITE removes Blanks at end of Block
 data under + ( [from ]to )               \    and set LEN!
 BEGIN 1- dup c@ $7f u> WHILE
   2dup u> UNTIL 1+ swap - len! ;

| : endread  ( toAdr expLen--)            \ ENDREAD fills Reminder of block with
 under + b/blk rot - bl fill ;            \         Blank

: ramR/W ( adr blk file R/NotW -- error)  \ RAMR/W  replaces the R/W-Routine
 2 pick notRD?                            \   (binary) Blocks in full length will
 IF 1541r/w                               \   copied by CMOVE, shorter blocks will
 ELSE swap abort" no file"                \   be copied with COMPRESS (write) and
  swap search len@ b/blk = ( adr r? b?)   \   EXPAND (read).
  IF   0= IF data ELSE data swap THEN
          b/blk cmove
  ELSE 0= IF   delete new data b/blk
               compress endwrite
          ELSE dup data swap len@
               expand endread

 THEN THEN false THEN ;



\ *** Block No. 29, Hexblock 1d

\ RD: id rduse/del/new        clv01aug87  \ \\ for RD:id rduse..          clv01aug87

: .rd  ( --)     (rd @ u. rd drop         \ .RD  print information about current RD
  end u. 6 adr@ u. id count type ;

: id! ( adr count--)                      \ ID!  set name of Ramdisk
  $20 id c! id count bl fill
  $1a umin id 3 + place
  " RD." count id 1+ swap cmove ;

: id" Ascii " parse id! ; \ id" name      \ ID"  reads name of Ramdisk

: rduse ( from --) (rd ! ;                \ RDUSE switches (without checks) to RD
: rddel  ( --)                            \ RDDEL clears Ramdisk
  rd @ dup 2 >adr ! 4 >adr ! end off ;
| : range ( adr--adr)
  limit umax memtop umin ;
: rdnew ( from to--)                      \ RDNEW creates a new Ramdisk and
  range swap range swap                   \       checks (almost) everything
  2dup $500 - u> abort" range!"
  over plen over ! rduse
  swap - 6 >adr !
  rddel 0 0 id! ;



\ *** Block No. 30, Hexblock 1e

\ RD: rdcheck                 clv01aug87  \ \\ for RD: rdcheck            clv01aug87

| : ?error IF ." error " THEN ;

: rdcheck                                 \ RDCHECK checks pointer of Ramdisk and
 .rd                                      \         prints table of contents
 rd BEGIN
  dup @   dup 0 b/blk 5 + uwithin
                            not ?error
  +       dup cr u.
  dup @   dup 3 u.r space
  WHILE   dup 2+ @ blk/drv u/mod
          1 u.r ." :" 2 u.r
          dup 4 + &26 type
          stop? ?exit
  REPEAT  end -                 ?error ;










\ *** Block No. 31, Hexblock 1f



























\ *** Block No. 32, Hexblock 20

\ ST:Supertape LoadScreen     clv01aug87  \ \\ for ST:LoadScreen          clv01aug87

(64 .( not for C64!! ) quit C)            \ Supertape is a fast loader using
                                          \ 3600 Bd or 7200 Bd approx. 10 times
\needs Code .( needs Assembler!) quit     \ fster then the original CBM-Routines

Assembler                                 \  Usage:
\needs rom  .( ??! rom  !??) quit         \   DeviceNumber  =  7 ==> Supertape
Onlyforth                                 \   SecAddress   >=$80 ==> 7200 Bd
                                          \                 <$80 ==> 3600 Bd
   1  $12 +thru \ load supertape          \                 ..everything else like
                                          \                   CBM
                                          \ StorageFormat 8Bit per Byte, Lowbit 1st
\\ Supertape was developed by german      \ Selfregulating, on each Bitborder is
   magazin c't ( www.heise.de )           \ a edge-switch
   We thank the publisher for             \ If there is anotherone in the middle
   permission to adapt SuperTape          \ the bit is  Bit=0, else=1.
   for volksForth
                                          \ Format: sync #$2a 25b:Header 2b:checksum
                                          \         sync #$c5 len:Data   2b:checksum
                                          \ Sync  = 64b:#$16
                                          \ Header=16b:Name
                                          \        1b:SecAdd 2b:from 2b:len 4b:#$00



\ *** Block No. 33, Hexblock 21

\ ST:Labels..                 clv16jun87  \ \\ for ST:Labels.             clv16jun87

\ ------ hardware-Addresses -----------   \ -------- hardware-Addresses-----------
$0001 >Label pCass                        \ 1  Cassettenport
$ff02 >Label pTimerB                      \ 2  Time for Timer2
$ff09 >Label pTimerBCtrl                  \ 1  controllregister for Timer2
$ff3f >Label pRamOn                       \ 1  Writeaccess switches to RAM
$ff3e >Label pRamOff                      \ 1  Writeaccess switches to ROM

\ ------ System-Vectors --------------    \ -------- System-Vectors  -------------
$0330 >Label vSave                        \ 2  Save-Vector of System will be patched
$032e >Label vLoad                        \ 2  Load-Vector of System will be patched

\ --- Input-Params Load/Save ---------    \ ----- Input-Parameter Load/Save-----
$ae >Label zDeviceNr                      \ 1  Device-Number
$ad >Label zSecadd                        \ 1  Secundaryaddress (controls Device)
$af >Label zFilenameZ                     \ 2  Pointer to filenames
$ab >Label zFileNameC                     \ 1  Number of Chars in Filename
$b4 >Label zBasLoadAdd                    \ 2  Startaddress for LOAD
$b2 >Label zIOStartZ                      \ 2  Startaddress for SAVE
$9d >Label zProgEndZ                      \ 2  Endaddress+1 for SAVE

\ --- Output Params for Load/Save ----    \ ----- Outpute-Parameter for Load/Save --
$90 >Label zStatus                        \ 1  Status Flags of OS


\ *** Block No. 34, Hexblock 22

\ ST:..Labels                 clv16jun87  \ \\ zu ST:..Labels             clv16jun87

\ ------ used System Routines ---------   \ -------- benutzte System-Routinen -----
$e38d >Label xCassMotorOn                 \    start Cassette Motor
$e3b0 >Label xCassMotorOff                \    stop  Cassette Motor
$e364 >Label xCassPrtOn                   \    init Cassette Port
$e378 >Label xCassPrtOff                  \    init Cassette Port
$f050 >Label xLoad                        \    normal  Load-Routine
$f1a4 >Label xSave                        \    normal  Save-Routine
$f189 >Label xMsgLoadVerify               \    print 'Loading' or 'Verifying'
$e31b >Label xPressplay                   \    print 'Press play..'
$e319 >Label xPressRec                    \    print 'Press Record.. '
$ebca >Label xFoundFile                   \    print 'Found'
$f160 >Label xSearching                   \    print 'Searching'
$ffd2 >Label kOutput                      \    print one char

\ ------ used Zeropage Addresses ------   \ -------- used Zeropage-Addresses -----

$5f >Label zBeginZ                        \ 2  Address of current I/O  Byte
$61 >Label zEndZ                          \ 2  Address of last    I/O  Byte +1
$93 >Label zVerifyFlag                    \ 1  next Block: Verify/-Load
$59 >Label ZBlockKind                     \ 1  next Block: Header/Data
$58 >Label zBit                           \ 1  last State of Cassetteport
$57 >Label zByte                          \ 1  already loaded part of current Byte
$ff >Label zTmp                           \ 1  last loaded byte

\ *** Block No. 35, Hexblock 23

\ ST:..Labels                 clv16jun87  \ \\ for ST:..Labels            clv16jun87


$d8 >Label zReservAA                      \ 2  short/long Impuls for Save
$5d >Label zCheckSum                      \ 2  Checksum
$63 >Label zCheckSumB
$da >Label zTmpSP                         \ 1  Stackpointer for Error Exit


\ --- other Systemadressen ----------     \ ----- additional Systemaddresses-----
$07c8          >Label sTime               \ 1  Time for next TimerBStart
$0332  dup     >Label sCassBuffer         \ c0 Buffer for Cassetteoperations
$19 + $100 mod >Label cCassBufferEnd      \ -  End of Buffer, Low-Byte

\ --------- Konstanten --------------     \ ----------- Constants  --------------
$07 >Label cDeviceST                      \    DeviceNumber of Supertape
$2a >Label cHeaderMark                    \    1.Byte of Headerblock
$c5 >Label cDataMark                      \    1.Byte of Datablock
$4f >Label chsl                           \    Time 7600 Baud loading
$b5 >Label clsl                           \    Time 3600 Baud loading
$78 >Label chssh    $34 >Label chssl      \    Time 7600 Bd save long/short Impuls
$ff >Label clssh    $78 >Label clssl      \    Time 7600 Bd save long/short Impuls
$16 >Label cSyncByte                      \    Byte for Sync-Header
$0b >Label cSyncBytesLoad                 \    min. Number of SyncBytes for Loading
$40 >Label cSyncByteCount                 \    Number of SyncBytes for Saving

\ *** Block No. 36, Hexblock 24

\ ST:verschiedenes            clv28jul87  \ \\ for ST:misc                clv28jul87

Label btlBeg                              \ Start of Bootstraploader
Label puffinit \ Load Pointer to Buffer
 sCassbuffer $100 u/mod
 # lda    zBeginZ 1+ sta zEndZ 1+ sta
 # lda    zBeginZ    sta
 cCassbufferEnd # lda     zEndZ    sta
 rts end-code

Label timerBStart
 sTime lda          pTimerB      sta      \  (1)
 0   #  lda         pTimerB   1+ sta      \ Start Timer Number 2
 $10 #  lda         pTimerBCtrl  sta      \  (1)
 rts end-code                             \ with time in STIME

Label delayMotor \ Motor start Delay
 0 # ldx 0 # ldy
 [[ [[ dex 0= ?] dey 0= ?]
 rts end-code                             \ Wait-Loop

                                          \ (1) the Sequence 'brk brk bit brk brk'
                                          \     stops overwriting data at boottime
                                          \     if a read-error occurs


\ *** Block No. 37, Hexblock 25

\ ST:stEnde etc.              clv23jul87  \ \\ for ST:stEnd etc.         clv18jun87

Label stEnd         0 # lda  $2c c,       \                 no     Error (Bit--)
Label loadError   $1d # lda  $2c c,       \                 Load-     "  (Bit--)
Label eot         $04 # lda  $2c c,       \  AR := ErrorNr  EOT -     "  (Bit--)
Label verError    $1c # lda  $2c c,       \                 Verify-   "  (Bit--)
Label brkError    $1e # lda               \                 Stop-     "
 pRamOff sta  pha                         \  Switch to ROM, push Error
 xCassMotorOff jsr  xCassPrtOff jsr       \  Port exit
 zTmpSP ldx   pla  txs                    \  repair Stack
 zBeginZ ldx  zBeginZ 1+ ldy              \  xr-yr := Load-EndAddress
 01 # cmp cli rts end-code                \  CF    := Error, enable Interrupt


\\  cbm: stop: ar=0  cf=1
        normal ar=0  cf=0  st=0
        eot                 $80
 load/vererr                $10
    checksum                $60
                            ...
kernal-errors ar=0..8 cf=1

 s.ROM:$a803



\ *** Block No. 38, Hexblock 26

\ ST:bitRead                  clv18jun87  \ \\ for ST:bitRead             clv16jun87

Label bitRead  \ cur.Byte in AR
 $10 # lda [[ ptimerBctrl bit 0<> ?]      \ wait for timer                    (?)
 pCass lda  $10 # and  zBit cmp           \ Carry := 1 , if level equal == Bit=1
 0<> ?[ clc ]?        zBit sta            \  save bit
 zByte ror zByte lda                      \  rotate in byte
 0< ?[ zCheckSum wInc ]?                  \ if Bit=1: increment checksum
 [[ pCass lda $10 # and  zBit cmp 0<> ?]  \ wait for edge
 zBit sta timerBStart jsr                 \ save portstate, set timer
 zByte lda rts end-code                   \ return current byte















\ *** Block No. 39, Hexblock 27

\ ST:stRead..                 clv05aug87  \ \\ zu ST:stRead..             clv28jul87

Label stRead \ reads a block              \  Data/or Header,Verifyerror := 0
 zBlockKind sta  0 # ldx
Label syncron
 [[ bitRead jsr cSyncByte # cmp 0= ?]     \  syncronizing
 cSyncBytesLoad # ldx
 [[ $08 # ldy                             \  read Byte
    [[ bitRead jsr dey 0= ?]
    cSyncByte # cmp         syncron bne   \  no Sync Byte? search for it
    dex 0= ?]
 [[ $08 # ldy                             \  Header detected
    [[ bitRead jsr dey 0= ?]              \     read Byte
    cSyncByte # cmp 0<> ?]                \     until Header ends AR=Block-kind
 zBlockKind cmp 0<>                       \  searched Block Kind? yes, read it
 ?[ cDataMark # cmp        syncron beq    \  searched for Header, data found, cont.
 $10 # lda zStatus sta loadError jmp ]?   \  othr Kund? Error
 0 # lda zCheckSum sta zCheckSum 1+ sta   \  Checksum := 0
 $08 # ldy                                \  Read byte
    [[ bitRead jsr dey 0= ?] zTmp sta






\ *** Block No. 40, Hexblock 28

\ ST:..stRead                 clv28jul87  \ \\ for ST:..stRead            clv28jul87

 [[ [[                                    \ --- Loop from Load-Start till end
  zCheckSum    lda  zCheckSumB    sta     \  Checksum
  zCheckSum 1+ lda  zCheckSumB 1+ sta     \              := Checksum
  bitRead jsr      bitRead jsr            \  read 2 Bit
  zVerifyFlag lda 0=                      \  only Verify?
  ?[ zTmp lda   zBeginZ )Y sta ]?         \  else: load Byte
  bitRead jsr      bitRead jsr            \  read 2 Bit
  zTmp lda      zBeginZ )Y cmp            \  compare Byte
  0<> ?[ inx ]?                           \  increment verify error
  bitRead jsr      bitRead jsr            \  read 2 bit
  zBeginZ wInc                            \  pointer to next byte
  bitRead jsr      bitRead jsr            \  new byte
  zTmp sta                                \  new byte
 zBeginZ 1+ lda  zEndZ 1+ cmp 0= ?]       \ --- end of loop
 zbeginZ    lda  zEndZ    cmp 0= ?]       \ --- end of loop









\ *** Block No. 41, Hexblock 29

\ ST:..stRead                 clv05aug87  \ \\ for ST:..stRead            c2v27jul87

 zTmp lda ZCheckSumB cmp 0<> ?[           \  Checksum-Error?
Label SError zStatus lda  $60 # ora       \    else Status
         zStatus sta loadError jmp ]?     \    and  LoadError-Exit
 $08 # ldy                                \  read byte
    [[ BitRead Jsr dey 0= ?]
 zCheckSumB 1+ cmp        SError bne      \  Checksum-Error?
 0 # cpx  0<> ?[ $10 # lda zStatus sta    \  Verifyerror?
                       verError jmp ]?
Label ldRTS rts end-code















\ *** Block No. 42, Hexblock 2a

\ ST:stLoad..                 clv23jul87  \ \\ for ST:stLoad..            clv16jun87

Label stLoad                              \ will be load-vector of system
 zVerifyFlag sta  0 # lda zStatus sta     \  save Verify and Load, clear status
 zDeviceNr  lda  cDeviceST # cmp 0<>      \  for Supertape?
 ?[ xLoad jmp ]? \ CBM-Routine            \  if not -> CBM-Routine
Label loadNext                            \  save stack for error handling
 tsx  zTmpSP stx                          \  'Press play on Tape' Stop?,then return
 xPressplay jsr ldRTS bcs                 \  disable IRQ
 sei     zVerifyFlag lda pha              \  set to load
 0 # lda zVerifyFlag sta                  \  'Searching...'
 xSearching jsr
Label ldWrongFile                         \  Initializing
 xCassMotorOn jsr delayMotor jsr
 xCassPrtOn   jsr puffInit   jsr          \  3600 Baud/Load
 clsl # lda   sTime sta                   \  Search Header and Load
 cHeaderMark # lda  stRead jsr            \  'Found ..'
 $63 # ldy  xFoundFile jsr                \  print Filename
 0 # ldy [[ sCassBuffer ,Y lda
    kOutput jsr  iny  $10 # cpy  0= ?]
 $ff # ldy





\ *** Block No. 43, Hexblock 2b

\ ST:..stLoad                 clv23jul87  \ \\ for ST:..stLoad            clv16jun87


Label ldComp
 [[ iny zFileNameC cpy 0<>                \  compare all chars
  ?[[ pRamOn sta zFilenameZ )Y lda
  pRamOff sta                             \   same as in entred filename?
  sCassBuffer ,Y cmp         ldComp beq   \                            continue
  Ascii ?      # cmp         ldComp beq   \   entered Char   '?'  ?    continue
  sCassBuffer $10 + lda  $02 # and 0<>    \   End-Of-Tape         ?
  ?[ $80 # lda zStatus sta eot jmp ]?     \                            then NotFound
  xCassPrtOff jsr       ldWrongFile jmp   \   else: enable Screen, cont. search
 ]]? pla  zVerifyFlag sta                 \  repair Verify Flag
 xMsgLoadVerify jsr                       \  'loading'/'verifying'
 zBasLoadAdd    lda  zBeginZ    sta       \  LoadAddress  := from System
 zBasLoadAdd 1+ lda  zBeginZ 1+ sta
 zSecAdd lda 0<>                          \  SecAdd.=1?
 ?[ sCassBuffer $11 + lda zBeginZ   sta
   sCassBuffer $12 + lda zBeginZ 1+ sta   \    then loadaddress from header
 ]?
 clc sCassBuffer $13 + lda                \  LoadEnd
 zBeginZ    adc zEndZ    sta              \          :=
 sCassBuffer $14 +  lda                   \              LoadAddress
 zBeginZ 1+ adc zEndZ 1+ sta              \             +FileLength


\ *** Block No. 44, Hexblock 2c

\ ST:..stLoad                 clv14oct87  \ \\ for ST:..stLoad            c2v27jul87


 chsl # lda    sTime sta                  \  7200 Baud/Load
 sCassBuffer $10 + lda 0>=                \  saved with 3600 Bd (==Secadd>$80)?
 ?[ clsl # lda sTime sta ]?               \  then 3600 Bd/Load
 pRamOn sta  cDataMark # lda stRead jsr   \  switch to RAM, load Datablock
 stEnd jmp end-code                       \  End

Label loadsys \ load and start            \ Will be used for Bootstraploader
 loadnext jsr CS ?[ brk ]?
 loadnext jsr CS ?[ brk ]?
 origin 8 - jmp \ Forth-Cold vector
Label btlEnd
base @ hex                                \ Creates a string of Form 'g78b5',
Create g----    7 allot                   \ with address LOADSYS
loadsys 0 <# #s Ascii g hold #cr hold #>  \ will be used as Monitor-Command,
g---- place                               \ with address of Bootstraploader
base !                                    \ s.a. SAVEBOOTER
: >lower ( str--) count bounds
 DO I c@ $7f and I c! LOOP ;              \ This String cannot contain capital
                                          \ Letters
g---- >lower  forget >lower



\ *** Block No. 45, Hexblock 2d

\ ST:wByte w4bits             clv16jun87  \ \\ for ST:wByte w4bits        clv16jun87

Label wByte here 3 + Jsr \ write byte
Label w4bits             \ upper 4 Bits
 $04 # ldy                                \  4 Bits
 [[ zByte lsr CS                          \  --- Loop over 4 Bits
    ?[ zReservAA 1+ lda  sTime sta ]?     \     bit=1?, set full timer
    $10 # lda [[ pTimerBCtrl bit 0<> ?]   \     wait for timer
    timerBStart jsr                       \     start new
    pCass lda  $02 # eor pCass sta        \     write edge
    CC ?[ $10 # lda                       \     bit=0?
       [[ pTimerBCtrl bit 0<> ?]          \        wait for timer
       timerBStart jsr                    \        and start new
       pCass lda  $02 # eor pCass sta     \        write edge (Bit-border)
    ][ zCheckSum    lda 0 # adc           \     bit=1?
       zCheckSum    sta                   \        increment Checksum
       zCheckSum 1+ lda 0 # adc
       zCheckSum 1+ sta
       zReservAA lda sTime sta ]?         \        set half time
    dey 0= ?] rts  end-code               \  --- End of loop






\ *** Block No. 46, Hexblock 2e

\ ST:stWrite                  clv18jun87  \ \\ for Rd:stWrite             clv18jun87

Label stWrite \ writes a block            \  AR=BlockKind
 pha cSyncByteCount # ldx                 \  save
 [[ cSyncByte # lda  zByte sta            \  SynchronisationBytes
    wByte Jsr dex 0= ?]                   \  ..write
 pla  zbyte sta  wByte Jsr                \  write BlockKind
 0 # ldy zCheckSum sty zCheckSum 1+ sty   \  Checksum:= 0
 [[ [[                                    \  --- Loop for 1st till last Byte
  zBeginZ  )Y lda  zByte sta w4bits jsr   \                    upper 4 Bits
  zBeginZ  wInc              w4bits jsr   \                    lower 4 Bits write
  zBeginZ     lda   zEndZ    cmp 0= ?]    \  --- Loop...
  zBeginZ  1+ lda   zEndZ 1+ cmp 0= ?]    \  --- ..End
 zCheckSum lda  zCheckSum 1+ ldx          \  Checksum..
 zByte sta        wByte jsr               \  ..write Low Byte
 txa   zByte sta  wByte jsr               \  ..write High Byte
 wByte jmp end-code                       \  few Extrabits, ensures that loading
                                          \  will end








\ *** Block No. 47, Hexblock 2f

\ ST:saveName                 clv26jul87  \ \\ for ST:saveName            clv01aug87

Label saveName \ no error checking!       \ writes FileName in Cassettebuffer
 bl # lda  $0f # ldy                      \  CassetteBuffer  [0..$10]
 [[ sCassBuffer ,Y sta  dey 0= ?]         \               := <blanks>
 zFileNameC ldy ram                       \  CassetteBuffer  [0..FileNameLength]
 [[ dey 0>= ?[[ zFileNameZ )Y lda         \               :=
    sCassBuffer ,Y sta ]]? rom            \                  FileName
Label rsRTS rts end-code

















\ *** Block No. 48, Hexblock 30

\ ST:stSave..                 clv16jun87  \ \\ for ST:stSave..            clv01aug87

Label stSave                              \ will by pacthed into OS Vector
 zDeviceNr lda cDeviceST # cmp 0<>        \  DeviceNr = Supertape?
 ?[ sec $0e # and 0= ?[ clc ]?            \  else: use
                            xSave jmp ]?  \     CBM-Save-Routine
 tsx  zTmpSP stx                          \  StackPointer saved for Errorhandling
 saveName jsr                             \  FileName in Buffer
 clc  xPressRec  jsr          rsRTS bcs   \  ' Press Play & Record on Tape'  STOP?
 sei  xCassPrtOn jsr xCassMotorOn jsr     \  Initializing
 delayMotor jsr
 zSecAdd lda  sCassbuffer &16 + sta
 zIOStartZ    lda sCassBuffer &17 + sta   \  Startaddress in Buffer -- change???
 zIOStartZ 1+ lda sCassBuffer &18 + sta   \                         -- for COPY?
 sec zProgEndZ lda  zIOStartZ    sbc      \  FileLength
 sCassBuffer &19 + sta                    \  ..calculate
 zProgEndZ 1+ lda   zIOStartZ 1+ sbc      \  ..and
 sCassBuffer &20 + sta                    \  ..write into buffer
 0 # lda sCassBuffer &21 +                \  CassBuffer [$21..$24]
 dup sta 1+ dup sta 1+ dup sta 1+ sta     \                            := 0
 pTimerB 1+ sta                           \  Time-HighByte := 0
 sCassBuffer $100 u/mod                   \  SaveStartAdresse
 # lda zBeginZ  1+ sta  zEndZ 1+ sta      \                := CassetteBuffer
 # lda zBeginZ     sta                    \  SaveEndAddress
 cCassBufferEnd # lda   zEndZ    sta      \                := Cassett.Buffer-End

\ *** Block No. 49, Hexblock 31

\ ST:..stSave                 clv16jun87  \ \\ for ST:..STSave            clv01aug87


 clssh # lda  zReservAA 1+ sta            \  3600Baud/short  SaveImpuls (==Bit=0)
 clssl # lda  zReservAA    sta            \          /long   SaveImpuls (==Bit=1)
 pTimerB sta                              \  set
 $10 # lda  pTimerBCtrl sta               \  TimerNummer2   enabled
 cHeaderMark # lda  stWrite jsr           \  Header  (==Buffer) write
 delayMotor jsr                           \  write Pause
 zSecAdd bit 0<                           \  7200Bd requested  (==SecAdd>=$80) ?
 ?[ chssh # lda  zReservAA 1+ sta         \  then 7200Bd/short  SaveImpuls
    chssl # lda  zReservAA    sta         \             /long   SaveImpuls
    pTimerB sta ]?                        \       set
 zIOStartZ     lda  zBeginZ     sta       \  SaveBeginAddress
 zIOStartZ  1+ lda  zBeginZ  1+ sta       \            := from System
 zProgEndZ     lda  zEndZ       sta       \  SaveEndAddress
 zProgEndZ  1+ lda  zEndZ    1+ sta       \            := from System
 pRamOn sta cDataMark # lda stWrite jsr   \  enable RAM, write Data Block
 delayMotor jsr stEnd jmp end-code        \  write Pause, finish







\ *** Block No. 50, Hexblock 32

\ ST:supertape savebooter     clv10oct87  \ \\ for ST:supertape stSavSys  clv10oct87

: supertape  \ --                         \ SUPERTAPE
 7 device !                               \ .. set current device
 stLoad vLoad !  stSave vSave !           \ .. patches OS vectors
 ." ST2.20 " ;                            \ .. prints message

| : (n" >in store n" ;                    \ !! A Supertape-System must be saved in
                                          \ !! 3 Parts:
: btl ( --[from ]to )                     \ !!  1. Mini-Supertape
 [ BtlBeg ] Literal [ BtlEnd ] Literal ;  \ !!  2. Part of System before
                                          \ !!  3. Part of System aftr
| : btlName ( --adr count)                \ !! Part 1 will be saved in CBM-Format
 pad $16 bl fill                          \ !! and is loading Part 2,3 in ST-Format
 (n" $10 umin pad     swap cmove
 g---- count pad $a + swap cmove          \   Attache Filename to gLOADSYS
 pad $10 ;

: stSavSys ( --)  \ Name" follows
  device store 1 device !                 \   1. from BUFFINIT to excl. BTL save in
  btl btlName               bsave         \   CBM-Format
  7 device !                              \   use ST-Format
  origin $17 - btl drop (n" bsave         \   2. store
  btl nip here           n" bsave ;       \   3.   "


\ *** Block No. 51, Hexblock 33

\ Loadscreen for Decompiler    20oct87re
\ based on F83 by H. Laxen / M. Perry

\needs Tools  Vocabulary Tools

.( Decompiler loading...)

Onlyforth
Tools also definitions

\needs dis     ' drop | Alias dis
          \ Disassemble if possible

&1 &9 +thru

\\

clear








\ *** Block No. 52, Hexblock 34

\ case defining words        20aug85mawe

| : case:  ( n -)
 Create , 0 ]
 Does> 2+ swap 2* + perform ;

| : associative:
 Create ,   ( n -)
 Does>      ( n - index)
 dup @ -rot dup @ 0
   DO 2+ 2dup @ =
     IF 2drop drop I 0 0 LEAVE THEN
   LOOP 2drop ;


Defer (see
| Variable maxbranch
| Variable thenbranch








\ *** Block No. 53, Hexblock 35

\ decompile each type of word 29nov85re   \ \ Sieve benchmark              20oct87re

| : .word   ( IP - IP')                   \ Onlyforth
 dup @ >name .name 2+ ;
                                          \ : allot  ( u --)
| : .lit    ( IP - IP')                   \  dup sp@ here - $180 -  u>
 .word dup @ . 2+ ;                       \  abort" no room" allot ;

| : .clit   ( IP - IP')                   \ &8192 Constant size
 .word dup c@ . 1+ ;                      \ Create flags   size allot
                                          \ : do-prime  ( -- #primes )
| : .string ( IP - IP')                   \  flags size 1 fill    0
 cr .word count 2dup type ascii " emit    \  size    0 DO flags I + c@
 space + ;                                \            IF  I 2* 3+ dup I +
                                          \              BEGIN  dup size <
| : .do  ( IP - IP')   ." DO " 4 + ;      \              WHILE  0 over flags + c!
                                          \                     over +
| : .loop  ( IP - IP')   ." LOOP " 4 + ;  \              REPEAT  2drop 1+
                                          \            THEN
| : .exit    ( IP - IP' f)                \         LOOP ;
 dup maxbranch @ u< IF  .word exit  THEN  \ : benchmark   9 0 DO do-prime drop  LOOP
 dup @ [ Forth ] ['] unnest =             \  do-prime . ." Primes" ;
 IF  ." ; "  ELSE  .word ." ; -2 allot "  \ : .primes   size 0 DO  flags I + c@
 THEN  0= ;                               \  IF  I 2* 3+ .  THEN ?cr
                                          \  stop? IF  LEAVE  THEN  LOOP ;

\ *** Block No. 54, Hexblock 36

\ branch, ?branch             29nov85re

| : .to
 ." back to " .word drop ;

| : .branch ( IP - IP')
 2+ dup @ 2dup +  swap 0<
 IF   cr ." REPEAT to " .exit
   0<> swap 2+  and  exit
 THEN cr ." ELSE " dup thenbranch !
 dup maxbranch @ u>
 IF  maxbranch !  ELSE  drop  THEN 2+ ;

| : .?branch  ( IP - IP')
 2+ dup @ 2dup +
 swap 0<
 IF cr ." UNTIL " .to 2+ exit THEN
 cr dup 4 - @ [ ' branch ] literal =
 over 2-  @ 0< and
 IF   ." WHILE "
 ELSE ." IF "  dup thenbranch !
 THEN  dup maxbranch @ u>
    IF maxbranch ! ELSE drop THEN  2+ ;



\ *** Block No. 55, Hexblock 37

\ decompile does> ;code ;      20oct87re

| : does?    ( IP - IP' f)
 dup 3 + swap
 dup c@ $4C  =  swap      \ jmp-opcode
 1+ @  ['] Forth @ 1+ @ = \ (dodoes>
 and ;

| : .(;code  ( IP - IP' f)
  2+ does?
   IF cr ." Does> "
   ELSE  ." ;Code " 3 - dis 0 THEN ;

| : .compile  ( IP -- IP' )
  .word .word ;











\ *** Block No. 56, Hexblock 38

\ classify each word           20oct87re

&18 associative: execution-class
Forth
' lit ,     ' clit ,     ' ?branch ,
' branch ,  ' (DO ,      ' (." ,
' (abort" , ' Does> 4 + @ , \ (;code
' exit ,    ' abort ,    ' quit ,
' 'quit ,   ' (quit ,    ' unnest ,
' (" ,      ' (?DO ,     ' (LOOP ,
' compile ,

&19 case: .execution-class
.lit        .clit        .?branch
.branch     .do          .string
.string     .(;code
.exit       .exit        .exit
.exit       .exit        .exit
.string     .do          .loop
.compile    .word    ;






\ *** Block No. 57, Hexblock 39

\ decompile a :-definition   20aug85mawe

: .pfa  ( cfa -)
 >body
 BEGIN ?cr dup
   dup thenbranch @ =
   IF ." THEN " ?cr THEN
   @ execution-class .execution-class
   dup 0= stop? or UNTIL
 drop ;

: .immediate  ( cfa -)
 >name c@ dup
 ?cr $40 and IF ." Immediate " THEN
 ?cr $80 and IF ." restrict" THEN ;

: .constant   ( cfa -)
 dup >body @ . ." Constant "
 >name .name ;

: .variable   ( cfa -)
 dup >body . ." Variable "
 dup >name .name
 cr ." Value = "  >body @ . ;


\ *** Block No. 58, Hexblock 3a

\ display category of word     20oct87re

: .:      ( cfa -)
 ." : " dup >name .name cr .pfa ;

: .does>  ( cfa -)
 cr ." Does> " 2- .pfa ;

: .user-variable  ( cfa -)
 dup >body c@ . ." User-Variable "
 dup >name .name
 cr ." Value = "  execute @ . ;

: .defer  ( cfa -)
 ." deferred " dup >name .name
 ." Is " >body @ (see ;

: .other  ( cfa -)
 dup >name .name
 dup @ over >body =
  IF ." is Code" @ dis exit THEN
 dup @ does? IF .does> drop exit THEN
 drop ." maybe Code" @ dis ;



\ *** Block No. 59, Hexblock 3b

\ Classify a word              22jul85we  \ \ Graphic-Demos Loadscreen     20oct87re

5 associative: definition-class           \ Only Forth also definitions
' quit @ ,        ' 0 @ ,
' scr @ ,         ' base @ ,              \ \needs Graphic -&80 +load
' 'cold @ ,
                                          \ Graphic also definitions
6 case: .definition-class                 \  page  .( Loading .....)
.:                .constant
.variable         .user-variable          \  1   4 +thru   \ Demo1,2,3,4 Demo
.defer            .other  ;               \  5     +load   \ Sinplot
                                          \  6 &11 +thru   \ Turtle demos


                                          \ wave wave1 triangle lines moire
                                          \ sinplot
                                          \ ornament circles worm coil
                                          \ town

                                          \ &20 window






\ *** Block No. 60, Hexblock 3c

\ Top level of Decompiler    20aug85mawe  \ \ Plot wave                    20oct87re

: ((see    ( cfa -)                       \ &100 | Constant &100
 maxbranch off  thenbranch off            \ &160 | Constant &160
 cr dup dup @                             \ : wave
 definition-class .definition-class       \  cs red cyn colors hires
 .immediate ;                             \  &100 0 DO
                                          \  &99 0 DO
' ((see Is (see                           \    I dup * J dup * + &150 / 1 and
                                          \     IF &160 J + &100 I + plot
Forth definitions                         \        &160 J - &100 I + plot
                                          \        &160 J - &100 I - plot
: see   ' (see ;                          \        &160 J + &100 I - plot THEN
                                          \   LOOP LOOP ;

                                          \ : wave1
                                          \  cs blu yel colors hires
                                          \  &160 0 DO
                                          \  &99 0 DO
                                          \    I dup * J dup * + 100u/ 1 and 0=
                                          \     IF &160 J + &100 I + plot
                                          \        &160 J - &100 I + plot
                                          \        &160 J - &100 I - plot
                                          \        &160 J + &100 I - plot THEN
                                          \   LOOP LOOP ;

\ *** Block No. 61, Hexblock 3d

\ Commodore hole Screens       20oct87re  \ \ lineplot triangle            20oct87re

Onlyforth                                 \ | : grinit
                                          \  clrscreen
: <init   0 $DD03 c! ;                    \  yel blu colors hires ;

: get  ( -- 8b)                           \ : triangle
 BEGIN  $DD0D c@ $10 and  UNTIL           \  grinit
 $DD01 c@ dup $DD01 c! ;                  \  0 2 DO
                                          \    &160 0 DO
: <sync  ( --)                            \       I &199 &160 I 2/     J + flipline
 <init  BEGIN  get $55 =  UNTIL           \    &320 I - &199 &160 I 2/ J + flipline
 BEGIN  get dup $55 =                     \    2 +LOOP
 WHILE  drop  REPEAT  abort" SyncErr" ;   \  -1 +LOOP text ;

: sum  ( oldsum n -- newsum n)
 swap over + swap ;

: check  ( sum.int  8b.sum.read --)
 swap $FF and - abort" ChSumError" ;

-->




\ *** Block No. 62, Hexblock 3e

\ Commodore hole Screens       20oct87re  \ \ lineplot linies moire        20oct87re

: download  ( n --)                       \ : lines
 <sync  0 swap buffer b/blk bounds        \  grinit
 DO  get  sum  I c!  LOOP                 \  &320 0 DO
 get check update ;                       \     &320 0 DO I &198 J 0 line &35 +LOOP
                                          \  &35 +LOOP ;
: downthru  ( start count --)
 bounds DO  I download  LOOP ;            \ : moire
                                          \  clrscreen ora red colors hires
-->                                       \  &320 0 DO
                                          \   I &198 &319 I - 0 line
\\ sync needs: xx $55 $55 00 data         \  3 +LOOP
                                          \  &199 0 DO
                                          \   &319 &198 I - 0 I line
                                          \  2 +LOOP ;










\ *** Block No. 63, Hexblock 3f

\ Commodore sendscreens        20oct87re  \ \ lineplot boxes               20oct87re

: >init  $FF $DD03 c! ;                   \ Variable x0       Variable y0
                                          \ Variable x1       Variable y1
: put ( 8b -)
 $DD01 c!  BEGIN  stop?                   \ : box   ( x1 y1 x0 y0 -)
  IF  <init true abort" terminated" THEN  \  y0 ! x0 ! y1 ! x1 !
  $DD0D c@ $10 and  UNTIL ;               \  x1 @ y0 @ x0 @ over flipline
                                          \  x1 @ y1 @ over y0 @ flipline
: >sync  ( --)                            \  x0 @ y1 @ x1 @ over flipline
 >init $10 0 DO $55 put  LOOP  0 put ;    \  x0 @ y0 @ over y1 @ flipline ;

: upload  ( n --)                         \ Create colortab
 >sync  0 swap  block b/blk bounds        \  blk c, lbl c, red c, lre c,
 DO  I c@ sum  put  LOOP                  \  pur c, grn c, blu c,
 $FF and  put  <init  ;
                                          \ : boxes
: upthru  ( from to -- )                  \  grinit
 1+ swap DO  I . cr  I upload  LOOP ;     \  &10 3 DO
                                          \   &160 0 DO I dup &318 I - &198 I - box
                                          \         J +LOOP
                                          \    I 3 - colortab + c@  pencolor
                                          \    LOOP ;



\ *** Block No. 64, Hexblock 40

\ Graphic Load-Screen          20oct87re  \ \ Graphic sinplot              20oct87re

(16 .( C64 Only ) \\ C)                   \ &10000 Constant 10k

Onlyforth                                 \ : sinplot
                                          \  grinit
\needs Code         .( Assembler??!) \\   \  &319  &96   0 &96 line
                                          \  &160 &197 &160  0 line
\needs lbyte         1 +load              \  &152 &160 negate DO
                                          \   I &160 + &96 I sin &96 10k */ +
\needs 100u/       &26 +load              \   I &168 + &96 I 8 + sin &96 10k */ +
                                          \   line
Vocabulary graphic                        \  8 +LOOP
                                          \  &152 &160 negate DO
' graphic | Alias Graphics                \   I &160 + &96 I cos &96 10k */ +
                                          \   I &168 + &96 I 8 + cos &96 10k */ +
Graphics also definitions                 \   line
                                          \  8 +LOOP  ;
  2 &15 +thru  \ hires graphic
&16 &20 +thru  \ sprites
&21 &23 +thru  \ turtle graphic

Onlyforth



\ *** Block No. 65, Hexblock 41

\ >byte hbyte lbyte            20oct87re  \ \ Turtle demos                 20oct87re

Code >byte   ( 16b - 8bl 8bh)             \ | : tinit    ( -- )
 SP )Y lda pha txa SP )Y sta SP 2dec      \  clrscreen  hires   \ showturtle
 txa SP )Y sta pla Puta jmp   end-code    \  red cyn colors ;

: hbyte >byte nip ;                       \ | : shome  ( -- )
: lbyte >byte drop ;                      \  tinit &65 0 setxy &90 seth pendown ;

                                          \ : polygon   ( length edges -- )
                                          \  &360 over /
                                          \  swap 0 DO  over forward
                                          \             dup right     LOOP 2drop ;

                                          \ | : ring  ( edges -- )
                                          \  &200 over / swap
                                          \  &18 0 DO  2dup polygon
                                          \           &20 right  LOOP  2drop ;

                                          \ : ornament  ( -- )
                                          \  tinit home
                                          \  &10 3 DO  clrscreen  I dup 7 -
                                          \           IF  ring  ELSE  drop  THEN
                                          \           LOOP ;


\ *** Block No. 66, Hexblock 42

\ Graphics constants           20oct87re  \ \ Turtle demos 1               20oct87re

| $0288 Constant scrpage                  \ : circles  ( -- )
| $E000 Constant bitmap                   \  tinit
| $D800 Constant charset                  \   2 -1 DO home
| $C400 Constant colram                   \    &10 0 DO
| $C000 Constant vidram                   \     &20 I 2* - &20 polygon
\ $C800 Constant sprbuf                   \     xcor &10 I 2/  - - setx
                                          \     ycor &10 I - J * - sety
   bitmap hbyte $40 /mod  3 swap -        \    LOOP
| Constant bank                           \   2 +LOOP ;
   $20 / 8 *
   colram  hbyte $3F and 4 / $10 * or
| Constant bmoffs
   vidram  hbyte $3F and 4 / $10 *
   charset hbyte $3F and 4 / or
| Constant tmoffs

$0314 | Constant irqvec
$EA31 >label oldirq
$EA81 >label irqend
$FF6E >label settimer




\ *** Block No. 67, Hexblock 43

\ Gr movecharset clrscreen     20oct87re  \ \ Turtle demos 2               20oct87re

| Code movecharset                        \ | : (worm      ( length -- )  recursive
 sei  $32 # lda  1 sta   dey  8 # ldx     \  dup 5 < IF  drop exit  THEN
 N sty  N 2+ sty  $D8 # lda  N 1+ sta     \  dup forward &90 right
 charset hbyte # lda  N 3 + sta           \  2- (worm ;
  [[
   [[  N )Y lda  N 2+ )Y sta  iny  0= ?]  \ | : (coil  ( length -- )  recursive
  N 1+ inc  N 3 + inc  dex  0= ?]         \  dup 5 < IF drop exit THEN
 $36 # lda   1 sta  cli  iny              \  dup forward &91 right
 Next jmp  end-code                       \  2- (coil ;

                                          \ : worm ( -- )
: clrscreen ( -- ) bitmap &8000 erase ;   \  shome &190 (coil ;


                                          \ : coil ( -- )
                                          \  shome 5 forward &190 (coil ;








\ *** Block No. 68, Hexblock 44

\ Gr Variables (text (hires    20oct87re  \ \ Turtle demos 3               20oct87re

| Variable cbmkey                         \ | : startpos
| Variable switchflag                     \  &15 0 setxy &90 setheading ;
| Variable textborder
| Variable hiresborder                    \ | : continue ( -- )
| Variable switchline                     \  &90 right penup &55 forward
| Variable chflag                         \  pendown &90 left ;

Label (text                               \ | : chimney
 $1B # lda  $D011 sta                     \  xcor ycor
 tmoffs # lda  $D018 sta                  \  &50 fd &30 rt &15 fd &30 lt
 textborder lda  $D020 sta  rts           \  &30 fd &90 rt &12 fd &90 rt  8 fd
                                          \  setxy &90 setheading ;
Label (hires
 $3B # lda  $D011 sta                     \ | : house
 bmoffs # lda  $D018 sta                  \  &50 4 polygon &50 forward  &30 right
 hiresborder lda  $D020 sta  rts          \  &50 3 polygon &30 left  &50 back
                                          \  &90 right &15 forward &90 left
                                          \  &20 4 polygon
                                          \  &90 left &15 forward &90 right
                                          \  chimney ;




\ *** Block No. 69, Hexblock 45

\ Gr rasterirq graphicirq      20oct87re  \ \ Turtle demos 4               20oct87re

Label windowhome                          \ | : rowofhouses
 switchline lda sec $30 # sbc             \  tinit startpos
 .A lsr .A lsr .A lsr  sec 1 # sbc        \  4 0 DO house continue LOOP house ;
  $D6 cmp CC ?[ rts ]?
  tax inx 2 # ldy $CC sty $CD sty         \ | : housewindow
  $CE lda $D3 ldy $D1 )Y sta              \  xcor ycor
  0 # ldy $CF sty clc $FFF0 jsr           \  penup &30 fd &90 rt &10 fd &90 lt
  0 # ldy $D1 )y lda $CE sta $CC sty      \  pendown
  rts                                     \  &10 4 polygon &90 rt
                                          \  penup &20 fd &90 lt
Label graphicirq                          \  pendown &10 4 polygon
$28D lda  2 # and 0= ?[ oldirq jmp ]?     \  setxy ;
[[ $FF9F jsr $28D lda 0= ?] cbmkey ) jmp
                                          \ : town       rowofhouses
Label rasterirq                           \  startpos 4 0 DO housewindow continue
 $D019 lda $D019 sta                      \  LOOP
 $15 # ldx [[ dex 0= ?] N lda ( Blind!!)  \  housewindow ;
 chflag lda  1 # eor chflag sta tax
 0= ?[ (hires jsr ][ (text jsr ]?
 switchline ,x lda $D012 sta
 windowhome jsr
 $DC0D lda  1 # and graphicirq bne
 irqend jmp

\ *** Block No. 70, Hexblock 46

\ Gr IRQ-handling   (window    20oct87re  \ \ Turtle demos 5               20oct87re

Label setirq                              \ | : (medal ( len grad -- ) recursive
 sei graphicirq >byte                     \  stop? 0= and ?dup
 # lda irqvec 1+ sta    # lda irqvec sta  \  IF  over 3 / swap 1-
 $F0 # lda $D01A sta $81 # lda $DC0D sta  \   4 0 DO 2dup (medal 2 pick forward
 cli rts                                  \          &90 right  LOOP 2drop
                                          \   THEN drop ;
| Code resetirq
 sei oldirq >byte                         \ : medal
 # lda irqvec 1+ sta    # lda irqvec sta  \  tinit shome &192 5 (medal ;
 $F0 # lda $D01A sta $81 # lda $DC0D sta
 cli Next jmp end-code                    \ \\

Label (window                             \ : (6medals   ( len grad -)  recursive
 rasterirq >byte                          \  ?dup IF  over 3 / swap 1-
 # lda irqvec 1+ sta  # lda irqvec sta    \   6 0 DO 2dup (6medals 2 pick forward
 $7F # lda $DC0D sta $F1 # lda $D01A sta  \          &60 right  LOOP 2drop
 switchflag stx chflag stx                \   THEN drop ;
 windowhome jmp
                                          \ : 6medals
                                          \  tinit shome &80 &55 setxy
                                          \  &85 3 (6medals ;



\ *** Block No. 71, Hexblock 47

\ Gr text hires window switch  20oct87re

Code text    1 # lda switchflag sta
 setirq jsr  (text jsr  Next jmp
 end-code

Code hires   2 # lda switchflag sta
 setirq jsr  (hires jsr  Next jmp
 end-code

| Code setwindow  ( row -)
 sei (window jsr cli xyNext jmp
 end-code

: window   ( row -)
 8 * $30 + switchline c! setwindow ;

Label switch    switch cbmkey !
 switchflag ldx
         0= ?[ inx switchflag stx
     setirq jsr (text  jsr oldirq jmp ]?
 1 # cpx 0= ?[ inx switchflag stx
     setirq jsr (hires jsr oldirq jmp ]?
 0 # ldx  switchflag stx
 (window jsr  oldirq jmp  end-code

\ *** Block No. 72, Hexblock 48

\ Gr graphic forth             20oct87re

Forth definitions

: graphic
 Graphics movecharset
 $DD00 c@  $FC and  bank or  $DD00 c!
 vidram hbyte scrpage c!
 colram c@ hiresborder c!
 $D020 c@ textborder c!
 $10D0 switchline !
 text ;

: nographic
 Onlyforth resetirq
 $1B $D011 c!  $17 $D018 c! 4 scrpage c!
 textborder c@   $D020 c!
 $DD00 c@  3 or  $DD00 c! ;

Graphics definitions






\ *** Block No. 73, Hexblock 49

\ Gr Colors                    20oct87re

0  Constant blk      1 Constant wht
2  Constant red      3 Constant cyn
4  Constant pur      5 Constant grn
6  Constant blu      7 Constant yel
8  Constant ora      9 Constant brn
$A Constant lre     $B Constant gr1
$C Constant gr2     $D Constant lgr
$E Constant lbl     $F Constant gr3

: border      ( color -)
 dup textborder c! $D020 c! ;

: screen      ( color -)   $D021 c! ;

: colors      ( bkgrnd  foregrnd -)
 over hiresborder c!
 $10 *  or  colram $03F8  rot fill ;

: background  ( color -)
 colram c@ $10 /  colors ;

: pencolor    ( color -)
 colram c@ $F and swap  colors ;

\ *** Block No. 74, Hexblock 4a

\ Gr Bittab Labels             20oct87re

Label bittab
 $80 c, $40 c, $20 c, $10 c,
 $08 c, $04 c, $02 c, $01 c,

| : >laballot  ( adr n - adr+n)
 over >label + ;

$60 Constant pointy  $62 Constant pointx

Assembler

N
 2 >laballot y0      2 >laballot x0
 2 >laballot y1      2 >laballot x1
 2 >laballot offset  2 >laballot dy
 2 >laballot dx      2 >laballot ct
 1 >laballot iy      1 >laballot ix
 1 >laballot ay      1 >laballot ax
 2 >laballot bytnr
drop




\ *** Block No. 75, Hexblock 4b

\ Gr (plot compute             20oct87re  \ \ Sprite-Demo                  23oct87re

Label (plot  ( x y -)                     \ \needs graphic   -&96 +load
 2 # lda  setup jsr      3 # ldx
 [[ y0 ,X lda  pointy ,X sta  dex  0< ?]  \ Onlyforth graphic also  Forth
 $C7 # lda sec y0 sbc y0 sta
Label compute  sei  1 dec                 \ .( Loading...)
 y0 lda  $F8 # and  pha
 bytnr sta  0 # lda  bytnr 1+ sta  clc    \   1   4 +thru
 bytnr asl  bytnr 1+ rol
 bytnr asl  bytnr 1+ rol
 pla  bytnr adc  bytnr sta
   CS ?[  bytnr 1+ inc  ]?
 bytnr asl  bytnr 1+ rol
 bytnr asl  bytnr 1+ rol
 bytnr asl  bytnr 1+ rol
 y0 lda  7 # and  bytnr ora  bytnr sta

 clc  x0 lda  $F8 # and  bytnr adc
 bytnr sta
   x0 1+ lda  bytnr 1+ adc  bytnr 1+ sta
 bitmap hbyte # lda
 bytnr 1+ ora  bytnr 1+ sta
 x0 lda  7 # and  tax  bittab ,X lda
 0 # ldy  clc rts

\ *** Block No. 76, Hexblock 4c

\ Gr plot flip clpx            20oct87re  \ \ Sprite-Demo                  20oct87re

Code plot  ( x y -)                       \ Create Shapes  5 $40 * allot
 (plot jsr                                \  blk @ 4 +  block
 bytnr 1+ ldx bitmap hbyte # cpx          \  Shapes  5 $40 * cmove
 cs ?[ bytnr )Y ora  bytnr )Y sta ]?
Label  romon                              \ : init  ( -)
 1 inc  cli  xyNext jmp  end-code         \  graphic page
                                          \  blu border  blu background
Code flip  ( x y -)                       \  5 0 DO
 (plot jsr                                \      Shapes  I $40 * +  I getform LOOP
 bytnr 1+ ldx bitmap hbyte # cpx          \  grn wht sprcolors
 cs ?[ bytnr )Y eor  bytnr )Y sta ]?      \  5 0 DO  I 0 0 wht I setsprite  LOOP
 romon jmp  end-code                      \  5 0 DO  I small  I high  I 3colored set
                                          \          I behind LOOP  ;
Code unplot ( x y -)
 (plot jsr
 bytnr 1+ ldx bitmap hbyte # cpx cs ?[
 $FF # eor  bytnr )Y and bytnr )Y sta ]?
 romon jmp  end-code

\\ compute disables IRQ, the words
plot, flip, unplot and line enable the
IRQ again. Not nice, but the only was
because of the branch in 'line'.

\ *** Block No. 77, Hexblock 4d

\ Gr line 1                    20oct87re  \ \ Sprite-Demo                  20oct87re

Code line  ( x1 y1 x0 y0 -)               \ : ypos  ( spr# - y)  sprpos drop ;
 4 # lda  setup jsr
Label (drawto                             \ : xpos  ( spr# - x)  sprpos nip ;
 3 # ldx
 [[ y0 ,X lda  pointy ,X sta  dex  0< ?]  \ &26 Constant Distance
 $C7 # lda sec y1 sbc y1 sta
 $C7 # lda sec y0 sbc y0 sta              \ : 1+0-1  ( n - +1/0/-1)
                                          \  dup 0= not swap 0< 2* 1+ and ;
 ix sty  iy sty  ct sty  dey
 ax sty  ay sty  ct 1+ sty  dey           \ : follow-sprite ( spr# -)
 x1 lda  x0 cmp  x1 1+ lda  x0 1+ sbc     \ >r r@ xpos  r@ 1- xpos  Distance +
 CC ?[  sec  x0 lda  x1 sbc  dx sta       \    over -  1+0-1 + &344 min  r@ xmove
        x0 1+ lda  x1 1+ sbc  dx 1+ sta   \    pause
        ix sty                            \    r@ ypos  r@ 1- ypos
    ][  x1 lda  x0 sbc  dx sta            \    over -  1+0-1 +           r> ymove
        x1 1+ lda  x0 1+ sbc  dx 1+ sta   \    pause ;
    ]?  y1 lda  y0 cmp
 CC ?[  sec  y0 lda  y1 sbc  dy sta
        iy sty
    ][               y0 sbc  dy sta
    ]?  dx 1+ lda



\ *** Block No. 78, Hexblock 4e

\ Gr line 2                    20oct87re  \ \ Sprite-Demo                  20oct87re

 0= ?[  dx lda  dy cmp                    \ : follow-cursor  ( spr# -)
  CC ?[  dy ldx  dy sta  dx stx           \ >r r@ xpos  Col 8 * &33 +
         ix lda  ay sta  iy lda  ax sta   \    over -  1+0-1 +  r@ xmove  pause
         iny  ix sty  iy sty  ]?  ]?      \    r@ ypos  Row 8 * &59 +
 dx 1+ lda  .A lsr  offset 1+ sta         \    over -  1+0-1 +  r> ymove  pause ;
 dx lda     .A ror  offset sta
sec  CC ?[  .( Trick!! )                  \ : follow  ( spr# -)
 [[ ix lda                                \ pause  dup IF   follow-sprite
    0<> ?[ 0>= ?[  x0 winc                \            ELSE follow-cursor THEN ;
               ][  x0 wdec  ]?  ]?
    clc  y0 lda  ax adc  y0 sta           \ : killsprites  ( -)  0 sprite c! ;
    clc  offset lda  dy adc  offset sta
    CS ?[  offset 1+ inc  ]?   ct winc    \ : slide-sprites  ( -)
    dx lda  offset cmp  dx 1+ lda         \ 5 0 DO  I follow  I 1+ 0 DO  I follow
    offset 1+ sbc                         \ LOOP LOOP ;
    CC ?[  sec  offset lda  dx sbc
           offset sta  offset 1+ lda      \ \\
           dx 1+ sbc  offset 1+ sta
           ay lda                         \ : testslide ( -)
           0<> ?[  0>= ?[  x0 winc        \ init BEGIN  slide-sprites
                       ][  x0 wdec ]? ]?  \             key dup con!  3 = UNTIL ;
           clc  y0 lda  iy adc  y0 sta
    ]?

\ *** Block No. 79, Hexblock 4f

\ Gr line 3 flipline           20oct87re  \ \ Sprite-Demo                  20oct87re

 swap  ]?  .( Part 2 of trick! )          \ \needs tasks   .( Tasker? ) \\
 compute jsr
 bytnr 1+ ldx bitmap hbyte # cpx cs ?[    \ $100 $100 Task Demo
Label mode
 bytnr )Y ora  bytnr )Y sta ]?            \ : slide  ( -)
 1 inc  cli                               \  Demo activate
    dx lda  ct cmp                        \  init BEGIN  slide-sprites  REPEAT ;
    dx 1+ lda  ct 1+ sbc  CC ?]
 xyNext jmp  end-code                     \ : endslide  ( -)
                                          \  killsprites  Demo activate  stop ;
Code drawto  ( x1 y1 -)
 3 # ldy
 [[ pointy ,Y lda  y1 ,Y sta  dey  0< ?]
 2 # lda setup jsr  (drawto jmp
end-code

: flipline   ( x1 y1 x0 y0 -)
 $51 ( eor )  mode c! line
 $11 ( ora )  mode c! ;

\ bad self-modifying code



\ *** Block No. 80, Hexblock 50

\ Sprite constants             20oct87re  \ ªªª•uv•uv•ªª•€ •€ •ª •u`•u`•ª •€ •€ •€ •€
                                          \  •€ •€ •€ ª€          ª ª€ u`%ux•Iv•‚v•‚v
  $C800 Constant sprbuf                   \ •‚v•‚v•‚v•‚v•‚v•‚v•‚v•‚v•Iv%ux u` ª€
| $D000 Constant sprbase                  \     ªªª€•u`•ux•©v•‚v•‚v•©v•ux•u`•¥`•¥`•‰x
| $D010 Constant xposhi                   \ •‰x•‚v•‚v•‚v•‚vª‚ª         ªªªª•uv•uvªvª
  $D015 Constant sprite                   \ v  v  v  v  v  v  v  v  v  v  v  v  v  ª
| $D017 Constant yexpand                  \          ªª‚ª•‚v•‚v•‚v•‚v•‚v•ªv•uv•uv•ªv•
  $D01C Constant 3colored                 \ ‚v•‚v•‚v•‚v•‚v•‚v•‚vª‚ª         ª
| $D01D Constant xexpand
| $D025 Constant sprmcol
| $D027 Constant sprcol

| Create sbittab
 $01 c, $02 c, $04 c, $08 c,
 $10 c, $20 c, $40 c, $80 c,











\ *** Block No. 81, Hexblock 51

\ Spr setbit set formsprite    20oct87re  \ \ tiny sprite editor           06nov87re

| Code setbit   ( bitnr adr fl  -)        \ Onlyforth Graphic also definitions
 3 # lda  setup jsr  dey
 N 4 + ldx  sbittab ,X lda                \ \needs sprbuf  Create sprbuf $100 allot
 N ldx                                    \ \needs >byte : >byte $100 /mod ;
 0= ?[ $FF # eor  N 2+ )Y and
    ][  N 2+ )Y ora  ]?                   \ | Variable cbase  2 cbase !
 N 2+ )Y sta  xyNext jmp  end-code
                                          \ | : width ( -- n )  &16 cbase @ / ;
: set   ( bitnr adr  -)   True  setbit ;
                                          \ | : (l: ( -- )
: reset ( bitnr adr  -)   False setbit ;  \  base push  cbase @ base !
                                          \  name number  name number drop
: getform  ( adr mem#  -)                 \  >r  >byte drop  r@ c!
 $40 * sprbuf + $40 cmove ;               \  >byte r@ 1+ c!  r> 2+ c! ;

| : sprite!   ( mem# spr# adr -)          \ : l: (l: quit ;
 $3F8 + + c! ;
                                          \ : #.r  ( n width -- )
: formsprite  ( mem# spr# -)              \  >r 0 <#  r> 0 DO  #  LOOP  #> type ;
 >r sprbuf $3F00 and $40 / + dup
 r@ vidram sprite!  r> colram sprite! ;   \ : arguments  ( n -- )
                                          \  depth < not abort" Arguments?" ;
                                          \                                     -->

\ *** Block No. 82, Hexblock 52

\ Spr move sprpos              20oct87re  \ \ tiny sprite editor           06nov87re

: xmove   ( x spr#  -)                    \ | Create savearea $1A allot
 2dup 2* sprbase + c!                     \ | Variable xsave    | Variable ysave
 xposhi rot $FF > setbit ;                \ | Variable saved    saved off

: ymove   ( y spr#  -)                    \ | : savesprites  ( -- )
 2* 1+ sprbase + c! ;                     \  saved @ ?exit
                                          \  sprite savearea $1A cmove  0 sprite c!
: move    ( y x spr#  -)                  \  7 sprpos xsave ! ysave ! saved on ;
 under xmove ymove ;
                                          \ : fertig  ( -- )
                                          \  saved @ not ?exit
: sprpos  ( spr# - y x)                   \  ysave @ xsave @ 7 move
 dup >r 2* 1+ sprbase + c@                \  savearea sprite $1A cmove saved off ;
 r@ 2* sprbase + c@
 r> sbittab + c@ xposhi c@ and            \ | : sprline  ( adr line -- )
 IF $100 + THEN ;                         \  base push  dup 2* + +  cr
                                          \  ." l: "  cbase @ base !
                                          \  dup count width #.r  count width #.r
                                          \  c@ width #.r  ." . $" hex 4 #.r ;



                                          \                                     -->

\ *** Block No. 83, Hexblock 53

\ Sprite Qualities             20oct87re  \ \ tiny sprite editor           06nov87re

: high    ( spr# -)   yexpand set ;       \ | : slist  ( mem# -- )
                                          \  $40 * sprbuf +
: low     ( spr# -)   yexpand reset ;     \  &21 0 DO  dup I sprline
                                          \            stop? IF  LEAVE  THEN  LOOP
: wide    ( spr# -)   xexpand set ;       \  drop cr  ." fertig"  0 0 at quit ;

: slim    ( spr# -)   xexpand reset ;     \ : sed  ( mem# -- )
                                          \  1 arguments  &32 min
: big     ( spr# -)   dup high wide ;     \  page dup . ." sed \ 1 color"
                                          \  savesprites  2 cbase !
: small   ( spr# -)   dup low slim ;      \  dup $40 $128 yel 7 setsprite
                                          \  7 3colored reset  7 big  slist ;
: behind  ( spr# -)   $D01B set ;
                                          \ : ced  ( mem# -- )
: infront ( spr# -)   $D01B reset ;       \  1 arguments  &32 min
                                          \  page dup . ." ced \ 3 colors"
: colored ( spr# col  -)                  \  savesprites  4 cbase !
 swap sprcol + c! ;                       \  blk gr2 sprcolors
                                          \  dup $40 $128 yel 7 setsprite
                                          \  7 3colored set  7 high  slist ;




\ *** Block No. 84, Hexblock 54

\ Spr sprcolors setsprite      20oct87re

: sprcolors  ( col# col#  -)
 sprmcol 1+ c! sprmcol c! ;

: setsprite  ( mem# y x color spr# -)
 under >r colored   r@ move
 r@ under formsprite small
 r@ 3colored reset  r> sprite set ;
















