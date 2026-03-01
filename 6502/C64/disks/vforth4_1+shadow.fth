
\ *** Block No. 0, Hexblock 0

\\ Directory 1of4 26oct87re   cas17aug06  \ \\   Dies ist der Shadow-Screen
                                          \           zum Screen # 0
.                     0
..                    0                   \  Der Screen # 0 laesst sich nicht laden
Content               1                   \   (ist der Inhalt von BLK gleich 0, so
Editor-Intro          2                   \    wird der Quelltext von der Tastatur
First-Indo            3                   \   geholt, ist BLK von 0 verschieden, so
Load-System           4                   \    wird der entsprechende BLOCK von der
Load-Demo             5                   \       Diskette geladen), der Editor
loadfrom              6                   \   unterstuetzt deshalb auch nicht das
simple File           8                   \   Shadow-Konzept fuer den Screen # 0.
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


                                          \ FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 1, Hexblock 1

\\ Content volksForth 1of4    cas17aug06  \ Shadow for Scr# 1

Directory             0                   \ Screen # 1 should always contain
Content               1                   \ a directory listing
Editor Short Info     2                   \ a good Rule is:
First Info            3
Load System           4                   \  FIRST  edit the entry in screen 1
simple File           8
help                &10                   \  THEN   edit the sourcecode
Forth Group         &11
Number-Game         &12                   \ If needed screens 2-4 can also be used
relocate the system &13                   \ for the directory listing
dump                &14 -  &15
6502-Disassembler   &16 -  &22
 Test-Folder        &23 -  &25
savesystem          &26
bamallot formatdisk &27
copydisk            &28
2disk copy2disk     &29 -  &30
  free              &31 -  &36
  prg-files         &37 -  &84            \             BTW, have you done
Shadows             &85 - &121
  prg-files        &122 - &169            \           A BACKUP OF YOUR DISKS?

FORTH-GESELLSCHAFT(c)                     \ FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 2, Hexblock 2

  *** volksFORTH  EDITOR Commands         \ Shadow for Scr# 2
 special Functions:
    Ctrl o  Overwrite   Ctrl i  Insmode   \ The Editor is designed to prevent
    Ctrl $  .stamp      Ctrl #  .scr#     \ accidently deletion of text, neither
    Ctrl '  search                        \ at the end of a line nor at the end
 Cursor Control:                          \ of a screen will txt disappear
    normal Functions, other:
    F7      +tab        F8      -tab
    CLR     >text-end   RETURN  CR        \ If you like to clear a whole screen,
 Char-Editing:                            \ use HOME to jump to line 0 and press
    F5      buf>char    F6      char>buf  \ SHIFT F1 (=F2) to move all lies up
    DEL     backspace   INST    insert    \ untill the whole screen is filled with
    Ctrl d  Delete      Ctrl @  copychar  \ new empty lines
 Line-Editing:
    F1      newline     F2      killine
    F3      buf>line    F4      line>buf  \ If this is too much work, define:
    Ctrl e  Eraseline   Ctrl r  clrRight
    Ctrl ^  copyline                      \ : wipe  ( -- )   \  fill block with
 Pageing:                                 \  scr @ block     \  spaces
    Ctrl n  >Next       Ctrl b  >Back     \  b/blk bl fill ; \\
    Ctrl a  >Alternate  Ctrl w  >shadoW
 Leaving the Editor:                      \ and use WIPE after LISTing the screen
    Ctrl c  Canceled    Ctrl x  updated   \ to be cleared
    Ctrl f  Flushed     Ctrl l  Loading
FORTH-GESELLSCHAFT (c) 1985-2006          \ FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 3, Hexblock 3

  You are in Editormode  Screen # 3       \ FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv
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

\ simple filesystem            20oct87re  \ \\ simple file system          20oct87re

