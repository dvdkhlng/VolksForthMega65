
\ *** Block No. 0, Hexblock 0

\\ Directory 1of4 26oct87re   cas17aug06

.                     0
..                    0
Content               1
Editor-Intro          2
First-Indo            3
Load-System           4
Load-Demo             5
loadfrom              6
simple File           8
help                &10
FORTH-Group         &11
Number Game         &12
buffers             &13
dump                &14
Disassembler        &16
TEST.DIR            &23
savesystem          &26
formatdisk          &27
copydisk            &28
copy2disk           &29




\ *** Block No. 1, Hexblock 1

\\ Content volksForth 1of4    cas17aug06

Directory             0
Content               1
Editor Short Info     2
First Info            3
Load System           4
simple File           8
help                &10
Forth Group         &11
Number-Game         &12
relocate the system &13
dump                &14 -  &15
6502-Disassembler   &16 -  &22
 Test-Folder        &23 -  &25
savesystem          &26
bamallot formatdisk &27
copydisk            &28
2disk copy2disk     &29 -  &30
  free              &31 -  &36
  prg-files         &37 -  &84
Shadows             &85 - &121
  prg-files        &122 - &169

FORTH-GESELLSCHAFT(c)

\ *** Block No. 2, Hexblock 2

  *** volksFORTH  EDITOR Commands
 special Functions:
    Ctrl o  Overwrite   Ctrl i  Insmode
    Ctrl $  .stamp      Ctrl #  .scr#
    Ctrl '  search
 Cursor Control:
    normal Functions, other:
    F7      +tab        F8      -tab
    CLR     >text-end   RETURN  CR
 Char-Editing:
    F5      buf>char    F6      char>buf
    DEL     backspace   INST    insert
    Ctrl d  Delete      Ctrl @  copychar
 Line-Editing:
    F1      newline     F2      killine
    F3      buf>line    F4      line>buf
    Ctrl e  Eraseline   Ctrl r  clrRight
    Ctrl ^  copyline
 Pageing:
    Ctrl n  >Next       Ctrl b  >Back
    Ctrl a  >Alternate  Ctrl w  >shadoW
 Leaving the Editor:
    Ctrl c  Canceled    Ctrl x  updated
    Ctrl f  Flushed     Ctrl l  Loading
FORTH-GESELLSCHAFT (c) 1985-2006

\ *** Block No. 3, Hexblock 3

  You are in Editormode  Screen # 3
     Back to FORTH with RUN/STOP


        *** volksFORTH-83 ***

      Call Editor with
   "l ( n -- )" or with "r ( -- )"

    WARNING! Without FORTH Experience
    work with backup copies of the
    Disks or with write protected Disks

   Some FORTH Words to try outside the
               Editor:
            WORDS   ORDER
              VIEW HELP
          and the C= -Key

       Turn Page back with "Ctrl b"




FORTH-GESELLSCHAFT   (c) bp/ks/re/we/clv

\ *** Block No. 4, Hexblock 4

\ Load a work system           05nov87re

Onlyforth

     2 +load       \ loadfrom
&46 c: loadfrom    \ .blk
  4 c: loadfrom    \ Transient Assemb
&19 c: loadfrom    \ Editor
&26 a: loadfrom    \ savesystem
oldsave
     2 +load       \ loadfrom
  5 c: loadfrom    \ Assembler
&47 c: loadfrom    \ Tracer + Tools
&13 a: loadfrom    \ Buffers








oldsave   \\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 5, Hexblock 5

\ Load C64 Demo                21oct87re

(16 .( Nicht fuer C16!) \\ C)

Onlyforth

1 +load   \ loadfrom

limit first @ -   b/buf 8 * -
?\ 8 buffers

\needs demostart : demostart ; 90 allot
\needs tasks        $39 C: loadfrom
\needs help         $A  A: loadfrom
\needs slide        &6  D: loadfrom

1 scr !  0 r# !

Onlyforth

oldsave

\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 6, Hexblock 6

\ getdisk loadfrom             20oct87re