\needs (search  .( (search missing) \\    \ A FOLDER is a single connected screen
                                          \ Area, containing a Directory Screen
' word >body 2+ @ Alias (word             \ with File- and Folder-Names and
                                          \ their relative screen numbers:
0 Constant folder
                                          \ ..     -&150        .            0
' folder >body | Constant >folder         \ FILENAME  $D        FOLDERNAME &13

: root   >folder off ; folder             \ The ROOT-ORDNER is the whole Disk
                                          \ with a Diretory in Screen 0. All Screen-
  : directory ( -- addr len )             \ Numbers in ROOT are absolute.
 folder block  b/blk ;
                                          \ All Screen-Numbers must be maintained
  : (fsearch ( adr len -- n )             \ manually.
 directory (search
 0= abort" not found"                     \ When moving a complete folder, only the
 folder block -  >in push  >in !          \ Screen offsets in the Parent-Folder
 BEGIN  bl directory (word capitalize     \ needs to be adjusted
        dup c@ 0= abort" exhausted"
        number? ?dup not
 WHILE  drop  REPEAT  0< ?exit  drop ;    \ .. and . are not mandatory, but without
                                          \ then the user cannot access the parent
-->                                       \ directory

\ *** Block No. 9, Hexblock 9

\ simple Filesystem            20oct87re  \ \\ simple Filesystem           20oct87re

: split                                   \ SPLIT cuts a String at first occurance
 ( adr len char -- adr2 len2 adr1 len1 )  \  of CHAR. The first part will be stored
 >r 2dup r@ scan  r>                      \  above, the remainder below.
 over >r  skip  2swap  r> - ;             \  The Rest$ can contain CHAR again.

: read  ( -- n ) \ /path/file             \ READs Path and Filenames. Syntax:
 bl word count dup 0= abort" What?"
 pad place  pad count                     \  cd /
 BEGIN  Ascii / split                     \      Current DIR becomes ROOT-Directory
  dup IF    (fsearch                      \  cd /Sub1/
      ELSE  nip root    THEN  over        \             DIR becomes SUB1 from ROOT
 WHILE  >folder +!  REPEAT                \  cd Sub2/
 -rot 2drop folder + ;                    \         DIR becomes Sub2 from current
                                          \  cd ../
: ld  read load ;      \ LoaD             \         DIR becomes parent DIR
: sh  read list ;      \ SHow             \  ld /File1
: ed  read l ;         \ EDit             \         Load File1 from root
: cd  read >folder ! ; \ Change Dir       \  ld File2
: ls  folder list ;    \ LiSt Dir         \         Load File2 from current DIR
                                          \  ld /Sub3/File3
                                          \      Load File3 in Sub3 from ROOT
                                          \  ld Sub4/File4
FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv   \      Load File4 in Sub4 from curr. DIR

\ *** Block No. 10, Hexblock a

\ help                        14oct85re)

Onlyforth

: help  ( --)                             \   HELP  !!!
 3 l                \ list Scr # 3

 cr ." Additional Help can be"
 cr ." found on the Net"
 cr ." or in a local FORTH User Group"
 cr ." FORTH-Gesellschaft"
 cr ." www.forth-ev.de" cr ;

       \ print silly text

                                          \        Hummel, Hummel - Forth, Forth






\\

FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 11, Hexblock b



























\ *** Block No. 12, Hexblock c

\ numbers                     05jul85re)  \ \ Comment to numbers          14oct85re)

decimal             \ sorry, but this
                    \ is for YOU !

: alphabetic  ( --)  &36 base ! ;         \ alphabetic - not HEX or DECIMAL
                                          \   09 follows 08, 0A follow 09
hex                 \ Ah, much better     \   next 0B etc. until 0Z, 10 follows 0Z
                                          \   then 11  ...  19, 1A, 1B, 1C, ...

\ Look at this:


31067E6.  alphabetic d.       hex         \ hex-Zahl  alphabetic display
19211D5.  alphabetic d.       hex         \ hex-Zahl  alphabetic display
   -123.  alphabetic d.       hex         \ hex-Zahl  alphabetic display


\ Try to explain !                        \ The other way is also possible
                                          \  (this is how we created the hex
                                          \   numbers of "numbers" )

\\                                        \ Do you need BINARY or OCTAL ?
                                          \  : binary  ( --)   2 base ! ;
FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv   \  : octal  ( --)   8 base ! ;

\ *** Block No. 13, Hexblock d

\ relocating the system        20oct87re  \ \\ relocating the system    bp 19 9 84 )

| : relocate-tasks  ( newUP -- )          \ up@ origin -   is stacklen
 up@ dup                                  \ r0 @ up@ -     is rstacklen
 BEGIN  1+ under @ 2dup -
 WHILE  rot drop  REPEAT  2drop ! ;       \ symbolic map of system

: relocate  ( stacklen rstacklen -- )     \ FUNKTION     TOP          BOTTOM
 swap  origin +
 2dup + b/buf + 2+  limit u>              \ disk-buffer  limit        first @
  abort" buffers?"                        \  unused area
 dup   pad  $100 +  u< abort" stack?"     \ rstack       r0 @         rp@
 over  udp @ $40 +  u< abort" rstack?"
 flush empty                              \  free area
 under  +   origin $A + !        \ r0
 dup relocate-tasks                       \ user, warm   up@ udp @ +  up@
 up@ 1+ @   origin   1+ !        \ task   \ (heap)       up@          heap
       6 -  origin  8 + ! cold ; \ s0     \ stack        s0 @         sp@

: bytes.more  ( n -- )                    \  free area
 up@ origin -  +  r0 @ up@ - relocate ;
                                          \ system       here         origin 0FE +
: buffers  ( +n -- )                      \ user, cold   origin 100 + origin
 b/buf * 2+  limit r0 @ -                 \ screen       0800         0400
 swap - bytes.more ;                      \ page 0-3     0400         0000

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

\ disassembler 6502 loadscr    06mar86re  \ \\ disassembler 6502 loadscr

Onlyforth

\needs Tools Vocabulary Tools

Tools also definitions hex

| : table    ( +n -- )                    \ +n Values will be placed inside an
 Create     0 DO                          \ Array
 bl word number drop , LOOP
 Does> ( 8b1 -- 8b2 +n )
 + count swap c@ ;

-->











\ *** Block No. 17, Hexblock 11

\ dis shortcode0               20oct87re  \ \\ dis shortcode0

base @  hex                               \ Table for the complicated even opcodes

$80 | table shortcode0
0B10 0000 0000 0341 2510 0320 0000 0332
0AC1 0000 0000 03A1 0E10 0000 0000 0362   \ Table-Solution
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

\ dis scode adrmode            20oct87re  \ \\ dis scode adrmode

| Create scode                            \ Helptable for odd Opcodes
 $23 c, $02 c, $18 c, $01 c,
 $30 c, $1e c, $12 c, $2c c,

| Create adrmode                          \ Helptable for odd Opcodes
 $81 c, $41 c, $51 c, $32 c,              \  Addressmodes
 $91 c, $a1 c, $72 c, $62 c,

| : shortcode1 ( 8b1 - 8b2 +n)            \ calculates from Opcode 8b1
 2/ dup 1 and                             \ the addressingmode 8b2
 IF  0= 0  exit  THEN                     \ and commandlength +n
 2/ dup $7 and adrmode + c@               \ for odd Opcodes
 swap 2/ 2/ 2/ $7 and scode + c@ ;

| Variable mode

| Variable length

-->





\ *** Block No. 19, Hexblock 13

\ dis shortcode texttab        06mar86re  \ \\ dis shortcode texttab

| : shortcode ( 8b1 -- +n )               \ calulates Commandlength (length)
 dup 1 and         ( odd codes)           \ and Addressingmode (mode)
 IF  dup $89 =                            \ from Opcode (8b1)
  IF  drop 2  THEN  shortcode1
 ELSE  shortcode0  ( evend codes)
 THEN
 swap dup 3 and length !
 2/ 2/ 2/ 2/ mode ! ;

| : texttab   ( char +n 8b -- )           \ defining word for Text-Tables
 Create
 dup c, swap 0 DO >r dup word             \ Datastructure:
 1+ here r@ cmove r@ allot r>
 LOOP 2drop                               \ count text1 text2 ... text+n-1 text+n
 Does>  ( +n -- )
 count >r swap r@ * + r> type ;

-->






\ *** Block No. 20, Hexblock 14

\ dis text-table               06mar86re  \ \\ text-tabellen

bl $39 3 | texttab .mnemonic              \ the Mnemonic-Table
*by adc and asl bcc bcs beq bit bmi bne
bpl brk bvc bvs clc cld cli clv cmp cpx
cpy dec dex dey eor inc inx iny jmp jsr
lda ldx ldy lsr nop ora pha php pla plp
rol ror rti rts sbc sec sed sei sta stx
sty tax tay tsx txa txs tya
( +n -- )

Ascii / $E 1 | texttab .before            \ the BEFORE Table
   / /a/ /z/#/ / /(/(/z/z/ /(/


Ascii / $E 3 | texttab .after             \ the AFTER Table
     /   /   /   /   /   /,x
 /,y /,x)/),y/,x /,y /   /)  /