here   $200 hallot  heap dp !

: getdisk  ( drv -- )
 cr  ." Please Insert Disk "
 1+ .
 key drop  .status  cr ;

: loadfrom  ( blk drv -- )
 ?dup 0= IF  load exit  THEN
 flush  getdisk  load
 flush  0 getdisk ;

0 Constant A:       1 Constant B:
2 Constant C:       3 Constant D:

: ?\  ( f -- )   ?exit  [compile] \ ;

                              -->




FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 7, Hexblock 7

\ New save empty clear         20oct87re

' save  Alias oldsave
' clear Alias oldclear
' empty Alias oldempty

: save  state @ IF  compile save  THEN ;
  immediate

: clear state @ IF  compile clear THEN ;
  immediate

: empty state @ IF  compile empty THEN ;
  immediate

dp !






\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 8, Hexblock 8

\ simple filesystem            20oct87re

\needs (search  .( (search missing) \\

' word >body 2+ @ Alias (word

0 Constant folder

' folder >body | Constant >folder

: root   >folder off ; folder

  : directory ( -- addr len )
 folder block  b/blk ;

  : (fsearch ( adr len -- n )
 directory (search
 0= abort" not found"
 folder block -  >in push  >in !
 BEGIN  bl directory (word capitalize
        dup c@ 0= abort" exhausted"
        number? ?dup not
 WHILE  drop  REPEAT  0< ?exit  drop ;

-->

\ *** Block No. 9, Hexblock 9

\ simple Filesystem            20oct87re

: split
 ( adr len char -- adr2 len2 adr1 len1 )
 >r 2dup r@ scan  r>
 over >r  skip  2swap  r> - ;

: read  ( -- n ) \ /path/file
 bl word count dup 0= abort" What?"
 pad place  pad count
 BEGIN  Ascii / split
  dup IF    (fsearch
      ELSE  nip root    THEN  over
 WHILE  >folder +!  REPEAT
 -rot 2drop folder + ;

: ld  read load ;      \ LoaD
: sh  read list ;      \ SHow
: ed  read l ;         \ EDit
: cd  read >folder ! ; \ Change Dir
: ls  folder list ;    \ LiSt Dir



FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 10, Hexblock a

\ help                        14oct85re)

Onlyforth

: help  ( --)
 3 l                \ list Scr # 3

 cr ." Additional Help can be"
 cr ." found on the Net"
 cr ." or in a local FORTH User Group"
 cr ." FORTH-Gesellschaft"
 cr ." www.forth-ev.de" cr ;

       \ print silly text








\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 11, Hexblock b



























\ *** Block No. 12, Hexblock c

\ numbers                     05jul85re)

decimal             \ sorry, but this
                    \ is for YOU !

: alphabetic  ( --)  &36 base ! ;

hex                 \ Ah, much better


\ Look at this:


31067E6.  alphabetic d.       hex
19211D5.  alphabetic d.       hex
   -123.  alphabetic d.       hex


\ Try to explain !



\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 13, Hexblock d

\ relocating the system        20oct87re

| : relocate-tasks  ( newUP -- )
 up@ dup
 BEGIN  1+ under @ 2dup -
 WHILE  rot drop  REPEAT  2drop ! ;

: relocate  ( stacklen rstacklen -- )
 swap  origin +
 2dup + b/buf + 2+  limit u>
  abort" buffers?"
 dup   pad  $100 +  u< abort" stack?"
 over  udp @ $40 +  u< abort" rstack?"
 flush empty
 under  +   origin $A + !        \ r0
 dup relocate-tasks
 up@ 1+ @   origin   1+ !        \ task
       6 -  origin  8 + ! cold ; \ s0

: bytes.more  ( n -- )
 up@ origin -  +  r0 @ up@ - relocate ;

: buffers  ( +n -- )
 b/buf * 2+  limit r0 @ -
 swap - bytes.more ;

\ *** Block No. 14, Hexblock e

\ dump utility                30nov85re
\ adapted from F83 Laxen/Perry

| : .2  ( n --)
 0 <# # # #> type space ;

| : D.2  ( adr len --)
 bounds ?DO  I c@ .2  LOOP ;

: dln  ( adr --)  \ DumpLiNe
 cr  dup 4 u.r  space  dup 8 D.2
 ." z "  8 bounds DO  I c@ emit  LOOP ;

| : ?.n  ( n0 n1 -- n0)
 2dup = IF  rvson  THEN
 2 .r  rvsoff  space ;

| : ?.a  ( n0 n1 -- n0)
 2dup = IF  rvson  THEN  1 .r rvsoff ;

-->



FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 15, Hexblock f

\ dump utility                30nov85re
\ adapted from F83 Laxen/Perry

| : .head  ( adr len -- adr' len')
 swap  dup $FFF0 and  swap $F and
 2 0 DO  cr 5 spaces
  I 8 * 8 bounds DO I ?.n LOOP 2 spaces
  I 8 * 8 bounds DO I ?.a LOOP
 LOOP  rot + ;

: dump  ( adr len --)
 base push  hex  .head
 bounds ?DO  I dln  stop? IF LEAVE THEN
             8 +LOOP cr ;

: z  ( adr n0 ... n7 --)
 row 2- >r  unlink
 8 pick 7 + -7 bounds
 DO  I c!  -1 +LOOP r> 0 at dln  quit ;


clear




\ *** Block No. 16, Hexblock 10

\ disassembler 6502 loadscr    06mar86re

Onlyforth

\needs Tools Vocabulary Tools

Tools also definitions hex

| : table    ( +n -- )
 Create     0 DO
 bl word number drop , LOOP
 Does> ( 8b1 -- 8b2 +n )
 + count swap c@ ;

-->











\ *** Block No. 17, Hexblock 11

\ dis shortcode0               20oct87re

base @  hex

$80 | table shortcode0
0B10 0000 0000 0341 2510 0320 0000 0332
0AC1 0000 0000 03A1 0E10 0000 0000 0362
1D32 0000 0741 2841 2710 2820 0732 2832
08C1 0000 0000 28A1 2D10 0000 0000 2862
2A10 0000 0000 2141 2410 2120 1C32 2132
0CC1 0000 0000 21A1 1010 0000 0000 2162
2B10 0000 0000 2941 2610 2920 1CD2 2932
0DC1 0000 0000 29A1 2F10 0000 0000 2962
0000 0000 3241 3141 1710 3610 3232 3132
04C1 0000 32A1 31B1 3810 3710 0000 0000
2051 1F51 2041 1F41 3410 3310 2032 1F32
05C1 0000 20A1 1FB1 1110 3510 2062 1F72
1451 0000 1441 1541 1B10 1610 1432 1532
09C1 0000 0000 15A1 0F10 0000 0000 1562
1351 0000 1341 1941 1A10 2210 1332 1932
06C1 0000 0000 19A1 2E10 0000 0000 1962

base !

-->

\ *** Block No. 18, Hexblock 12

\ dis scode adrmode            20oct87re

| Create scode
 $23 c, $02 c, $18 c, $01 c,
 $30 c, $1e c, $12 c, $2c c,

| Create adrmode
 $81 c, $41 c, $51 c, $32 c,
 $91 c, $a1 c, $72 c, $62 c,

| : shortcode1 ( 8b1 - 8b2 +n)
 2/ dup 1 and
 IF  0= 0  exit  THEN
 2/ dup $7 and adrmode + c@
 swap 2/ 2/ 2/ $7 and scode + c@ ;

| Variable mode

| Variable length

-->





\ *** Block No. 19, Hexblock 13

\ dis shortcode texttab        06mar86re

| : shortcode ( 8b1 -- +n )
 dup 1 and         ( odd codes)
 IF  dup $89 =
  IF  drop 2  THEN  shortcode1
 ELSE  shortcode0  ( evend codes)
 THEN
 swap dup 3 and length !
 2/ 2/ 2/ 2/ mode ! ;

| : texttab   ( char +n 8b -- )
 Create
 dup c, swap 0 DO >r dup word
 1+ here r@ cmove r@ allot r>
 LOOP 2drop
 Does>  ( +n -- )
 count >r swap r@ * + r> type ;

-->






\ *** Block No. 20, Hexblock 14

\ dis text-table               06mar86re

bl $39 3 | texttab .mnemonic
*by adc and asl bcc bcs beq bit bmi bne
bpl brk bvc bvs clc cld cli clv cmp cpx
cpy dec dex dey eor inc inx iny jmp jsr
lda ldx ldy lsr nop ora pha php pla plp
rol ror rti rts sbc sec sed sei sta stx
sty tax tay tsx txa txs tya
( +n -- )

Ascii / $E 1 | texttab .before
   / /a/ /z/#/ / /(/(/z/z/ /(/


Ascii / $E 3 | texttab .after
     /   /   /   /   /   /,x
 /,y /,x)/),y/,x /,y /   /)  /

-->






\ *** Block No. 21, Hexblock 15

\ dis 2u.r 4u.r                06mar86re

: 4u.r ( u -)
  0 <# # # # # #> type ;

: 2u.r ( u -)
  0 <# # # #> type ;

-->

















\ *** Block No. 22, Hexblock 16

\ dis                          20oct87re

Forth definitions

: dis   ( adr -- ) base push hex
BEGIN
 cr dup 4u.r space dup c@ dup 2u.r space
 shortcode >r length @ dup
 IF over 1+ c@ 2u.r space THEN dup 2 =
 IF over 2+ c@ 2u.r space THEN
 2 swap - 3 * spaces
 r> .mnemonic space 1+
 mode @ dup .before $C =
 IF dup c@ dup $80 and IF $100 - THEN
  over + 1+ 4u.r
 ELSE length @ dup 2 swap - 2* spaces
  ?dup
  IF 2 =
   IF   dup  @ 4u.r
   ELSE dup c@ 2u.r
 THEN THEN THEN mode @ .after length @ +
 stop?  UNTIL drop ;


Onlyforth clear

\ *** Block No. 23, Hexblock 17

\\ Subdirectory test.dir       26oct87re

.                    0
..                -&23
all-words            1
free                 2




















\ *** Block No. 24, Hexblock 18

\ pretty words                 26oct87re

: .type  ( cfa -- )   dup @ swap 2+
             case? IF ." Code" exit THEN
 ['] :     @ case? IF ."    :" exit THEN
 ['] base  @ case? IF ." User" exit THEN
 ['] first @ case? IF ."  Var" exit THEN
 ['] limit @ case? IF ."  Con" exit THEN
 ['] Forth @ case? IF ."  Voc" exit THEN
 ['] r/w   @ case? IF ."  Def" exit THEN
 drop ." ????" ;

: (words  ( link -- )
 BEGIN  stop? abort" stopped"  @ dup
 WHILE  cr dup 2- @ 3 .r space
        dup 2+  dup name> .type space
        .name  REPEAT drop ;

: all-words ( -- )
 voc-link
 BEGIN  @ ?dup
 WHILE  dup 6 - >name
        cr cr .name ."  words:" cr
        ." Blk Type Name "
        dup 4 - (words  REPEAT ;

\ *** Block No. 25, Hexblock 19



























\ *** Block No. 26, Hexblock 1a

\ savesystem                   23oct87re

| : (savsys ( adr len -- )
 [ Assembler ] Next  [ Forth ]
 ['] pause  dup push  !  \ singletask
 i/o push  i/o off  bustype ;

: savesystem   \ name must follow
    \ prepare Forth Kernal
 scr push  1 scr !  r# push  r# off
    \ prepare Editor
 [ Editor ]
 stamp$ dup push off
 (pad   dup push off
    \ now we save the system
 save
 8 2 busopen  0 parse bustype
 " ,p,w" count bustype  busoff
 8 2 busout  origin $17 -
 dup  $100 u/mod  swap bus! bus!
 here over - (savsys  busoff
 8 2 busclose
 0 (drv ! derror? abort" save-error" ;

Onlyforth

\ *** Block No. 27, Hexblock 1b

\ bamallocate, formatdisk      20oct87re

: bamallocate ( --)
 diskopen ?exit
 pad &18 0 readsector 0=
  IF pad 4 + $8C erase
     pad &18 0 writesector drop
  THEN  diskclose
 8 &15 busout " i0" count bustype
 busoff ;

: formatdisk ( --)  \ name must follow
 8 &15 busout " n0:" count bustype
 0 parse bustype busoff
 derror? ?exit
 bamallocate ;

\ example: formatdisk volksFORTH,id






FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 28, Hexblock 1c

\ copydisk                    06jun85we)

| Variable distance

limit first @ - b/buf /  | Constant bufs

| : backupbufs  ( from count --)
 cr ." Insert Source-Disk" key drop cr
 bounds 2dup DO  I block drop  LOOP
 cr ." Insert Destination-Disk"
 key drop cr
 distance @ ?dup
 IF    >r  swap 1- over  r> +  convey
 ELSE  DO  I block drop update  LOOP
       save-buffers THEN ;

: copydisk  ( blk1 blk2] [to.blk --)
 2 pick - distance !  1+ over -
 dup 0> not Abort" RANGE ERROR!"
 bufs /mod ?dup
 IF swap >r 0
    DO dup bufs backupbufs bufs +  LOOP
    r> THEN
 ?dup IF backupbufs ELSE drop THEN ;


\ *** Block No. 29, Hexblock 1d

\ 2disk copy2disk..           clv14jul87


$165 | Constant 1.t
$1EA | Constant 2.t
$256 | Constant 3.t


| : (s#>s+t ( sector# -- sect track)
      dup 1.t u< IF $15 /mod exit THEN
( 3+) dup 2.t u< IF 1.t - $13 /mod $11 +
                            exit THEN
      dup 3.t u< IF 2.t - $12 /mod $18 +
                            exit THEN
                    3.t - $11 /mod $1E +
 ;


| : s#>t+s  ( sector# -- track sect )
 (s#>s+t  1+ swap ;




-->

\ *** Block No. 30, Hexblock 1e

\ ..2disk copy2disk           clv04aug87


| : ?e ( flag--)
  ?dup IF ." Drv " (drv @ . diskclose
          abort" " THEN ;

| : op ( drv#--) (drv ! diskopen ?e ;

: copysector \ adr sec# --
  2dup
  0 op s#>t+s readsector  ?e diskclose
  1 op s#>t+s writesector ?e diskclose ;

: copy2disk \ -- \ for 2 Floppys
 pad dup $110 + sp@ u> abort" no room"
 cr ." Source=0, Dest=1" key drop cr
 base push decimal      0 &682
 DO I . I s#>t+s . . cr $91 con!
    dup I copysector   -1 +LOOP drop ;

: 2disk1551 \ -- switch 1551 to #9
 flush 8 &15 busopen " %9" count bustype
 busoff derror? drop ;


\ *** Block No. 31, Hexblock 1f

\ nothing special here

























\ *** Block No. 32, Hexblock 20



























\ *** Block No. 33, Hexblock 21



























\ *** Block No. 34, Hexblock 22



























\ *** Block No. 35, Hexblock 23



























\ *** Block No. 36, Hexblock 24



























\ *** Block No. 37, Hexblock 25



























\ *** Block No. 38, Hexblock 26



























\ *** Block No. 39, Hexblock 27



























\ *** Block No. 40, Hexblock 28



























\ *** Block No. 41, Hexblock 29



























\ *** Block No. 42, Hexblock 2a



























\ *** Block No. 43, Hexblock 2b



























\ *** Block No. 44, Hexblock 2c



























\ *** Block No. 45, Hexblock 2d



























\ *** Block No. 46, Hexblock 2e



























\ *** Block No. 47, Hexblock 2f



























\ *** Block No. 48, Hexblock 30



























\ *** Block No. 49, Hexblock 31



























\ *** Block No. 50, Hexblock 32



























\ *** Block No. 51, Hexblock 33



























\ *** Block No. 52, Hexblock 34



























\ *** Block No. 53, Hexblock 35



























\ *** Block No. 54, Hexblock 36



























\ *** Block No. 55, Hexblock 37



























\ *** Block No. 56, Hexblock 38



























\ *** Block No. 57, Hexblock 39



























\ *** Block No. 58, Hexblock 3a



























\ *** Block No. 59, Hexblock 3b



























\ *** Block No. 60, Hexblock 3c



























\ *** Block No. 61, Hexblock 3d



























\ *** Block No. 62, Hexblock 3e



























\ *** Block No. 63, Hexblock 3f



























\ *** Block No. 64, Hexblock 40



























\ *** Block No. 65, Hexblock 41



























\ *** Block No. 66, Hexblock 42



























\ *** Block No. 67, Hexblock 43



























\ *** Block No. 68, Hexblock 44



























\ *** Block No. 69, Hexblock 45



























\ *** Block No. 70, Hexblock 46



























\ *** Block No. 71, Hexblock 47



























\ *** Block No. 72, Hexblock 48



























\ *** Block No. 73, Hexblock 49



























\ *** Block No. 74, Hexblock 4a



























\ *** Block No. 75, Hexblock 4b



























\ *** Block No. 76, Hexblock 4c



























\ *** Block No. 77, Hexblock 4d



























\ *** Block No. 78, Hexblock 4e



























\ *** Block No. 79, Hexblock 4f



























\ *** Block No. 80, Hexblock 50



























\ *** Block No. 81, Hexblock 51



























\ *** Block No. 82, Hexblock 52



























\ *** Block No. 83, Hexblock 53



























\ *** Block No. 84, Hexblock 54



























\ *** Block No. 85, Hexblock 55

\\   Dies ist der Shadow-Screen
          zum Screen # 0

 Der Screen # 0 laesst sich nicht laden
  (ist der Inhalt von BLK gleich 0, so
   wird der Quelltext von der Tastatur
  geholt, ist BLK von 0 verschieden, so
   wird der entsprechende BLOCK von der
      Diskette geladen), der Editor
  unterstuetzt deshalb auch nicht das
  Shadow-Konzept fuer den Screen # 0.













FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 86, Hexblock 56

Shadow for Scr# 1

Screen # 1 should always contain
a directory listing
a good Rule is:

 FIRST  edit the entry in screen 1

 THEN   edit the sourcecode

If needed screens 2-4 can also be used
for the directory listing








            BTW, have you done

          A BACKUP OF YOUR DISKS?

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 87, Hexblock 57

Shadow for Scr# 2

The Editor is designed to prevent
accidently deletion of text, neither
at the end of a line nor at the end
of a screen will txt disappear


If you like to clear a whole screen,
use HOME to jump to line 0 and press
SHIFT F1 (=F2) to move all lies up
untill the whole screen is filled with
new empty lines


If this is too much work, define:

: wipe  ( -- )   \  fill block with
 scr @ block     \  spaces
 b/blk bl fill ; \\

and use WIPE after LISTing the screen
to be cleared

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 88, Hexblock 58

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

























\ *** Block No. 89, Hexblock 59



























\ *** Block No. 90, Hexblock 5a



























\ *** Block No. 91, Hexblock 5b



























\ *** Block No. 92, Hexblock 5c



























\ *** Block No. 93, Hexblock 5d

\\ simple file system          20oct87re

A FOLDER is a single connected screen
Area, containing a Directory Screen
with File- and Folder-Names and
their relative screen numbers:

..     -&150        .            0
FILENAME  $D        FOLDERNAME &13

The ROOT-ORDNER is the whole Disk
with a Diretory in Screen 0. All Screen-
Numbers in ROOT are absolute.

All Screen-Numbers must be maintained
manually.

When moving a complete folder, only the
Screen offsets in the Parent-Folder
needs to be adjusted


.. and . are not mandatory, but without
then the user cannot access the parent
directory

\ *** Block No. 94, Hexblock 5e

\\ simple Filesystem           20oct87re

SPLIT cuts a String at first occurance
 of CHAR. The first part will be stored
 above, the remainder below.
 The Rest$ can contain CHAR again.

READs Path and Filenames. Syntax:

 cd /
     Current DIR becomes ROOT-Directory
 cd /Sub1/
            DIR becomes SUB1 from ROOT
 cd Sub2/
        DIR becomes Sub2 from current
 cd ../
        DIR becomes parent DIR
 ld /File1
        Load File1 from root
 ld File2
        Load File2 from current DIR
 ld /Sub3/File3
     Load File3 in Sub3 from ROOT
 ld Sub4/File4
     Load File4 in Sub4 from curr. DIR

\ *** Block No. 95, Hexblock 5f





  HELP  !!!










       Hummel, Hummel - Forth, Forth










\ *** Block No. 96, Hexblock 60



























\ *** Block No. 97, Hexblock 61

\ Comment to numbers          14oct85re)




alphabetic - not HEX or DECIMAL
  09 follows 08, 0A follow 09
  next 0B etc. until 0Z, 10 follows 0Z
  then 11  ...  19, 1A, 1B, 1C, ...




hex-Zahl  alphabetic display
hex-Zahl  alphabetic display
hex-Zahl  alphabetic display


The other way is also possible
 (this is how we created the hex
  numbers of "numbers" )

Do you need BINARY or OCTAL ?
 : binary  ( --)   2 base ! ;
 : octal  ( --)   8 base ! ;

\ *** Block No. 98, Hexblock 62

\\ relocating the system    bp 19 9 84 )

up@ origin -   is stacklen
r0 @ up@ -     is rstacklen

symbolic map of system

FUNKTION     TOP          BOTTOM

disk-buffer  limit        first @
 unused area
rstack       r0 @         rp@

 free area

user, warm   up@ udp @ +  up@
(heap)       up@          heap
stack        s0 @         sp@

 free area

system       here         origin 0FE +
user, cold   origin 100 + origin
screen       0800         0400
page 0-3     0400         0000

\ *** Block No. 99, Hexblock 63



























\ *** Block No. 100, Hexblock 64



























\ *** Block No. 101, Hexblock 65

\\ disassembler 6502 loadscr







+n Values will be placed inside an
Array
















\ *** Block No. 102, Hexblock 66

\\ dis shortcode0

Table for the complicated even opcodes



Table-Solution



















\ *** Block No. 103, Hexblock 67

\\ dis scode adrmode

Helptable for odd Opcodes



Helptable for odd Opcodes
 Addressmodes


calculates from Opcode 8b1
the addressingmode 8b2
and commandlength +n
for odd Opcodes












\ *** Block No. 104, Hexblock 68

\\ dis shortcode texttab

calulates Commandlength (length)
and Addressingmode (mode)
from Opcode (8b1)






defining word for Text-Tables

Datastructure:

count text1 text2 ... text+n-1 text+n










\ *** Block No. 105, Hexblock 69

\\ text-tabellen

the Mnemonic-Table








the BEFORE Table



the AFTER Table










\ *** Block No. 106, Hexblock 6a

\\ dis 4u.r 2u.r

4u.r print address with leading zeros


2u.r prints byte with leading zeros




















\ *** Block No. 107, Hexblock 6b

\\ dis shadow

"dis" is an ugly word. Better
names for this word are welcome






















\ *** Block No. 108, Hexblock 6c



























\ *** Block No. 109, Hexblock 6d



























\ *** Block No. 110, Hexblock 6e



























\ *** Block No. 111, Hexblock 6f

\\ savesystem shadow          clv04aug87


Usage: SAVESYSTEM name
Example: SAVESYSTEM MY-FORTH
        --creates a loadable File
        --with Name MEIN-FORTH.

  A complex program can contain it own
  SAVESYSTEM buildng on top of the
  generic one, preparing it's own
  Datastructures for later loading.














\ *** Block No. 112, Hexblock 70

Comment for  bamallocate, formatdisk

Creates Entry "0 blocks free"
 open Disk
 read BAM
  IF clear BAM (almost)
     writes back BAM
  THEN  closes disk
 initialize again
 and finish!

CLEAR   (formatted) Disk
 send clear command
 send name
  sucessfull?
 pretent the disk is full










\ *** Block No. 113, Hexblock 71

???

  This page unintentionaly left blank.













copies no dictionary. cannot be used
for Files, only for FORTH Screens








\ *** Block No. 114, Hexblock 72

\\ zu:2disk copy2disk..       clv04aug87


this calculates the cunmber
[0..&682] out of track and sector





















\ *** Block No. 115, Hexblock 73

\\ zu:..2disk copy2disk       clv04aug87


Checks for Disk error



Abbreviation for OPen. 40 Chars are too

copies a secotr (using adr)





 Check if there is Space at PAD
 Status messages

 Loops over allsectors
 prints out some numbers


 switches only(!!) 1551-Floppys.
 For 1541 its too complicated.


\ *** Block No. 116, Hexblock 74



























\ *** Block No. 117, Hexblock 75



























\ *** Block No. 118, Hexblock 76



























\ *** Block No. 119, Hexblock 77



























\ *** Block No. 120, Hexblock 78



























\ *** Block No. 121, Hexblock 79



























\ *** Block No. 122, Hexblock 7a



























\ *** Block No. 123, Hexblock 7b



























\ *** Block No. 124, Hexblock 7c



























\ *** Block No. 125, Hexblock 7d



























\ *** Block No. 126, Hexblock 7e



























\ *** Block No. 127, Hexblock 7f



























\ *** Block No. 128, Hexblock 80



























\ *** Block No. 129, Hexblock 81



























\ *** Block No. 130, Hexblock 82



























\ *** Block No. 131, Hexblock 83



























\ *** Block No. 132, Hexblock 84



























\ *** Block No. 133, Hexblock 85



























\ *** Block No. 134, Hexblock 86



























\ *** Block No. 135, Hexblock 87



























\ *** Block No. 136, Hexblock 88



























\ *** Block No. 137, Hexblock 89



























\ *** Block No. 138, Hexblock 8a



























\ *** Block No. 139, Hexblock 8b



























\ *** Block No. 140, Hexblock 8c



























\ *** Block No. 141, Hexblock 8d



























\ *** Block No. 142, Hexblock 8e



























\ *** Block No. 143, Hexblock 8f



























\ *** Block No. 144, Hexblock 90



























\ *** Block No. 145, Hexblock 91



























\ *** Block No. 146, Hexblock 92



























\ *** Block No. 147, Hexblock 93



























\ *** Block No. 148, Hexblock 94



























\ *** Block No. 149, Hexblock 95



























\ *** Block No. 150, Hexblock 96



























\ *** Block No. 151, Hexblock 97



























\ *** Block No. 152, Hexblock 98



























\ *** Block No. 153, Hexblock 99



























\ *** Block No. 154, Hexblock 9a



























\ *** Block No. 155, Hexblock 9b



























\ *** Block No. 156, Hexblock 9c



























\ *** Block No. 157, Hexblock 9d



























\ *** Block No. 158, Hexblock 9e



























\ *** Block No. 159, Hexblock 9f



























\ *** Block No. 160, Hexblock a0



























\ *** Block No. 161, Hexblock a1



























\ *** Block No. 162, Hexblock a2



























\ *** Block No. 163, Hexblock a3



























\ *** Block No. 164, Hexblock a4



























\ *** Block No. 165, Hexblock a5



























\ *** Block No. 166, Hexblock a6



























\ *** Block No. 167, Hexblock a7



























\ *** Block No. 168, Hexblock a8



























\ *** Block No. 169, Hexblock a9


