-->






\ *** Block No. 21, Hexblock 15

\ dis 2u.r 4u.r                06mar86re  \ \\ dis 4u.r 2u.r

: 4u.r ( u -)                             \ 4u.r print address with leading zeros
  0 <# # # # # #> type ;

: 2u.r ( u -)                             \ 2u.r prints byte with leading zeros
  0 <# # # #> type ;

-->

















\ *** Block No. 22, Hexblock 16

\ dis                          20oct87re  \ \\ dis shadow

Forth definitions                         \ "dis" is an ugly word. Better
                                          \ names for this word are welcome
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

\ savesystem                   23oct87re  \ \\ savesystem shadow          clv04aug87

| : (savsys ( adr len -- )
 [ Assembler ] Next  [ Forth ]            \ Usage: SAVESYSTEM name
 ['] pause  dup push  !  \ singletask     \ Example: SAVESYSTEM MY-FORTH
 i/o push  i/o off  bustype ;             \         --creates a loadable File
                                          \         --with Name MEIN-FORTH.
: savesystem   \ name must follow
    \ prepare Forth Kernal                \   A complex program can contain it own
 scr push  1 scr !  r# push  r# off       \   SAVESYSTEM buildng on top of the
    \ prepare Editor                      \   generic one, preparing it's own
 [ Editor ]                               \   Datastructures for later loading.
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

\ bamallocate, formatdisk      20oct87re  \ Comment for  bamallocate, formatdisk

: bamallocate ( --)                       \ Creates Entry "0 blocks free"
 diskopen ?exit                           \  open Disk
 pad &18 0 readsector 0=                  \  read BAM
  IF pad 4 + $8C erase                    \   IF clear BAM (almost)
     pad &18 0 writesector drop           \      writes back BAM
  THEN  diskclose                         \   THEN  closes disk
 8 &15 busout " i0" count bustype         \  initialize again
 busoff ;                                 \  and finish!

: formatdisk ( --)  \ name must follow    \ CLEAR   (formatted) Disk
 8 &15 busout " n0:" count bustype        \  send clear command
 0 parse bustype busoff                   \  send name
 derror? ?exit                            \   sucessfull?
 bamallocate ;                            \  pretent the disk is full

\ example: formatdisk volksFORTH,id






FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv

\ *** Block No. 28, Hexblock 1c

\ copydisk                    06jun85we)  \ ???

| Variable distance                       \   This page unintentionaly left blank.

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

: copydisk  ( blk1 blk2] [to.blk --)      \ copies no dictionary. cannot be used
 2 pick - distance !  1+ over -           \ for Files, only for FORTH Screens
 dup 0> not Abort" RANGE ERROR!"
 bufs /mod ?dup
 IF swap >r 0
    DO dup bufs backupbufs bufs +  LOOP
    r> THEN
 ?dup IF backupbufs ELSE drop THEN ;


\ *** Block No. 29, Hexblock 1d

\ 2disk copy2disk..           clv14jul87  \ \\ zu:2disk copy2disk..       clv04aug87


$165 | Constant 1.t                       \ this calculates the cunmber
$1EA | Constant 2.t                       \ [0..&682] out of track and sector
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

\ ..2disk copy2disk           clv04aug87  \ \\ zu:..2disk copy2disk       clv04aug87


| : ?e ( flag--)                          \ Checks for Disk error
  ?dup IF ." Drv " (drv @ . diskclose
          abort" " THEN ;

| : op ( drv#--) (drv ! diskopen ?e ;     \ Abbreviation for OPen. 40 Chars are too

: copysector \ adr sec# --                \ copies a secotr (using adr)
  2dup
  0 op s#>t+s readsector  ?e diskclose
  1 op s#>t+s writesector ?e diskclose ;

: copy2disk \ -- \ for 2 Floppys
 pad dup $110 + sp@ u> abort" no room"    \  Check if there is Space at PAD
 cr ." Source=0, Dest=1" key drop cr      \  Status messages
 base push decimal      0 &682
 DO I . I s#>t+s . . cr $91 con!          \  Loops over allsectors
    dup I copysector   -1 +LOOP drop ;    \  prints out some numbers

: 2disk1551 \ -- switch 1551 to #9
 flush 8 &15 busopen " %9" count bustype  \  switches only(!!) 1551-Floppys.
 busoff derror? drop ;                    \  For 1541 its too complicated.


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


























