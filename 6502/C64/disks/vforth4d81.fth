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
                                         
                                         
                                         
                                         
                                         
\ dis 2u.r 4u.r                06mar86re 
                                         
: 4u.r ( u -)                            
  0 <# # # # # #> type ;                 
                                         
: 2u.r ( u -)                            
  0 <# # # #> type ;                     
                                         
-->                                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
\\ Subdirectory test.dir       26oct87re 
                                         
.                    0                   
..                -&23                   
all-words            1                   
free                 2                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ savesystem         23oct87re 03mar26dk 
                                         
| : (savsys ( adr len -- )               
 [ Assembler ] Next  [ Forth ]           
 ['] pause  dup push  !  \ singletask    
 ( i/o push  i/o off)  14 cbmtype ;      
                                         
: savesystem   \ name must follow        
    \ prepare Forth Kernal               
 scr push  1 scr !  r# push  r# off      
    \ prepare Editor                     
\ [ Editor ]                             
 \ stamp$ dup push off                   
 \ (pad   dup push off                   
    \ now we save the system             
 save                                    
 0 parse dup >r pad swap move            
 " ,p,w" count pad r@ + swap move        
 14 8 14  pad r> 4 + cbmopen             
 origin $17 - dup sp@ 2 14 cbmtype       
 here over - (savsys  14 cbmclose        
 0 (drv ! false abort" save-error" ;     
                                         
Onlyforth                                
                                         
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
                                         
\ nothing special here                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
FORTH-GESELLSCHAFT  (c) bp/ks/re/we/clv  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
                                         
  HELP  !!!                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
       Hummel, Hummel - Forth, Forth     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ disassembler 6502 loadscr             
                                         
                                         
                                         
                                         
                                         
                                         
                                         
+n Values will be placed inside an       
Array                                    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ dis shortcode0                        
                                         
Table for the complicated even opcodes   
                                         
                                         
                                         
Table-Solution                           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ dis scode adrmode                     
                                         
Helptable for odd Opcodes                
                                         
                                         
                                         
Helptable for odd Opcodes                
 Addressmodes                            
                                         
                                         
calculates from Opcode 8b1               
the addressingmode 8b2                   
and commandlength +n                     
for odd Opcodes                          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ dis shortcode texttab                 
                                         
calulates Commandlength (length)         
and Addressingmode (mode)                
from Opcode (8b1)                        
                                         
                                         
                                         
                                         
                                         
                                         
defining word for Text-Tables            
                                         
Datastructure:                           
                                         
count text1 text2 ... text+n-1 text+n    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ text-tabellen                         
                                         
the Mnemonic-Table                       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
the BEFORE Table                         
                                         
                                         
                                         
the AFTER Table                          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ dis 4u.r 2u.r                         
                                         
4u.r print address with leading zeros    
                                         
                                         
2u.r prints byte with leading zeros      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ dis shadow                            
                                         
"dis" is an ugly word. Better            
names for this word are welcome          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ savesystem shadow          clv04aug87 
                                         
                                         
Usage: SAVESYSTEM name                   
Example: SAVESYSTEM MY-FORTH             
        --creates a loadable File        
        --with Name MEIN-FORTH.          
                                         
  A complex program can contain it own   
  SAVESYSTEM buildng on top of the       
  generic one, preparing it's own        
  Datastructures for later loading.      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
???                                      
                                         
  This page unintentionaly left blank.   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
copies no dictionary. cannot be used     
for Files, only for FORTH Screens        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ zu:2disk copy2disk..       clv04aug87 
                                         
                                         
this calculates the cunmber              
[0..&682] out of track and sector        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ Directory volksFORTH 2of4   26oct87re 
                                         
.                    0                   
..                   0                   
misc               $08                   
C64/C16            $09                   
System             $0F                   
C64interface       $7d                   
C16init            $94                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ Content volksFORTH 2of4     26oct87re 
                                         
Directory            0                   
Content              1                   
misc               $08                   
C64 or  C16        $09                   
System             $0F                   
C64/C16interface   $7d                   
                   $95-a9 free           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ram rom jsr NormJsr f.C16+ clv12.4.87) 
                                         
                                         
Assembler also definitions               
                                         
(c16+ \ C16+Macros for Bankswitching     
                                         
: ram $ff3f sta ;   : rom $ff3e sta ;    
                                         
' Jsr Alias NormJsr   Defer Jsr          
                                         
: C16+Jsr dup $c000 u>                   
 IF rom NormJsr ram ELSE NormJsr THEN ;  
                                         
' C16+Jsr Is Jsr                         
)                                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Target-Machine              clv06dec88 
                                         
Onlyforth                                
                                         
                                         
cr .( Host is: )                         
    (64  .( C64) C)                      
    (16  .( C16) C)                      
                                         
       : )     ; immediate               
       : (C    ; immediate               
                                         
       : (C64  ; immediate               
\      : (C16  ; immediate               
\      : (C16+ ; immediate               
\      : (C16- ; immediate               
                                         
\      : (C64  [compile] ( ; immediate   
       : (C16  [compile] ( ; immediate   
       : (C16+ [compile] ( ; immediate   
       : (C16- [compile] ( ; immediate   
                                         
                                         
                                         
                                         
\ load/remove  JSR-Macros    clv14.4.87) 
                                         
Assembler also definitions               
                                         
(C16+ \needs C16+Jsr          -2 +load ) 
(C16+ ' C16+Jsr Is Jsr .( JSR Is:C16+  ) 
(C16+ \\ skips rest of screen            
                                         
\ all other platforms don't need         
\ macros, so we skip the rest:           
\                                        
                                         
\needs C16+Jsr \\                        
                                         
\ if macro exist, redefine it:           
                                         
' NormJsr Is Jsr .( JSR Is:Norm )        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
cr .( Target is: ) \         clv14.4.87) 
                                         
                                         
(C    .( CBM )                           
(C64  .( C64 )                           
(C16  .( C16 with )                      
(C16+ .( 64kb )                          
(C16- .( 32kb )                          
                                         
cr .( Target is not: )                   
                                         
(C    \ )      .( CBM, )                 
(C64  \ )      .( C64, )                 
(C16  \ )      .( C16, )                 
(C16+ \ )      .( C16+64kb, )            
(C16- \ )      .( C16-32kb, )            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ramfill                             3: 
                                         
Onlyforth                                
                                         
Code ramfill   ( adr n 8b -)             
 sei  34 # lda  1 sta                    
 3 # lda setup jsr                       
 N 3 + ldx txa  N 2+ ora 0<>             
  ?[ N lda 0 # ldy                       
    [[ 0 # cpx 0<>                       
      ?[[ [[ N 4 + )Y sta iny 0= ?]      
          N 5 + inc dex ]]?              
   N 2+ ldx 0<> ?[                       
   [[ N 4 + )Y sta iny N 2+ cpy CS ?] ]? 
  ]?                                     
 36 # lda  1 sta cli                     
 0 # ldx 1 # ldy Next jmp                
end-code                                 
                                         
$C000 $4000 (16 $300 - C)  0 ramfill     
                                         
forget ramfill                           
                                         
                                         
                                         
( Deleting Assembler Labels bp27jun85we) 
                                         
: delete   Assembler name find           
 IF  >name count $1F and                 
   bounds ?DO $1F I c! LOOP              
 ELSE  count type space THEN ;           
                                         
delete setup     delete xyNext           
delete Puta      delete SP               
delete Pop       delete Next             
delete N         delete UP               
delete Poptwo    delete W                
delete IP        delete RP               
delete Push      delete Push0A           
delete PushA     delete ;c:              
                                         
forget delete Onlyforth                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( Definition for  .status     28jun85we) 
                                         
: status                                 
 blk @ ?dup IF                           
  ."  blk " u.                           
  ." here "  here u.                     
  ." there " there u.                    
  ." heap "  heap u.  cr                 
  THEN ;                                 
                                         
' status is .status                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ C64    Forth loadscreen     clv14oct87 
                                         
Onlyforth hex                            
  -3    +load   \ clear memory and       
  -2 -1 +thru   \ clr labels  .status    
  -6 -4 +thru   \ Target-Machine         
Onlyforth                                
                                         
(C64 $801 ) (C16 $1001 ) dup displace !  
                                         
Target definitions   here!               
                                         
$1 $6E +thru                             
                                         
Assembler nonrelocate                    
                                         
.unresolved                              
                                         
' .blk is .status                        
                                         
    -4 +load    \ Print Target-Machine   
                                         
cr .( save-target volksforth83)          
91 con! ( Cursor up) quit                
                                         
\ FORTH Preamble and ID       clv06aug87 
                                         
(C64  $D c, $8 c, $A c, 00 c, 9E c,      
28 c, 32 c, 30 c, 36 c, 34 c, 29 c,      
00 c, 00 c, 00 c, 00 c, ) \ SYS(2064)    
(C16  $D c, 10 c, $A c, 00 c, 9E c,      
28 c, 34 c, 31 c, 31 c, 32 c, 29 c,      
00 c, 00 c, 00 c, 00 c, ) \ SYS(4112)    
                                         
Assembler                                
  nop  0 jmp  here 2- >label >cold       
  nop  0 jmp  here 2- >label >restart    
                                         
here dup origin!                         
\ Here are coldstart- and Uservariables  
\                                        
0 jmp  0 jsr  here 2- >label >wake       
 end-code                                
$100 allot                               
                                         
Create logo                              
 (C64  ," volksFORTH-83 3.80.1-C64  " )  
 (C16+ ," volksFORTH-83 3.80.1-C16+ " )  
 (C16- ," volksFORTH-83 3.80.1-C16- " )  
                                         
( Zero page Variables & Next  03apr85bp) 
                                         
02 dup     >label RP     2+              
   dup     >label UP     2+              
                                         
   dup     >label Puta   1+              
   dup     >label SP     2+              
   dup     >label Next                   
   dup 5 + >label IP                     
      13 + >label W                      
                                         
     W 8 + >label N                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( Next, moved into Zero page  08apr85bp) 
                                         
Label Bootnext                           
   -1 sta              \ -1 is dummy SP  
   IP )Y lda  W 1+  sta                  
   -1 lda     W sta    \ -1 is dummy IP  
   clc IP lda  2 # adc  IP sta           
     CS not ?[ Label Wjmp -1 ) jmp ]?    
   IP 1+ inc  Wjmp bcs                   
end-code                                 
                                         
here Bootnext - >label Bootnextlen       
                                         
Code end-trace  ( Patch Next for trace ) 
 $A5 # lda  Next $A + sta                
  IP # lda  Next $B + sta                
 $69 # lda  Next $C + sta                
   2 # lda  Next $D + sta                
 Next jmp   end-code                     
                                         
                                         
                                         
                                         
                                         
                                         
\ ;c:  noop                    02nov87re 
                                         
Create recover  ( -- adr )   Assembler   
 pla  W sta  pla  W 1+ sta               
 W wdec  0 jmp   end-code                
                                         
here 2- >label >recover                  
\ handcrafted forward reference for      
\ jmp command                            
                                         
Compiler Assembler also definitions      
 H : ;c:   0 T recover jsr               
 end-code  ] H ;                         
Target                                   
                                         
Code noop   Next here 2- !  end-code     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ User variables              clv14oct87 
                                         
Constant origin  8 uallot drop           
                 \ For multitasker       
                                         
User s0       $7CFA s0 !                 
User r0       $7FFE r0 !                 
User dp                                  
User offset      0 offset !              
User base      &10 base !                
User output                              
User input                               
User errorhandler                        
     \ pointer for  Abort" -code         
User voc-link                            
User udp                                 
     \ points to next free addr in User  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( manipulate system pointers  29jan85bp) 
                                         
Code sp@   ( -- addr)                    
 SP lda  N sta  SP 1+ lda  N 1+ sta      
 N # ldx                                 
Label Xpush                              
 SP 2dec  1 ,X lda  SP )Y sta            
 0 ,X lda  0 # ldx  Puta jmp   end-code  
                                         
Code sp!   ( addr --)                    
 SP X) lda  tax  SP )Y lda               
 SP 1+ sta  SP stx   0 # ldx             
 Next jmp   end-code                     
                                         
Code up@   ( -- addr)                    
 UP # ldx  Xpush jmp  end-code           
                                         
Code up!   ( addr --)      UP # ldx      
Label Xpull     SP )Y lda  1 ,X sta      
            dey SP )Y lda  0 ,X sta      
Label (xydrop   0 # ldx  1 # ldy         
Label (drop     SP 2inc  Next jmp        
end-code restrict                        
                                         
                                         
( manipulate returnstack   16feb85bp/ks) 
                                         
Code rp@ ( -- addr )                     
 RP # ldx  Xpush jmp  end-code           
                                         
Code rp! ( addr -- )                     
 RP # ldx  Xpull jmp  end-code restrict  
                                         
Code >r  ( 16b --  )                     
 RP 2dec  SP X) lda   RP X) sta          
 SP )Y lda   RP )Y sta (drop jmp         
end-code restrict                        
                                         
Code r>  ( -- 16b)                       
 SP 2dec  RP X) lda  SP X) sta           
          RP )Y lda  SP )Y sta           
Label (rdrop     2 # lda                 
Label (nrdrop    clc  RP adc  RP sta     
    CS ?[  RP 1+ inc  ]?                 
 Next jmp  end-code  restrict            
                                         
                                         
                                         
                                         
                                         
\ r@ rdrop  exit  ?exit       clv12jul87 
                                         
Code r@      ( -- 16b)                   
 SP 2dec  RP )Y lda  SP )Y sta           
          RP X) lda  Puta jmp            
end-code                                 
                                         
Code rdrop    (rdrop here 2- !           
end-code   restrict                      
                                         
Code exit                                
 RP X) lda  IP sta                       
 RP )Y lda  IP 1+ sta                    
 (rdrop jmp   end-code                   
Code unnest                              
 RP X) lda  IP sta                       
 RP )Y lda  IP 1+ sta                    
 (rdrop jmp   end-code                   
                                         
Code ?exit     ( flag -- )               
 SP X) lda  SP )Y ora                    
 php  SP 2inc  plp                       
 ' exit @ bne  Next jmp                  
end-code                                 
                                         
( execute  perform            08apr85bp) 
                                         
Code execute  ( addr --)                 
 SP X) lda   W sta                       
 SP )Y lda   W 1+ sta                    
 SP 2inc     W 1- jmp   end-code         
                                         
: perform ( addr -- )   @ execute ;      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( c@   c! ctoggle             10jan85bp) 
                                         
Code c@ ( addr -- 8b)                    
 SP X) lda  N sta   SP )Y lda  N 1+ sta  
Label (c@    0 # lda  SP )Y sta          
 N X)  lda   Puta jmp   end-code         
                                         
Code c!  ( 16b addr --)                  
 SP X) lda   N sta   SP )Y lda  N 1+ sta 
 iny  SP )Y lda  N X) sta dey            
Label (2drop                             
 SP lda  clc  4 # adc  SP sta            
   CS ?[  SP 1+ inc  ]?                  
 Next jmp   end-code                     
                                         
: ctoggle   ( 8b addr --)                
 under c@ xor swap c! ;                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( @ ! +!                      08apr85bp) 
                                         
Code @  ( addr -- 16b)                   
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 N )Y lda  SP )Y sta                     
 N X) lda Puta jmp   end-code            
                                         
Code !   ( 16b addr --)                  
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 iny SP )Y lda  N X) sta                 
 iny SP )Y lda   1 # ldy                 
Label (!                                 
 N )Y sta  (2drop jmp   end-code         
                                         
Code +!  ( n addr --)                    
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 iny  SP )Y lda  clc  N X) adc N X) sta  
 iny  SP )Y lda  1 # ldy  N )Y adc       
 (! jmp   end-code                       
                                         
                                         
                                         
                                         
                                         
                                         
( drop swap                   24may84ks) 
                                         
Code drop  ( 16b --)                     
 (drop here 2- !  end-code               
                                         
Code swap  ( 16b1 16b2 -- 16b2 16b1 )    
 SP )Y lda  tax                          
 3 # ldy  SP )Y lda  N sta               
 txa  SP )Y sta                          
 N lda  1 # ldy  SP )Y sta               
 iny  0 # ldx                            
 SP )Y lda  N sta  SP X) lda  SP )Y sta  
 dey                                     
 N lda Puta jmp   end-code               
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( dup  ?dup                   08may85bp) 
                                         
Code dup   ( 16b -- 16b 16b)             
 SP 2dec                                 
 3 # ldy  SP )Y lda  1 # ldy  SP )Y sta  
 iny  SP )Y lda  dey                     
 Puta jmp   end-code                     
                                         
Code ?dup     ( 16b -- 16b 16b / false)  
 SP X) lda  SP )Y ora                    
   0= ?[  Next jmp  ]?                   
 ' dup @ jmp end-code                    
                                         
                                         
\\ : ?dup   ( 16b -- 16b 16b / false)    
    dup  IF  dup  THEN ;                 
                                         
   : dup    Sp@  @  ;                    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( over rot                    13jun84ks) 
                                         
Code over  ( 16b1 16b2 - 16b1 16b3 16b1) 
                                         
 SP 2dec  4 # ldy  SP )Y lda  SP X) sta  
 iny  SP )Y lda  1 # ldy  SP )Y sta      
 Next jmp   end-code                     
                                         
Code rot                                 
    ( 16b1 16b2 16b3 -- 16b2 16b3 16b1)  
 3 # ldy  SP )Y lda  N 1+ sta            
 1 # ldy  SP )Y lda  3 # ldy  SP )Y sta  
 5 # ldy  SP )Y lda  N sta               
 N 1+ lda  SP )Y sta                     
 1 # ldy  N lda  SP )Y sta               
 iny  SP )Y lda  N 1+ sta                
 SP X) lda  SP )Y sta                    
 4 # ldy  SP )Y lda  SP X) sta           
 N 1+ lda  SP )Y sta                     
 1 # ldy  Next jmp   end-code            
                                         
\\ : rot   >r swap r> swap ;             
   : over  >r dup r> swap ;              
                                         
                                         
( -rot nip under pick roll    24dec83ks) 
                                         
: -rot                                   
    ( 16b1 16b2 16b3 -- 16b3 16b1 16b2)  
 rot rot ;                               
                                         
: nip   ( 16b1 16b2 -- 16b2)             
 swap drop ;                             
                                         
: under ( 16b1 16b2 -- 16b2 16b1 16b2)   
 swap over ;                             
                                         
: pick  ( n -- 16b.n )   1+ 2* sp@ + @ ; 
                                         
: roll  ( n --)                          
 dup >r pick sp@ dup 2+ r> 1+ 2* cmove>  
 drop ;                                  
                                         
\\ : -roll ( n --)                       
 >r dup sp@  dup 2+ dup 2+ swap          
 r@ 2* cmove r> 1+ 2* + ! ;              
                                         
                                         
                                         
                                         
( double word stack manip.    21apr83ks) 
                                         
: 2swap ( 32b1 32b2 -- 32b2 32b1)        
 rot >r rot r> ;                         
                                         
Code 2drop ( 32b -- )                    
 (2drop here 2- !   end-code             
                                         
\  : 2drop ( 32b -- )    drop drop ;     
                                         
: 2dup  ( 32b -- 32b 32b)                
 over over ;                             
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( + and or xor                08apr85bp) 
                                         
Compiler  Assembler also definitions     
                                         
H : Dyadop ( opcode --)  T               
   iny  SP X) lda  dup c, SP c,          
   SP )Y sta                             
   dey  SP )Y lda  3 # ldy  c, SP c,     
   SP )Y sta                             
   (xydrop jmp  H ;                      
                                         
Target                                   
                                         
Code +     ( n1 n2 -- n3)                
 clc $71 Dyadop   end-code               
                                         
Code or    ( 16b1 16b2 -- 16b3)          
     $11 Dyadop   end-code               
                                         
Code and   ( 16b1 16b2 -- 16b3)          
     $31 Dyadop   end-code               
                                         
Code xor   ( 16b1 16b2 -- 16b3)          
     $51 Dyadop   end-code               
                                         
( -  not  negate              24dec83ks) 
                                         
Code -    ( n1 n2 -- n3)                 
 iny SP )Y lda  sec SP X) sbc SP )Y sta  
 iny SP )Y lda                           
 1 # ldy  SP )Y sbc  3 # ldy  SP )Y sta  
 (xydrop jmp   end-code                  
                                         
Code not   ( 16b1 -- 16b2)   clc         
Label (not                               
 txa  SP X) sbc  SP X) sta  txa          
      SP )Y sbc  SP )Y sta               
 Next jmp   end-code                     
                                         
Code negate   ( n1 -- n2 )               
 sec  (not bcs   end-code                
                                         
\ : -       negate + ;                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( dnegate setup d+            14jun84ks) 
                                         
Code dnegate ( d1 -- -d1)                
 iny  sec                                
 txa  SP )Y sbc  SP )Y sta  iny          
 txa  SP )Y sbc  SP )Y sta               
 txa  SP X) sbc  SP X) sta  1 # ldy      
 txa  SP )Y sbc  SP )Y sta               
 Next jmp  end-code                      
                                         
Label Setup  ( quan  in A)               
 .A asl tax tay  dey                     
    [[ SP )Y lda  N ,Y sta  dey  0< ?]   
 txa  clc  SP adc  SP sta                
    CS ?[  SP 1+ inc  ]?                 
 0 # ldx  1 # ldy   rts   end-code       
                                         
Code d+      ( d1 d2 -- d3)              
 2 # lda  Setup jsr  iny                 
 SP )Y lda  clc N 2+  adc SP )Y sta iny  
 SP )Y lda      N 3 + adc SP )Y sta      
 SP X) lda  N    adc SP X) sta  1 # ldy  
 SP )Y lda  N 1+ adc SP )Y sta           
 Next jmp   end-code                     
                                         
( 1+ 2+ 3+    1- 2-           08apr85bp) 
                                         
Code 1+   ( n1 -- n2)   1 # lda          
Label n+  clc  SP X) adc                 
 CS not   ?[  Puta jmp  ]?               
 SP X) sta  SP )Y lda  0 # adc SP )Y sta 
 Next jmp  end-code                      
                                         
Code 2+   ( n1 -- n2)                    
 2 # lda   n+ bne     end-code           
Code 3+   ( n1 -- n2)                    
 3 # lda   n+ bne     end-code           
| Code 4+ ( n1 -- n2)                    
 4 # lda   n+ bne     end-code           
| Code 6+ ( n1 -- n2)                    
 6 # lda   n+ bne     end-code           
                                         
Code 1-   ( n1 -- n2)   sec              
Label (1-     SP X) lda  1 # sbc         
   CS ?[ Puta jmp ]?                     
 SP X) sta  SP )Y lda  0 # sbc SP )Y sta 
 Next jmp  end-code                      
                                         
Code 2-   ( n1 -- n2)                    
 clc (1- bcc  end-code                   
( number Constants            24dec83ks) 
                                         
-1 Constant true    0 Constant false     
                                         
' true Alias -1     ' false Alias 0      
                                         
1 Constant 1        2 Constant 2         
3 Constant 3        4 Constant 4         
                                         
: on    ( addr -- )  true  swap ! ;      
: off   ( addr -- )  false swap ! ;      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( words for number literals   24may84ks) 
                                         
Code clit  ( -- 8b)                      
 SP 2dec  IP X) lda  SP X) sta           
  txa   SP )Y sta  IP winc               
 Next jmp   end-code restrict            
                                         
Code lit   ( -- 16b)                     
 SP 2dec  IP )Y lda  SP )Y sta           
          IP X) lda  SP X) sta           
Label (bump   IP 2inc                    
 Next jmp  end-code restrict             
                                         
: Literal   ( 16b --)                    
 dup $FF00 and                           
   IF  compile lit   , exit THEN         
       compile clit c,  ;                
immediate restrict                       
                                         
                                         
\\ : lit     r> dup 2+ >r  @  ;          
   : clit    r> dup 1+ >r  c@ ;          
                                         
                                         
                                         
( comparision code words      13jun84ks) 
                                         
Code 0<   ( n -- flag)                   
 SP )Y lda  0< ?[                        
Label putTrue    $FF # lda  $24 c, ]?    
Label putFalse   txa  SP )Y sta          
 Puta jmp   end-code                     
                                         
Code 0=   ( 16b -- flag)                 
 SP X) lda  SP )Y ora                    
 putTrue  beq                            
 putFalse bne  end-code                  
                                         
Code uwithin  ( u1 [low up[  -- flag)    
 2 # lda  Setup jsr                      
 1 # ldy  SP X) lda  N cmp               
          SP )Y lda  N 1+ sbc            
  CS not ?[ ( N>SP) SP X) lda N 2+  cmp  
                    SP )Y lda N 3 + sbc  
           putTrue bcs ]?                
 putFalse jmp  end-code                  
                                         
                                         
                                         
                                         
( comparision code words      13jun84ks) 
                                         
Code <    ( n1 n2 -- flag)               
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 SP 2inc                                 
 N 1+ lda  SP )Y eor  ' 0< @  bmi        
 SP X) lda  N cmp  SP )Y lda  N 1+ sbc   
 ' 0< @ 2+ jmp    end-code               
                                         
Code u<   ( u1 u2 -- flag)               
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 SP 2inc                                 
 SP X) lda  N cmp  SP )Y lda  N 1+ sbc   
   CS not ?[  putTrue jmp  ]?            
              putFalse jmp  end-code     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( comparision words           24dec83ks) 
                                         
\ : 0<   $8000 and  0<> ;                
                                         
: >   ( n1 n2 -- flag)  swap < ;         
                                         
: 0>  ( n --     flag)  negate 0<  ;     
                                         
: 0<> ( n --     flag)  0= not ;         
                                         
: u>  ( u1 u2 -- flag)  swap u< ;        
                                         
: =   ( n1 n2 -- flag)  - 0= ;           
                                         
: d0= ( d --     flag)  or 0= ;          
                                         
: d=  ( d1 d2 -- flag)  dnegate d+ d0= ; 
                                         
: d<  ( d1 d2 -- flag)  rot 2dup -       
 IF > nip nip  ELSE 2drop u< THEN ;      
                                         
                                         
                                         
                                         
                                         
( min max umax umin extend dabs abs  ks) 
                                         
| : minimax  ( n1 n2 flag -- n3)         
   rdrop  IF swap THEN drop ;            
                                         
: min   ( n1 n2 -- n3)                   
 2dup  > minimax ;                       
                                         
: max   ( n1 n2 -- n3)                   
 2dup  < minimax ;                       
                                         
: umax  ( u1 u2 -- u3)                   
 2dup u< minimax ;                       
                                         
: umin  ( u1 u2 -- u3)                   
 2dup u> minimax ;                       
                                         
                                         
: extend  ( n -- d)     dup 0< ;         
                                         
: dabs    ( d -- ud)                     
 extend IF  dnegate THEN ;               
                                         
: abs     ( n -- u)                      
 extend IF   negate THEN ;               
\ loop primitives              02nov87re 
                                         
| : dodo                                 
 rdrop r> 2+ dup >r rot >r swap >r >r ;  
                                         
: (do  ( limit star -- )                 
 over - dodo ;      restrict             
                                         
: (?do ( limit start -- )                
 over - ?dup  IF dodo THEN               
 r> dup @ +  >r drop ;       restrict    
                                         
: bounds  ( start count -- limit start ) 
 over + swap ;                           
                                         
Code endloop  ( -- )                     
 6 # lda (nrdrop jmp   end-code restrict 
                                         
\\ dodo puts  "index | limit |           
 adr.of.DO"  on return-stack             
                                         
                                         
                                         
                                         
                                         
\ (loop (+loop                 02nov87re 
                                         
Code (loop                               
 clc  1 # lda  RP X) adc RP X) sta       
   CS ?[  RP )Y lda  0 # adc RP )Y sta   
      CS ?[ Next jmp ]? ]?               
Label doloop  5 # ldy                    
 RP )Y lda  IP 1+ sta  dey               
 RP )Y lda  IP    sta  1 # ldy           
 Next jmp    end-code restrict           
                                         
Code (+loop  ( n -- )                    
 clc SP X) lda  RP X) adc  RP X) sta     
     SP )Y lda  RP )Y adc  RP )Y sta     
 .A ror  SP )Y eor                       
 php  SP 2inc  plp doloop bpl            
 Next jmp    end-code restrict           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( loop indices                08apr85bp) 
                                         
Code I  ( -- n)    0 # ldy               
Label loopindex    SP 2dec   clc         
 RP )Y lda  iny  iny                     
 RP )Y adc  SP X) sta  dey               
 RP )Y lda  iny  iny                     
 RP )Y adc  1 # ldy  SP )Y sta           
 Next jmp   end-code restrict            
                                         
Code J  ( -- n)                          
 6 # ldy  loopindex bne                  
            end-code  restrict           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ branching                    02nov87re 
                                         
Code branch                              
 clc  IP    lda  IP X) adc  N sta        
      IP 1+ lda  IP )Y adc  IP 1+ sta    
 N lda IP sta                            
 Next jmp     end-code restrict          
                                         
Code ?branch  ( flag -- )                
 SP X) lda  SP )Y ora                    
 php  SP 2inc  plp                       
 ' branch @ beq    (bump jmp             
end-code   restrict                      
                                         
                                         
                                         
\\  : branch   r> dup @ + >r ; restrict  
                                         
    : ?branch  ( flag -- )               
     0= r> over not over 2+  and -rot    
     dup @ + and or >r ;       restrict  
                                         
                                         
                                         
                                         
( resolve loops and branches  03feb85bp) 
                                         
: >mark     ( -- addr)  here   0 , ;     
                                         
: >resolve  ( addr --)                   
 here over -   swap !  ;                 
                                         
: <mark     ( -- addr)  here ;           
                                         
: <resolve  ( addr --) here - ,  ;       
                                         
: ?pairs  ( n1 n2 -- )                   
 -  Abort" unstructured" ;               
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( case?                       04may85bp) 
                                         
Label  PushA                             
 0 # cmp  0< ?[ pha  $FF # lda ][        
Label  Push0A   pha   0  # lda  ]?       
Label  Push     tax   SP 2dec            
 txa  1 # ldy  SP )Y sta                 
 pla  0 # ldx   Puta jmp                 
                                         
Code case?                               
 ( 16b1 16b2 -- 16b1 false / true )      
 1 # lda  Setup jsr                      
 N lda  SP X) cmp                        
  0= ?[   N 1+ lda  SP )Y cmp            
    0= ?[ putTrue jmp ]?  ]?             
 txa  Push0A jmp   end-code              
                                         
                                         
                                         
\\ : case?                               
 ( 16b1 16b2 -- 16b1 false / true )      
 over = dup  IF  nip  THEN ;             
                                         
                                         
                                         
( Branching                   03feb85bp) 
                                         
: IF     compile ?branch >mark  1 ;      
         immediate restrict              
                                         
: THEN   abs 1   ?pairs  >resolve ;      
         immediate restrict              
                                         
: ELSE   1 ?pairs  compile branch >mark  
         swap >resolve  -1 ;             
         immediate restrict              
                                         
: BEGIN  <mark 2 ; immediate restrict    
                                         
: WHILE  2 ?pairs  2   compile ?branch   
         >mark -2  2swap  ;              
         immediate restrict              
                                         
| : (reptil   <resolve   BEGIN dup -2    
    = WHILE  drop >resolve  REPEAT  ;    
                                         
: REPEAT 2 ?pairs  compile branch        
         (reptil ; immediate restrict    
: UNTIL  2 ?pairs  compile ?branch       
         (reptil ; immediate restrict    
( Loops                    29jan85ks/bp) 
                                         
: DO     compile (do  >mark  3 ;         
         immediate restrict              
                                         
: ?DO    compile (?do >mark  3 ;         
         immediate restrict              
                                         
: LOOP   3 ?pairs  compile (loop         
         compile endloop  >resolve ;     
         immediate restrict              
                                         
: +LOOP  3 ?pairs  compile (+loop        
         compile endloop  >resolve ;     
         immediate restrict              
                                         
: LEAVE  endloop r> 2- dup @ + >r ;      
         restrict                        
                                         
\\ Returnstack: calladr | index          
                  limit | adr of DO      
                                         
                                         
                                         
                                         
( um*                      bp/ks13.2.85) 
                                         
Code um*  ( u1 u2 -- ud)                 
 SP )Y lda N sta  SP X) lda  N 1+ sta    
 iny N 2 + stx N 3 + stx  $10 # ldx      
  [[ N 3 + asl N 2+ rol N 1+ rol N rol   
   CS ?[ clc                             
         SP )Y lda  N 3 + adc  N 3 + sta 
         iny  SP )Y lda dey              
         N 2 + adc   N 2 + sta           
           CS ?[  N 1+ inc               
              0= ?[  N   inc  ]? ]? ]?   
    dex  0= ?]                           
 N 3 + lda   SP )Y sta   iny             
 N 2 + lda   SP )Y sta   1 # ldy         
 N     lda   SP )Y sta                   
 N 1+ lda    SP X) sta                   
 Next jmp   end-code                     
                                         
                                         
\\ : um*   ( u1 u2 -- ud3)               
 >r 0 0 0 r>  $10 0                      
  DO  dup 2/ >r  1 and IF 2over d+ THEN  
      >r >r 2dup d+ r> r> r>  LOOP       
 drop 2swap 2drop ;                      
( m* 2*                       04jul84ks) 
                                         
: m*     ( n1 n2 -- d)                   
 dup 0< dup >r IF negate THEN            
 swap dup  0<  IF negate r> not >r THEN  
 um*  r> IF dnegate THEN ;               
                                         
: *      ( n n -- prod)   um* drop ;     
                                         
Code 2*  ( n1 -- n2)                     
 SP X) lda  .A asl  SP X) sta            
 SP )Y lda  .A rol  SP )Y sta            
 Next jmp    end-code                    
                                         
                                         
\ : 2*   dup + ;                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( um/mod                      04jul84ks) 
                                         
| : divovl                               
   true Abort" division overflow" ;      
                                         
Code um/mod  ( ud u -- urem uquot)       
 SP X) lda  N 5 + sta                    
 SP )Y lda  N 4 + sta   SP 2inc          
 SP X) lda  N 1+  sta                    
 SP )Y lda  N     sta   iny              
 SP )Y lda  N 3 + sta   iny              
 SP )Y lda  N 2+  sta   $11 # ldx  clc   
  [[ N 6 + ror  sec  N 1+ lda  N 5 + sbc 
     tay  N lda  N 4 + sbc               
    CS not ?[  N 6 + rol ]?              
      CS ?[ N sta  N 1+ sty ]?           
     N 3 + rol N 2+ rol N 1+ rol N rol   
  dex  0= ?]                             
 1 # ldy  N ror  N 1+ ror                
   CS ?[ ;c: divovl ; Assembler ]?       
 N 2+  lda SP )Y sta iny                 
 N 1+  lda SP )Y sta iny                 
 N     lda SP )Y sta 1 # ldy             
 N 3 + lda                               
 Puta jmp    end-code                    
( 2/ m/mod                    24dec83ks) 
                                         
: m/mod  ( d n -- mod quot)              
 dup >r abs  over                        
   0< IF  under + swap  THEN             
 um/mod r@                               
 0< IF negate over IF swap r@ + swap 1-  
 THEN THEN rdrop ;                       
                                         
Code 2/  ( n1 -- n2)                     
 SP )Y lda  .A asl                       
 SP )Y lda  .A ror  SP )Y sta            
 SP X) lda  .A ror                       
 Puta jmp      end-code                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( /mod / mod */mod */ u/mod  ud/mod  ks) 
                                         
: /mod  ( n1 n2 -- rem quot)             
 >r extend r> m/mod ;                    
                                         
: /     ( n1 n2 -- quot)     /mod nip ;  
                                         
: mod   ( n1 n2 -- rem)      /mod drop ; 
                                         
: */mod ( n1 n2 n3 -- rem quot)          
 >r m*  r> m/mod ;                       
                                         
: */    ( n1 n2 n3 -- quot)  */mod nip ; 
                                         
: u/mod  ( u1 u2  -- urem uquot)         
 0 swap um/mod ;                         
                                         
: ud/mod ( ud1 u2 -- urem udquot)        
 >r  0  r@  um/mod  r>                   
   swap >r  um/mod  r>  ;                
                                         
                                         
                                         
                                         
                                         
( cmove cmove> (cmove>       bp 08apr85) 
                                         
Code cmove  ( from to quan --)           
 3 # lda Setup jsr  dey                  
 [[ [[  N cpy  0= ?[  N 1+ dec  0< ?[    
                1 # ldy  Next jmp  ]? ]? 
     N 4 + )Y lda  N 2+ )Y sta iny 0= ?] 
     N 5 + inc N 3 + inc  ]]  end-code   
                                         
Code cmove> ( from to quan --)           
 3 # lda Setup jsr                       
 clc N 1+ lda  N 3 + adc  N 3 + sta      
 clc N 1+ lda  N 5 + adc  N 5 + sta      
 N 1+ inc  N ldy  clc CS ?[              
Label (cmove>                            
 dey  N 4 + )Y lda  N 2+ )Y sta ]?       
 tya  (cmove> bne                        
 N 3 + dec  N 5 + dec  N 1+ dec          
 (cmove> bne  1 # ldy                    
 Next jmp   end-code                     
                                         
: move   ( from to quan --)              
 >r 2dup u<  IF r> cmove> exit THEN      
 r> cmove ;                              
                                         
( place count  erase       16feb85bp/ks) 
                                         
: place ( addr len to --)                
 over >r rot over 1+ r> move c! ;        
                                         
Code count ( addr -- addr+1 len)         
 SP X) lda N sta clc 1 # adc SP X) sta   
 SP )Y lda N 1+ sta  0 # adc SP )Y sta   
 SP 2dec  (c@ jmp   end-code             
                                         
\  : count ( adr -- adr+1 len )          
\   dup 1+  swap c@ ;                    
                                         
: erase ( addr quan --)      0 fill ;    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( fill                        11jun85bp) 
                                         
Code fill  ( addr quan 8b -- )           
 3 # lda Setup jsr  dey                  
 N lda  N 3 + ldx                        
  0<> ?[  [[ [[ N 4 + )Y sta iny 0= ?]   
                N 5 + inc    dex 0= ?]   
      ]?  N 2+ ldx                       
  0<> ?[  [[ N 4 + )Y sta iny dex 0= ?]  
      ]? 1 # ldy                         
 Next jmp   end-code                     
                                         
                                         
\\                                       
: fill  ( addr quan 8b --)   swap ?dup   
       IF  >r over c! dup 1+ r> 1- cmove 
  exit  THEN  2drop  ;                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( here Pad allot , c, compile 24dec83ks) 
                                         
: here  ( -- addr)   dp @ ;              
                                         
: pad   ( -- addr)   here $42 + ;        
                                         
: allot ( n --)      dp +! ;             
                                         
: ,     ( 16b --)    here !  2  allot ;  
                                         
: c,    ( 8b --)     here c! 1  allot ;  
                                         
: compile            r> dup 2+ >r @ , ;  
                     restrict            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( input strings               24dec83ks) 
                                         
Variable #tib   0 #tib !                 
Variable >tib   here >tib !   $50 allot  
Variable >in    0 >in !                  
Variable blk    0 blk !                  
Variable span   0 span !                 
                                         
: tib   ( -- addr )    >tib @ ;          
                                         
: query                                  
 tib  $50 expect                         
 span @ #tib !  >in off  blk off ;       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( scan skip /string           12oct84bp) 
                                         
: scan  ( addr0 len0 char -- addr1 len1) 
 >r                                      
     BEGIN  dup  WHILE  over c@ r@ -     
     WHILE  1- swap 1+ swap  REPEAT      
 rdrop ;                                 
                                         
: skip  ( addr len del -- addr1 len1)    
 >r                                      
     BEGIN  dup  WHILE  over c@ r@ =     
     WHILE  1- swap 1+ swap  REPEAT      
 rdrop ;                                 
                                         
: /string  ( addr0 len0 +n - addr1 len1) 
 over umin rot over + -rot - ;           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ capital                     clv06aug87 
                                         
Label (capital  \ for commodore only     
                \ for Ascii: next scr    
 Ascii a             # cmp  CS           
 ?[ Ascii z    $21 + # cmp  CC           
    ?[ Ascii a $21 + # cmp  CS           
       ?[ $df # and ]? \ 2nd up to low   
     Ascii z      1+ # cmp  CC           
     ?[ $80 # ora      \ low to up       
 ]? ]? ]? rts end-code                   
                                         
Code capital  ( char -- char' )          
 SP X) lda  (capital jsr  SP X) sta      
 Next jmp    end-code                    
                                         
\\ The new (capital does:                
                                         
No  00-40,5b-60,7b-c1-da-dc-ff no change 
==    -@ , [-@ ,  -A -Z -| -      ..     
                                         
No  41-5a,61-7a        changes to:c1-da  
==   a-z , A-Z                     A-Z   
                                         
                                         
\ capitalize                  clv06aug87 
                                         
Code capitalize  ( string -- string )    
 SP X) lda N    sta  SP )Y lda  N 1+ sta 
  N X) lda N 2+ sta   dey                
 [[ N 2+ cpy  0= ?[ 1 # ldy  Next jmp ]? 
   iny N )Y lda  (capital jsr  N )Y sta  
 ]]   end-code                           
                                         
\\ : capitalize  ( string -- string )    
 dup  count  bounds                      
  ?DO  I c@  capital  I c!  THEN  LOOP ; 
                                         
\\ capital ( char -- char )              
   Ascii a  Ascii z 1+  uwithin          
   IF  I c@  [ Ascii a  Ascii A - ]      
 Literal -  ;                            
                                         
\\ Label (capital  \ for Ascii only      
 Ascii a # cmp                           
 CS ?[  Ascii z  1+ # cmp                
    CC ?[      sec                       
           Ascii a Ascii A - # sbc       
  ]? ]?  rts  end-code                   
                                         
( (word                       08apr85bp) 
                                         
| Code (word   ( char adr0 len0 -- adr)  
       \ N   : length of source          
       \ N+2 : ptr in source / next char 
       \ N+4 : string start adress       
       \ N+6 : string length             
 N 6 + stx        \ 0 =: string_length   
 3 # ldy                                 
  [[ SP )Y lda  N ,Y sta dey  0< ?]      
 1 # ldy  clc                            
 >in    lda  N 2+  adc  N 2+  sta        
                  \ >in+adr0 =: N+2      
 >in 1+ lda  N 3 + adc  N 3 + sta        
 sec  N lda  >in    sbc  N    sta        
                  \ len0->in =: N        
   N 1+ lda  >in 1+ sbc  N 1+ sta        
  CC ?[ SP X) lda  >in    sta            
                  \ stream exhausted     
        SP )Y lda  >in 1+ sta            
                                         
                                         
                                         
                                         
                                         
( (word                       08apr85bp) 
                                         
][ 4 # ldy  [[  N lda  N 1+ ora          
                  \ skip char's          
       0= not ?[[ N 2+ X) lda SP )Y cmp  
                  \ while count <>0      
       0=     ?[[ N 2+ winc  N wdec ]]?  
    N 2+  lda  N 4 + sta                 
              \ save string_start_adress 
    N 3 + lda  N 5 + sta                 
    [[  N 2+ X) lda  SP )Y cmp php       
              \ scan for char            
        N 2+ winc  N wdec plp            
    0= not ?[[ N 6 + inc                 
              \ count string_length      
       N lda N 1+ ora                    
    0= ?]  ]? ]?                         
              \ from count = 0 in skip)  
 sec 2 # ldy                             
       \ adr_after_string - adr0 =: >in) 
 N 2+  lda  SP )Y sbc  >in    sta  iny   
 N 3 + lda  SP )Y sbc  >in 1+ sta        
                                         
                                         
                                         
( (word                       08apr85bp) 
                                         
]? \ from 1st ][, stream was exhausted   
   \ when word called)                   
 clc  4 # lda  SP adc  SP sta            
  CS ?[ SP 1+ inc ]?  \ 2drop            
 user' dp # ldy  UP )Y lda               
 SP X) sta N    sta  iny                 
 UP )Y lda 1 # ldy                       
 SP )Y sta N 1+ sta        \ dp @        
 dey N 6 + lda  \ store count byte first 
 [[  N )Y sta  N 4 + )Y lda  iny         
     N 6 + dec  0< ?]                    
 $20 # lda  N )Y sta       \ add a blank 
 1 # ldy   Next jmp   end-code           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( source word parse name      08apr85bp) 
                                         
: source   ( -- addr len)                
 blk @  ?dup IF  block b/blk exit THEN   
 tib #tib @  ;                           
                                         
: word  ( char -- addr)   source (word ; 
                                         
: parse ( char -- addr len)              
 >r source  >in @  /string over swap     
 r> scan >r over - dup r> 0<> - >in +! ; 
                                         
: name   ( -- addr)                      
 bl word  capitalize  exit  ;            
                                         
                                         
\\                                       
: word  ( char -- addr)        >r        
 source  over swap  >in @  /string       
 r@ skip  over  swap  r> scan            
 >r  rot over swap  - r> 0<> -  >in !    
 over - here place  bl here count + c!   
 here ;                                  
                                         
                                         
\ state Ascii ,"  ("  "        02nov87re 
                                         
Variable state    0 state !              
                                         
: Ascii  ( -- char )  ( -- )             
 bl word 1+ c@ state @                   
 IF [compile] Literal THEN ; immediate   
                                         
: ,"       Ascii "  parse                
 here over 1+  allot place  ;            
                                         
: "lit  ( -- adr )                       
 r> r> under count + >r >r ; restrict    
                                         
: ("    ( -- adr )   "lit ; restrict     
                                         
: "        compile ("  ,"  ;             
                immediate restrict       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( ." ( .( \ \\ hex decimal    08sep84ks) 
                                         
: (."    "lit count type ; restrict      
                                         
: ."     compile (." ," ;                
                    immediate restrict   
                                         
: (      Ascii )  parse 2drop ;          
                    immediate            
                                         
: .(     Ascii )  parse type ;           
                    immediate            
                                         
: \      >in @  c/l /  1+ c/l *  >in ! ; 
                    immediate            
                                         
: \\        b/blk >in ! ;  immediate     
                                         
: \needs                                 
 name find nip  IF  [compile] \  THEN ;  
                                         
: hex       $10 base ! ;                 
: decimal    $A base ! ;                 
                                         
                                         
( number conv.:  digit?  accumulate  ks) 
                                         
: digit?  ( char -- digit true/ false )  
 Ascii 0 -   dup 9 u>                    
 IF [ Ascii A Ascii 9 - 1- ]             
   Literal -  dup 9 u>                   
     IF [ 2swap ( unstructured ) ] THEN  
   base @  over  u>  ?dup  ?exit         
 THEN drop  false ;                      
                                         
: accumulate ( +d0 adr digit - +d1 adr)  
 swap >r swap  base @ um*  drop  rot     
 base @ um*  d+  r>  ;                   
                                         
: convert  ( +d1 addr0 -- +d2 addr2)     
 1+  BEGIN  count digit?                 
     WHILE  accumulate    REPEAT  1- ;   
                                         
: end?   ( -- flag )  ptr @  0= ;        
                                         
: char   ( addr0 -- addr1 char )         
 count   -1 ptr +!  ;                    
                                         
: previous  ( addr0 -- addr0 char)       
 1-  count ;                             
( ?nonum ?num fixbase?        13feb85ks) 
                                         
Variable dpl   -1 dpl !                  
                                         
| : ?nonum  ( flag -- exit if true )     
 IF rdrop 2drop drop rdrop false THEN ;  
                                         
| : ?num    ( flag -- exit if true )     
 IF rdrop drop r> IF  dnegate  THEN      
    rot drop  dpl @ 1+  ?dup ?exit       
    drop true THEN ;                     
                                         
| : fixbase?                             
 ( char - char false /  newbase true )   
 Ascii & case?  IF $A true exit THEN     
 Ascii $ case?  IF 10 true exit THEN     
 Ascii H case?  IF 10 true exit THEN     
 Ascii % case?  IF  2 true exit THEN     
 false  ;                                
                                         
| : punctuation?   ( char -- flag)       
   Ascii , over = swap Ascii . =  or ;   
                                         
| : ?dpl   dpl @ -1 = ?exit  1 dpl +! ;  
                                         
( number? number 'number  01oct87clv/re) 
                                         
| Variable ptr      \ points into string 
                                         
: number?                                
 ( string - string false / n 0< / d 0> ) 
 base push  dup count  ptr !  dpl on     
 0 >r  ( +sign)                          
 0 0 rot           end? ?nonum char      
 Ascii - case?                           
 IF rdrop true >r  end? ?nonum char THEN 
 fixbase?                                
 IF  base !        end? ?nonum char THEN 
 BEGIN   digit?  0= ?nonum               
   BEGIN  accumulate  ?dpl  end? ?num    
          char digit?  0= UNTIL          
   previous  punctuation?  0= ?nonum     
   dpl off   end? ?num char REPEAT ;     
                                         
Defer 'number?     ' number? Is 'number? 
                                         
: number  ( string -- d )                
 'number?  ?dup 0= Abort" ?"             
 0< IF extend THEN ;                     
                                         
( hide reveal immediate restrict     ks) 
                                         
Variable last     0 last !               
                                         
| : last?   ( -- false / acf true)       
 last @ ?dup ;                           
                                         
: hide                                   
 last?  IF 2- @ current @ ! THEN ;       
                                         
: reveal                                 
 last?  IF 2-   current @ ! THEN ;       
                                         
: Recursive   reveal  ;                  
 immediate restrict                      
                                         
| : flag!    ( 8b --)                    
   last? IF under c@ or over c! THEN     
   drop ;                                
                                         
: immediate  $40 flag! ;                 
: restrict   $80 flag! ;                 
                                         
                                         
                                         
( clearstack hallot heap heap?11feb85bp) 
                                         
Code clearstack                          
 user' s0 # ldy                          
 UP )Y lda  SP    sta  iny               
 UP )Y lda  SP 1+ sta                    
 1 # ldy  Next jmp   end-code            
                                         
: hallot ( quan -- )                     
 s0 @ over - swap                        
 sp@ 2+  dup rot -  dup s0 !             
 2 pick over -  move  clearstack  s0 ! ; 
                                         
: heap   ( -- addr)        s0 @  6+ ;    
                                         
: heap?  ( addr -- flag)                 
 heap up@ uwithin ;                      
                                         
| : heapmove   ( from -- from)           
   dup here  over -                      
   dup hallot  heap swap cmove           
   heap over - last +!  reveal ;         
                                         
                                         
                                         
( Does>  ;                 30dec84ks/bp) 
                                         
Label (dodoes>   RP 2dec                 
IP 1+ lda RP )Y sta  IP lda  RP X) sta   
                          \ put IP on RP 
clc  W X) lda  3 # adc IP sta            
txa  W )Y adc  IP 1+ sta  \ W@ + 3 -> IP 
                                         
Label docreate                           
 2 # lda  clc W adc pha txa W 1+ adc     
 Push jmp end-code                       
                                         
| : (;code    r> last @  name>  ! ;      
                                         
: Does>                                  
 compile (;code  $4C c,                  
 compile (dodoes> ;  immediate restrict  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( 6502-align  ?head  |        08sep84bp) 
                                         
| : 6502-align/1   ( adr -- adr' )       
   dup  $FF and  $FF =  - ;              
                                         
| : 6502-align/2   ( lfa -- lfa )        
   here  $FF and $FF =                   
   IF  dup dup 1+  here over - 1+        
       cmove>  \ lfa now invalid         
       1 last +! 1 allot  THEN  ;        
                                         
                                         
Variable ?head    0 ?head !              
                                         
: |     ?head @   ?exit   -1 ?head  ! ;  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( warning   Create            30dec84bp) 
                                         
Variable warning  0 warning !            
                                         
| : exists?                              
 warning @ ?exit                         
 last @  current @  (find  nip           
 IF space  last @ .name ." exists " ?cr  
 THEN  ;                                 
                                         
: Create                                 
 here blk @ ,  current @ @ ,             
 name  c@ dup 1 $20                      
 uwithin not  Abort" invalid name"       
 here  last ! 1+ allot                   
 exists? ?head @                         
 IF 1 ?head +!  dup  6502-align/1 ,      
                    \ Pointer to code    
    heapmove $20 flag! 6502-align/1 dp ! 
 ELSE  6502-align/2  drop                
 THEN  reveal  0 ,                       
 ;Code  docreate jmp end-code            
                                         
                                         
                                         
( nfa?                        30dec84bp) 
                                         
 Code nfa?                               
 ( vocabthread  cfa -- nfa / false)      
 SP X) lda  N 4 + sta                    
 SP )Y lda  N 5 + sta   SP 2inc          
 [[ [[ SP X) lda  N 2+  sta              
       SP )Y lda  N 3 + sta              
      N 2+ ora  0= ?[ putFalse jmp ]?    
      N 2+ )Y lda SP )Y sta  N 1+ sta    
      N 2+ X) lda SP X) sta  N sta       
      N 1+ ora  0= ?[  Next jmp  ]?      
                               \ N=link  
      N 2inc N X) lda pha sec $1F # and  
      N adc  N sta  CS ?[ N 1+ inc ]?    
      pla  $20 # and  0= not             
       ?[ N )Y lda  pha                  
          N X) lda N sta pla N 1+ sta ]? 
      N lda     N 4 + cmp  0= ?]         
      N 1+ lda  N 5 + cmp  0= ?]         
 ' 2+ @ jmp       end-code               
                                         
\\ vocabthread=0 that is empty Vocabul-  
 ary in nfa? is not allowed              
                                         
( >name name> >body .name     03feb85bp) 
                                         
: >name   ( cfa -- nfa / false)          
 voc-link                                
 BEGIN @ dup WHILE 2dup 4 - swap         
      nfa? ?dup IF -rot 2drop exit THEN  
 REPEAT nip ;                            
                                         
| : (name>  ( nfa -- cfa)                
   count $1F  and + ;                    
                                         
: name>     ( nfa -- cfa)                
 dup (name> swap c@ $20 and IF @ THEN ;  
                                         
: >body   ( cfa -- pfa)   2+ ;           
                                         
: .name   ( nfa --)                      
 ?dup IF dup heap?  IF ." |" THEN        
         count $1F and type              
      ELSE  ." ???"                      
      THEN  space  ;                     
                                         
                                         
                                         
                                         
\ : ; Constant Variable       clv16jul87 
                                         
: Create: Create hide                    
 current @ context ! ] 0 ;               
                                         
: :  Create: ;Code here >recover !       
               \ resolve fwd. reference  
 RP 2dec IP    lda  RP X) sta            
         IP 1+ lda  RP )Y sta            
 W lda  clc  2 # adc  IP sta             
      txa   W 1+ adc  IP 1+ sta          
 Next jmp   end-code                     
                                         
: ;        0 ?pairs  compile unnest      
 [compile] [ reveal ; immediate restrict 
                                         
                                         
: Constant  ( 16b --)  Create ,          
 ;Code  SP 2dec  2 # ldy                 
 W )Y lda  SP X) sta  iny                
 W )Y lda   1 # ldy   SP )Y sta          
 Next jmp   end-code                     
                                         
: Variable   Create  2 allot ;           
                                         
( uallot User Alias        10jan85ks/bp) 
                                         
: uallot ( quan -- offset)               
 dup udp @ +  $FF                        
   u> Abort" Userarea full"              
 udp  @ swap udp +! ;                    
                                         
: User  Create   2 uallot c,             
 ;Code  SP 2dec  2 # ldy                 
 W )Y lda  clc UP    adc  SP X) sta      
      txa  iny UP 1+ adc  1 # ldy        
 SP )Y sta   Next jmp   end-code         
                                         
: Alias  ( cfa --)                       
 Create last @ dup c@ $20 and            
 IF   -2 allot  ELSE  $20 flag! THEN     
 (name> ! ;                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( voc-link vp current context also   bp) 
                                         
Create   vp       $10 allot              
Variable current                         
                                         
: context ( -- adr  )  vp dup @ + 2+ ;   
                                         
| : thru.vocstack  ( -- from to )        
   vp 2+ context ;                       
\ "Only Forth also Assembler" gives vp : 
\  countword = 6 |Only|Forth|Assembler   
                                         
: also     vp @                          
 $A > Error" Vocabulary stack full"      
 context @   2 vp +!  context ! ;        
                                         
: toss   -2 vp +! ;                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
(  Vocabulary Forth Only Forth-83 ks/bp) 
                                         
: Vocabulary                             
 Create  0 , 0 ,                         
 here voc-link @ ,  voc-link !           
 Does>  context ! ;                      
                                         
\ Name | Code | Thread | Coldthread |    
\ Voc-link                               
                                         
Vocabulary Forth                         
                                         
Vocabulary Only                          
] Does>  [ Onlypatch ]  0 vp !           
 context !  also  ;  ' Only !            
                                         
: Onlyforth                              
 Only Forth also definitions ;           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( definitions order words  13jan84bp/ks) 
                                         
: definitions   context @ current ! ;    
                                         
| : .voc  ( adr -- )                     
 @ 2- >name .name ;                      
                                         
: order                                  
 thru.vocstack  DO  I .voc  -2  +LOOP    
 2 spaces  current .voc ;                
                                         
: words      context @                   
 BEGIN  @ dup stop? 0= and               
 WHILE  ?cr dup 2+ .name space           
 REPEAT drop ;                           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( (find                       08apr85bp) 
                                         
Code (find  ( string thread              
       -- string false / namefield true) 
 3 # ldy [[ SP )Y lda N ,Y sta dey 0< ?] 
 N 2+ X) lda $1F # and N 4 + sta         
                                         
Label findloop   0 # ldy                 
 N )Y lda   tax   iny                    
 N )Y lda  N 1+ sta  N stx  N ora        
  0= ?[ 1 # ldy 0 # ldx putFalse jmp ]?  
 iny N )Y lda  $1F # and  N 4 + cmp      
  findloop bne       \ countbyte match   
 clc 2 # lda N    adc N 5 + sta          
     0 # lda N 1+ adc N 6 + sta          
 N 4  + ldy                              
  [[ N 2+ )Y lda N 5 + )Y cmp            
     findloop bne   dey  0= ?]           
 3 # ldy N 6 + lda  SP )Y sta   dey      
         N 5 + lda  SP )Y sta            
 dey  0 # ldx    putTrue jmp   end-code  
                                         
                                         
                                         
                                         
( found                       29jan85bp) 
                                         
| Code found  ( nfa -- cfa n )           
 SP X) lda N sta  SP )Y lda N 1+ sta     
  N X) lda N 2+ sta  $1F # and           
 sec N adc N sta                         
  CS ?[ N 1+ inc ]?                      
 N 2+ lda $20 # and                      
 0= ?[ N    lda  SP X) sta   N 1+ lda    
    ][ N X) lda  SP X) sta               
       N )Y lda   ]?  SP )Y sta          
  SP 2dec   N 2+ lda   0< ?[  iny  ]?    
 .A asl                                  
  0< not ?[ tya $FF # eor tay iny  ]?    
  tya SP X) sta                          
  0< ?[ $FF # lda  24 c, ]?              
 txa  1 # ldy  SP )Y sta                 
 Next jmp  end-code                      
                                         
\\ | : found  ( nfa -- cfa n )           
      dup   c@ >r   (name>               
            r@ $20 and  IF @ THEN        
        -1  r@ $80 and  IF 1- THEN       
            r> $40 and  IF negate THEN ; 
                                         
( find  ' [']                 13jan85bp) 
                                         
: find ( string -- cfa n / string false) 
 context dup @ over 2- @ = IF 2- THEN    
 BEGIN  under @ (find                    
                IF nip found exit THEN   
   over vp 2+ u>                         
 WHILE  swap 2-                          
 REPEAT nip false ;                      
                                         
: '  ( -- cfa )                          
 name find 0= Abort" What?"  ;           
                                         
: [compile]   ' , ;   immediate restrict 
                                         
: [']     ' [compile] Literal ;          
                      immediate restrict 
                                         
: nullstring?                            
 ( string -- string false  / true)       
 dup c@ 0=  dup  IF nip THEN ;           
                                         
                                         
                                         
                                         
( >interpret                  28feb85bp) 
                                         
Label jump                               
 iny clc W )Y lda 2 # adc IP    sta      
 iny     W )Y lda 0 # adc IP 1+ sta      
 1 # ldy  Next jmp   end-code            
                                         
Variable >interpret                      
                                         
jump  ' >interpret !                     
                                         
\\ make Variable >interpret to special   
   Defer                                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( interpret interactive   01oct87clv/re) 
                                         
Defer  notfound                          
                                         
: no.extensions  ( string -- )           
 Error" Haeh?"   ;  \ string not 0       
                                         
' no.extensions  Is  notfound            
                                         
: interpret     >interpret ;             
                                         
| : interactive                          
 ?stack  name find  ?dup                 
 IF 1 and IF execute >interpret THEN     
   Abort" compile only"  THEN            
 nullstring? ?exit   'number?            
 0= IF  notfound  THEN  >interpret ;     
                                         
                                         
' interactive  >interpret !              
                                         
                                         
                                         
                                         
                                         
( compiling [ ]           01oct87clv/re) 
                                         
| : compiling                            
 ?stack  name find   ?dup                
 IF   0> IF  execute >interpret  THEN    
  , >interpret THEN                      
 nullstring? ?exit  'number?   ?dup      
   IF 0> IF swap [compile] Literal THEN  
    [compile] Literal                    
   ELSE  notfound THEN    >interpret ;   
                                         
                                         
: [    ['] interactive  Is >interpret    
 state off ;  immediate                  
                                         
: ]    ['] compiling    Is >interpret    
 state on ;                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ perfom  Defer Is             02nov87re 
                                         
| : crash   true Abort" Crash" ;         
                                         
: Defer   Create  ['] crash ,            
 ;Code  2 # ldy                          
  W )Y lda  pha iny W )Y lda             
  W 1+ sta  pla W sta  1 # ldy           
  W 1- jmp  end-code                     
                                         
: (is  ( cfa -- )  r>  dup  2+ >r @ ! ;  
                                         
| : def?  ( cfa -- )                     
    @ ['] notfound   @ over =            
 swap ['] >interpret @      =  or        
 not  Abort" not deferred" ;             
                                         
: Is      ( cfa -- )  ( -- )             
 ' dup  def?  >body                      
 state  @  IF  compile (is , exit  THEN  
 !  ; immediate                          
                                         
                                         
                                         
                                         
( ?stack                  01oct87clv/re) 
                                         
| Create alarm  1 allot  0 alarm c!      
                                         
| : stackfull   ( -- )                   
 depth $20 > abort" tight stack"         
 alarm c@ 0= IF  -1 alarm c!             
    true abort" dictionary full"  THEN   
 ." still full " ;                       
                                         
Code ?stack                              
 user' dp # ldy                          
 sec SP    lda  UP )Y sbc                
 iny SP 1+ lda  UP )Y sbc                
 0= ?[ 1 # ldy ;c: stackfull ;           
       Assembler ]?  alarm stx           
 user' s0 # ldy                          
 UP )Y lda SP    cmp iny                 
 UP )Y lda SP 1+ sbc                     
 1 # ldy  CS ?[  Next jmp ]?             
 ;c: true Abort" stack empty" ;          
                                         
\\ : ?stack                              
 sp@  here - $100 u< IF stackfull THEN   
 sp@  s0 @ u> Abort" stack empty" ;      
( .status push load           08sep84ks) 
                                         
Defer .status    ' noop Is .status       
                                         
| Create pull  0  ] r> r> ! ;            
                                         
: push ( addr -- )                       
 r> swap dup >r @ >r  pull >r >r  ;      
 restrict                                
                                         
: load   ( blk --)                       
 ?dup 0= ?exit blk push  blk !           
 >in push  >in off                       
 .status interpret ;                     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( +load thru +thru --> rdepth depth  ks) 
                                         
: +load  ( offset --)  blk @  + load ;   
                                         
: thru  ( from to --)                    
 1+  swap  DO  I load  LOOP ;            
                                         
: +thru  ( off0 off1 --)                 
 1+  swap  DO  I +load LOOP ;            
                                         
: -->                                    
 1 blk +! >in off .status  ;  immediate  
                                         
: rdepth  ( -- +n)  r0 @  rp@ 2+ - 2/ ;  
                                         
: depth   ( -- +n)  sp@ s0 @ swap - 2/ ; 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( quit (quit abort            07jun85bp) 
                                         
| : prompt                               
 state @  IF ."  compiling"  exit  THEN  
 ."  ok" ;                               
                                         
: (quit                                  
 BEGIN .status cr query interpret prompt 
 REPEAT ;                                
                                         
Defer 'quit    ' (quit  Is 'quit         
                                         
: quit     r0 @ rp! [compile] [ 'quit ;  
                                         
                                         
: standardi/o                            
 [ output ] Literal output 4 cmove ;     
                                         
Defer 'abort   ' noop Is 'abort          
                                         
: abort                                  
 clearstack  end-trace  'abort           
 standardi/o  quit   ;                   
                                         
                                         
\ (error Abort" Error"         02nov87re 
                                         
Variable scr 1 scr !  Variable r# 0 r# ! 
                                         
: (error  ( string -- )                  
 standardi/o space here .name count type 
 space ?cr  blk @  ?dup                  
 IF  scr !  >in @  r# !  THEN quit ;     
                                         
' (error  errorhandler  !                
                                         
: (abort"  ( flag -- )   "lit swap       
 IF    >r clearstack r>                  
       errorhandler perform  exit        
 THEN  drop ;  restrict                  
                                         
| : (err"  ( flag -- )   "lit swap       
 IF    errorhandler perform  exit        
 THEN  drop ;  restrict                  
                                         
: Abort"  ( flag -- )   compile (abort"  
 ," ; immediate  restrict                
                                         
: Error"  ( flag -- )   compile (err"    
 ," ; immediate  restrict                
( -trailing                   08apr85bp) 
                                         
020 Constant bl                          
                                         
Code -trailing  ( addr n1 -- adr  n2 )   
 tya   Setup jsr                         
 SP X) lda  N 2+ sta   clc               
 SP )Y lda  N 1+ adc  N 3 + sta          
 N ldy  clc   CS ?[                      
Label (-trail                            
 dey  N 2+ )Y lda  bl # cmp              
  0<> ?[ iny  0= ?[ N 1+ inc ]?          
         tya pha  N 1+ lda Push jmp ]?   
 ]?   tya   (-trail bne                  
 N 3 + dec N 1 + dec  (-trail bpl        
 tya Push0A jmp   end-code               
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( space spaces             29jan85ks/bp) 
                                         
: space            bl emit ;             
                                         
: spaces  ( u --)  0  ?DO space LOOP ;   
                                         
                                         
\\                                       
: -trailing  ( addr n1 -- addr n2)       
 2dup  bounds                            
    ?DO 2dup + 1- c@ bl -                
      IF LEAVE THEN  1- LOOP  ;          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( hold <# #> sign # #s        24dec83ks) 
                                         
| : hld  ( -- addr)    pad 2- ;          
                                         
: hold  ( char -- )                      
 -1 hld +! hld @ c! ;                    
                                         
: <#                   hld hld ! ;       
                                         
: #>    ( 32b -- addr +n )               
 2drop hld @  hld over - ;               
                                         
: sign  ( n -- )                         
 0< IF Ascii  - hold THEN ;              
                                         
: #     ( +d1 -- +d2)                    
 base @ ud/mod rot 09 over <             
  IF  [ Ascii A  Ascii 9  - 1- ]         
      Literal  +                         
  THEN  Ascii 0  +  hold ;               
                                         
: #s    ( +d -- 0 0 )                    
 BEGIN # 2dup  d0= UNTIL ;               
                                         
                                         
( print numbers               24dec83ks) 
                                         
: d.r  -rot under dabs <# #s rot sign #> 
        rot over max over - spaces type  
 ;                                       
                                         
: .r    swap extend rot d.r ;            
                                         
: u.r   0 swap d.r ;                     
                                         
: d.    0 d.r space ;                    
                                         
: .     extend d. ;                      
                                         
: u.    0 d. ;                           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ .s list c/l l/s             clv4:jul87 
                                         
: .s   sp@  s0 @  over - 020 umin        
 bounds ?DO I @ u.  2 +LOOP ;            
                                         
40 (C drop 29 ) Constant c/l             
   \ Screen line length                  
10 (C drop 19 ) Constant l/s             
   \ lines per screen                    
                                         
: list   ( blk --)                       
 scr ! ." Scr " scr @ dup blk/drv mod u. 
       ." Dr "  drv? .                   
 l/s 0 DO stop? IF leave THEN            
   cr I 2 .r space scr @  block          
      I c/l * + c/l  (C 1- )             
   -trailing type  LOOP cr ;             
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( multitasker primitives      bp03nov85) 
                                         
Code pause   Next here 2- !  end-code    
                                         
: lock  ( addr --)                       
 dup @  up@ =  IF  drop exit  THEN       
 BEGIN  dup @  WHILE  pause  REPEAT      
 up@ swap ! ;                            
                                         
: unlock  ( addr --)   dup lock off ;    
                                         
Label wake    wake >wake !               
 pla  sec  5 # sbc  UP    sta            
 pla       0 # sbc  UP 1+ sta            
 04C # lda  UP X) sta                    
 6 # ldy  UP )Y lda SP    sta            
     iny  UP )Y lda SP 1+ sta 1 # ldy    
 SP X) lda  RP sta                       
 SP )Y lda  RP 1+ sta   SP 2inc          
 IP  # ldx  Xpull jmp                    
end-code                                 
                                         
                                         
                                         
                                         
( buffer mechanism            15dec83ks) 
                                         
User file           0 file !             
        \ adr of file control block      
Variable prev       0 prev !             
        \ Listhead                       
Variable buffers  0 buffers !            
        \ Semaphore                      
0408 Constant b/buf                      
        \ Physical Size                  
                                         
\\ Structure of Buffer:                  
 0 : link                                
 2 : file                                
 4 : blocknr                             
 6 : statusflags                         
 8 : Data .. 1 KB ..                     
                                         
Statusflag bits: 15   1 -> updated       
                                         
file = -1 empty buffer                   
     = 0 no fcb , direct access          
     = else  adr of fcb                  
     ( system   dependent )              
                                         
( search for blocks in memory 11jun85bp) 
                                         
Label thisbuffer?        2 # ldy         
   [[  N 4 + )Y lda N 2- ,Y cmp          
 0= ?[[  iny  6 # cpy 0= ?] ]? rts       
              \ zero if this buffer )    
                                         
| Code (core?                            
 ( blk file -- addr / blk  file )        
 \ N-Area : 0 blk 2 file 4 buffer        
 \          6 predecessor                
 3 # ldy                                 
   [[ SP )Y lda  N ,Y sta  dey  0< ?]    
 user' offset # ldy                      
 clc  UP )Y lda  N 2+  adc  N 2+  sta    
 iny  UP )Y lda  N 3 + adc  N 3 + sta    
 prev    lda  N 4 + sta                  
 prev 1+ lda  N 5 + sta                  
 thisbuffer? jsr    0= ?[                
                                         
                                         
                                         
                                         
                                         
                                         
(   "                         11jun85bp) 
                                         
Label blockfound     SP 2inc             
 1 # ldy                                 
 8 #   lda  clc N 4 + adc SP X) sta      
 N 5 + lda        0 # adc SP )Y sta      
 ' exit @ jmp  ]?                        
 [[ N 4 + lda  N 6 + sta                 
    N 5 + lda  N 7 + sta                 
    N 6 + X) lda  N 4 + sta  1 # ldy     
    N 6 + )Y lda  N 5 + sta  N 4 + ora   
     0= ?[ ( list empty )  Next jmp ]?   
   thisbuffer? jsr 0= ?] \ found, relink 
 N 4 + X) lda  N 6 + X) sta  1 # ldy     
 N 4 + )Y lda  N 6 + )Y sta              
 prev    lda  N 4 + X) sta               
 prev 1+ lda  N 4 + )Y sta               
 N 4 + lda  prev    sta                  
 N 5 + lda  prev 1+ sta                  
 blockfound jmp    end-code              
                                         
                                         
                                         
                                         
                                         
\ (core?                       23sep85bp 
                                         
\\                                       
                                         
| : this?   ( blk file bufadr -- flag )  
   dup 4+ @  swap 2+ @  d= ;             
                                         
| : (core?                               
   ( blk file -- dataaddr / blk file )   
  BEGIN  over offset @ + over  prev @    
    this? IF rdrop 2drop prev @ 8 + exit 
          THEN                           
    2dup >r offset @ + >r prev @         
    BEGIN  dup @ ?dup                    
       0= IF rdrop rdrop drop exit THEN  
      dup r> r> 2dup >r >r  rot this? 0= 
    WHILE  nip  REPEAT                   
    dup @ rot !  prev @ over !  prev !   
    rdrop rdrop                          
  REPEAT ;                               
                                         
                                         
                                         
                                         
                                         
( (diskerr                    11jun85bp) 
                                         
: (diskerr   ." error !  r to retry "    
 key dup Ascii r =  swap Ascii R =       
 or not  Abort" aborted"  ;              
                                         
                                         
Defer diskerr  ' (diskerr  Is diskerr    
                                         
Defer r/w                                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( backup emptybuf readblk     11jun85bp) 
                                         
| : backup   ( bufaddr --)               
 dup 6+ @  0<                            
 IF  2+  dup @ 1+                        
            \ buffer empty if file = -1  
  IF input push output push standardi/o  
   BEGIN dup 6+ over 2+ @ 2 pick @ 0 r/w 
   WHILE ." write " diskerr              
   REPEAT   THEN                         
  080 over 4+ 1+ ctoggle  THEN           
 drop ;                                  
                                         
| : emptybuf  ( bufaddr --)              
   2+ dup on 4+ off ;                    
                                         
| : readblk                              
   ( blk file addr -- blk file addr)     
 dup emptybuf  input push  output push   
 standardi/o   >r                        
 BEGIN over offset @ + over              
       r@ 8 +  -rot   1  r/w             
 WHILE ." read " diskerr                 
 REPEAT  r>  ;                           
                                         
( take mark updates? full? core?     bp) 
                                         
| : take   ( -- bufaddr)    prev         
 BEGIN  dup @  WHILE  @  dup 2+ @ -1 =   
 UNTIL                                   
 buffers lock   dup backup ;             
                                         
| : mark                                 
 ( blk file bufaddr -- blk file )        
 2+ >r 2dup r@ !  offset @ +  r@ 2+ !    
 r> 4+ off  buffers unlock ;             
                                         
| : updates?  ( -- bufaddr / flag)       
 prev  BEGIN  @ dup  WHILE  dup 6+ @     
   0<  UNTIL ;                           
                                         
| : full?   ( -- flag)                   
 prev BEGIN @ dup @ 0= UNTIL  6+ @ 0< ;  
                                         
: core?  ( blk file -- addr /false)      
 (core? 2drop false ;                    
                                         
                                         
                                         
                                         
( block & buffer manipulation 11jun85bp) 
                                         
: (buffer ( blk file -- addr)            
 BEGIN  (core? take mark                 
 REPEAT ;                                
                                         
: (block  ( blk file -- addr)            
 BEGIN  (core? take readblk mark         
 REPEAT ;                                
                                         
| Code file@  ( -- n )                   
 user' file # ldy                        
 UP )Y lda  pha  iny  UP )Y lda          
 Push jmp  end-code                      
                                         
: buffer  ( blk -- addr )                
 file@  (buffer ;                        
                                         
: block   ( blk -- addr )                
 file@  (block ;                         
                                         
                                         
                                         
                                         
                                         
( block & buffer manipulation 09sep84ks) 
                                         
: update   080 prev @  6+ 1+ c! ;        
                                         
: save-buffers                           
 buffers lock BEGIN   updates? ?dup      
              WHILE backup REPEAT        
 buffers unlock  ;                       
                                         
: empty-buffers                          
 buffers lock  prev                      
 BEGIN @ ?dup                            
 WHILE dup emptybuf                      
 REPEAT  buffers unlock ;                
                                         
: flush    save-buffers empty-buffers ;  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( moving blocks               15dec83ks) 
                                         
 : (copy   ( from to --)                 
 dup file@                               
 core? IF prev @ emptybuf THEN           
 full? IF  save-buffers   THEN           
 offset @ + swap block 2- 2- !  update ; 
                                         
 : blkmove  ( from to quan --)           
 save-buffers >r                         
 over r@ + over u> >r  2dup u< r> and    
  IF  r@ r@ d+  r> 0 ?DO -1 -2 d+        
                         2dup (copy LOOP 
  ELSE          r> 0 ?DO 2dup (copy 1    
                             1 d+   LOOP 
  THEN  save-buffers 2drop ;             
                                         
: copy    ( from to --)   1 blkmove ;    
                                         
: convey  ( [blk1 blk2] [to.blk --)      
 swap  1+  2 pick -   dup 0> not         
 Abort" no!!"  blkmove ;                 
                                         
                                         
                                         
\ Allocating buffers          clv12jul87 
                                         
E400 Constant limit     Variable first   
                                         
: allotbuffer   ( -- )                   
 first @  r0 @ -  b/buf 2+ u< ?exit      
 b/buf negate first +!                   
 first @ dup emptybuf                    
 prev  @ over !  prev !   ;              
                                         
: freebuffer    ( -- )                   
 first @   limit b/buf - u<              
  IF first @ backup prev                 
    BEGIN  dup @ first @  -              
    WHILE  @  REPEAT                     
  first @  @ swap ! b/buf first +!       
  THEN ;                                 
                                         
: all-buffers                            
 BEGIN  first @ allotbuffer              
        first @  = UNTIL ;               
                                         
                                         
                                         
                                         
( endpoints of forget      04jan85bp/ks) 
                                         
| : |? ( nfa -- flag )   c@  020  and ;  
                                         
| : forget?  ( adr nfa -- flag )         
     \ code in heap or above adr ?       
 name> under 1+ u< swap  heap?  or ;     
                                         
|  : endpoints  ( addr -- addr symb)     
 heap   voc-link @ >r                    
 BEGIN r> @ ?dup    \ through all Vocabs 
 WHILE dup >r 4 - >r \ link on returnst. 
  BEGIN r> @ >r over 1- dup r@  u<       
                    \ until link  or     
             swap  r@ 2+ name> u< and    
                    \ code under adr     
  WHILE  r@ heap?  [ 2dup ] UNTIL        
             \ search for a name in heap 
    r@ 2+ |?  IF  over r@ 2+ forget?     
               IF r@ 2+ (name> 2+ umax   
               THEN \ then update symb   
              THEN                       
  REPEAT rdrop                           
 REPEAT  ;                               
                                         
\ remove                       23jul85we 
                                         
| Code remove ( dic symb thr - dic symb) 
 5 # ldy [[ SP )Y lda N ,Y sta dey 0< ?] 
 user' s0 # ldy                          
 clc UP )Y lda 6 # adc N 6 + sta         
 iny UP )Y lda 0 # adc N 7 + sta         
 1 # ldy                                 
 [[ N X) lda N 8 + sta                   
    N )Y lda N 9 + sta N 8 + ora  0<>    
 ?[[ N 8 + lda N 6 + cmp                 
     N 9 + lda N 7 + sbc CS              
   ?[ N 8 + lda N 2 + cmp                
      N 9 + lda N 3 + sbc                
   ][ N 4 + lda N 8 + cmp                
      N 5 + lda N 9 + sbc                
   ]? CC                                 
   ?[ N 8 + X) lda N X) sta              
      N 8 + )Y lda N )Y sta              
   ][ N 8 + lda    N    sta              
      N 9 + lda N 1+ sta ]?              
 ]]? (drop jmp   end-code                
                                         
                                         
                                         
( remove-     forget-words    29apr85bp) 
                                         
| : remove-words ( dic symb -- dic symb) 
 voc-link  BEGIN  @ ?dup                 
  WHILE  dup >r 4 - remove r>  REPEAT  ; 
                                         
| : remove-tasks  ( dic --)              
 up@  BEGIN  1+ dup @ up@ -              
 WHILE  2dup @ swap here uwithin         
  IF dup @ 1+ @ over ! 1-  ELSE  @ THEN  
 REPEAT  2drop ;                         
                                         
| : remove-vocs  ( dic symb -- dic symb) 
 voc-link remove thru.vocstack           
  DO  2dup I @  -rot  uwithin            
    IF   [ ' Forth 2+ ] Literal I ! THEN 
  -2 +LOOP                               
 2dup   current @  -rot   uwithin        
  IF [ ' Forth 2+ ] Literal current !    
  THEN ;                                 
                                         
Defer custom-remove                      
' noop Is custom-remove                  
                                         
                                         
( deleting words from dict.   13jan83ks) 
                                         
| : forget-words    ( dic symb --)       
 over remove-tasks remove-vocs           
      remove-words custom-remove         
 heap swap - hallot dp !  0 last ! ;     
                                         
: clear                                  
 here  dup up@ forget-words   dp ! ;     
                                         
: (forget ( adr --)                      
 dup  heap? Abort" is symbol"            
 endpoints forget-words ;                
                                         
: forget  ' dup [ dp ] Literal @         
 u<  Abort" protected"                   
 >name dup heap?                         
 IF  name>  ELSE  2- 2-  THEN            
 (forget   ;                             
                                         
: empty  [ dp ] Literal @                
 up@ forget-words                        
 [ udp ] Literal @  udp ! ;              
                                         
                                         
\ save bye stop? ?cr         clv2:jull87 
                                         
: save                                   
 here up@ forget-words                   
 voc-link @  BEGIN  dup 2- 2-  @  over   
               2- !  @ ?dup 0=  UNTIL    
 up@ origin $100 cmove   ;               
                                         
: bye save-buffers (bye ;                
\ : bye       flush empty (bye ;         
                                         
| : end?    key ( #cr ) (C 3 ) =         
            IF true rdrop THEN ;         
                                         
: stop?   ( -- flag)                     
 key? IF end? end? THEN false ;          
                                         
: ?cr   col  c/l $A -  u> IF cr THEN ;   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( in/output structure         02mar85bp) 
                                         
| : Out:  Create dup c,  2+              
          Does> c@ output @ +  perform ; 
                                         
  : Output:  Create:                     
             Does>  output ! ;           
                                         
0  Out: emit   Out: cr     Out: type     
   Out: del    Out: page   Out: at       
   Out: at?                              
drop                                     
                                         
: row   ( -- row)  at? drop ;            
: col   ( -- col)  at? nip ;             
                                         
| : In:    Create dup c, 2+              
           Does> c@ input @ + perform ;  
                                         
  : Input:  Create:                      
            Does> input ! ;              
                                         
0  In: key   In: key?   In: decode       
   In: expect                            
drop                                     
( Alias  only definitionen    29jan85bp) 
                                         
Only definitions Forth                   
                                         
: seal  0 ['] Only  >body  ! ;           
        \ kill all words in Only)        
                                         
      ' Only  Alias Only                 
      ' Forth Alias Forth                
      ' words Alias words                
      ' also  Alias also                 
' definitions Alias definitions          
                                         
Host Target                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ 'cold                   01oct87clv/re) 
                                         
| : init-vocabularys   voc-link @        
 BEGIN  dup  2- @  over 4 - !            
        @ ?dup 0= UNTIL ;                
                                         
| : init-buffers                         
 0 prev !  limit first !  all-buffers ;  
                                         
Defer 'cold    ' noop Is 'cold           
                                         
| : (cold                                
 init-vocabularys  init-buffers          
 Onlyforth 'cold                         
 page logo count type cr                 
 (restart ;                              
                                         
Defer 'restart  ' noop Is 'restart       
                                         
| : (restart                             
 ['] (quit Is 'quit                      
 drvinit 'restart  [ errorhandler ]      
 Literal @ errorhandler !                
 [']  noop Is 'abort abort ;             
                                         
\ forth-init              01oct87clv/re) 
                                         
Label forth-init                         
 Bootnextlen 1- # ldy                    
 [[ Bootnext ,Y lda PutA ,Y sta          
    dey 0< ?]                            
 clc s0 lda 6 # adc UP sta               
  s0 1+ lda 0 # adc UP 1+ sta            
 user' s0 # ldy  UP )Y lda SP sta        
            iny  UP )Y lda SP 1+ sta     
 user' r0 # ldy  UP )Y lda RP sta        
            iny  UP )Y lda RP 1+ sta     
 0 # ldx 1 # ldy txa RP X) sta RP )Y sta 
Label donothing rts                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ cold restart                 06nov87re 
                                         
Code cold        here >cold !            
 $FF # ldx  txs                          
Label bootsystem                         
 donothing jsr \ patch for first-init    
 clc s0 lda 6 # adc N sta                
  s0 1+ lda 0 # adc N 1+ sta  0 # ldy    
 [[ origin ,Y lda N )Y sta iny 0= ?]     
 forth-init jsr                          
 ;c: init-system  (cold ;                
                                         
Code restart     here >restart !         
 $FF # ldx  txs                          
Label warmboot                           
 donothing jsr \ patch for first-init    
 forth-init jsr                          
 ;c: init-system  (restart ;             
                                         
Label xyNext                             
 0 # ldx 1 # ldy Next jmp end-code       
                                         
                                         
                                         
                                         
\ System-Loadscreen       01oct87clv/re) 
                                         
 3 $18 +thru          \ CBM-Interface    
(c16+    19 +load )   \ c16init RamIRQ   
                                         
                                         
Host  ' Transient 8 + @                  
  Transient  Forth  Context @ 6 + !      
Target                                   
                                         
Forth also definitions                   
                                         
(C16 : (64 ) \ jumps belhind C)          
(C64 : (16 )                             
 BEGIN name count 0= abort" C) missing"  
 @ [ Ascii C Ascii ) $100 * + ] Literal  
 = UNTIL ; immediate                     
                                         
: C)  ; immediate                        
                                         
(C16 : (16 ) (C64 : (64 ) ; immediate    
                                         
: forth-83 ;  \ last word in Dictionary  
                                         
                                         
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
\ System patchup              clv06aug87 
                                         
Forth definitions                        
                                         
(C64  C000 ' limit >body !               
      7B00 s0 !  7F00 r0 ! )             
                                         
(C16  8000 ' limit >body !               
      7700 s0 !  7b00 r0 ! )             
                                         
\ (C16+ fd00 ' limit >body !             
\       7B00 s0 !  7F00 r0 ! )           
                                         
s0 @ dup s0 2- !      6 + s0 7 - !       
here dp !                                
                                         
Host  Tudp @          Target  udp !      
Host  Tvoc-link @     Target  voc-link ! 
Host  move-threads                       
                                         
                                         
                                         
                                         
                                         
                                         
\ CBM-Labels                   05nov87re 
                                         
$FFA5 >label ACPTR                       
$FFC6 >label CHKIN                       
$FFC9 >label CHKOUT                      
$FFD2 >label CHROUT                      
$FF81 >label CINT                        
$FFA8 >label CIOUT                       
$FFC3 >label CLOSE                       
$FFCC >label CLRCHN                      
$FFE4 >label GETIN                       
$FF84 >label IOINIT                      
$FFB1 >label LISTEN                      
$FFC0 >label OPEN                        
$FFF0 >label PLOT                        
$FF8A >label RESTOR                      
$FF93 >label SECOND                      
$FFE1 >label STOP                        
$FFB4 >label TALK                        
$FF96 >label TKSA                        
$FFEA >label UDTIM                       
$FFAE >label UNLSN                       
$FFAB >label UNTLK                       
$FFCF >label CHRIN                       
$FF99 >label MEMTOP                      
\ C64-Labels                 clv13.4.87) 
                                         
(C64                                     
                                         
0E716 >label ConOut                      
  09d >label MsgFlg                      
  09a >label OutDev                      
  099 >label  InDev                      
0d020 >label BrdCol                      
0d021 >label BkgCol                      
 0286 >label PenCol                      
  0ae >label PrgEnd                      
  0c1 >label IOBeg                       
  0d4 >label CurFlg                      
  0d8 >label InsCnt                      
 028a >label KeyRep                      
                                         
                                         
                                         
                                         
                                         
)                                        
                                         
                                         
                                         
\ C16-Labels                 clv13.4.87) 
                                         
(C16                                     
                                         
0ff4c >label ConOut                      
  09a >label MsgFlg                      
  099 >label OutDev                      
  098 >label  InDev                      
0ff19 >label BrdCol                      
0ff15 >label BkgCol                      
 0540 >label PenCol                      
  09d >label PrgEnd                      
  0b2 >label IOBeg                       
  0cb >label CurFlg                      
  0cf >label InsCnt                      
 0540 >label KeyRep                      
                                         
                                         
                                         
                                         
 055d >label PKeys                       
)                                        
                                         
                                         
                                         
\ c64key? getkey              clv12jul87 
                                         
Code c64key? ( -- flag)                  
(C64  0C6 lda            ( )             
(c16  0ef lda  055d ora  ( )             
 0<> ?[  0FF # lda  ]? pha               
 Push jmp  end-code                      
                                         
Code getkey  ( -- 8b)                    
(C64 0C6 lda  0<>                        
 ?[  sei  0277 ldy                       
  [[  0277 1+ ,X lda  0277 ,X sta  inx   
      0C6 cpx  0= ?]                     
  0C6 dec  tya  cli  0A0 # cmp           
  0= ?[  bl # lda  ]?                    
 ]? ( )                                  
(C16 0ebdd jsr                           
  0A0 # cmp 0= ?[  bl # lda  ]? ( )      
 Push0A jmp   end-code                   
                                         
                                         
                                         
                                         
                                         
                                         
( curon curoff               clv12.4.87) 
                                         
(C16  Code curon \ --                    
0ca lda clc 0c8 adc 0ff0d sta            
0c9 lda     0 # adc 0b # sbc 0ff0c sta   
next jmp end-code                        
                                         
Code curoff \ --                         
0ff # lda ff0c sta 0ff0d sta Next jmp    
end-code )                               
                                         
(C16 \\ )                                
                                         
Code curon   ( --)                       
 0D3 ldy  0D1 )Y lda  0CE sta  0CC stx   
 xyNext jmp   end-code                   
                                         
Code curoff   ( --)                      
 iny  0CC sty  0CD sty  0CF stx          
 0CE lda  0D3 ldy  0D1 )Y sta            
 1 # ldy  Next jmp   end-code            
                                         
                                         
                                         
                                         
( #bs #cr ..keyboard         clv12.4.87) 
                                         
                                         
: c64key  ( -- 8b)                       
 curon BEGIN pause c64key?  UNTIL        
 curoff getkey ;                         
                                         
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
                                         
( con! printable?            clv11.4.87) 
                                         
Code con!  ( 8b --)   SP X) lda          
Label (con!     ConOut jsr    SP 2inc    
Label (con!end  CurFlg stx InsCnt stx    
 1 # ldy ;c:  pause ;                    
                                         
Label (printable?   \ for CBM-Code !     
                    \ CS is printable    
  80 # cmp  CC ?[   bl # cmp  rts  ]?    
 0E0 # cmp  CC ?[  0C0 # cmp  rts  ]?    
 clc  rts  end-code                      
                                         
Code printable? ( 8b -- 8b flag)         
 SP X) lda  (printable? jsr CS ?[ dex ]? 
 txa  PushA jmp     end-code             
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( emit cr del page at at?    clv11.4.87) 
                                         
Code c64emit  ( 8b -- )                  
 SP X) lda  (printable? jsr              
    CC ?[  Ascii . # lda ]?              
 (con! jmp   end-code                    
                                         
: c64cr     #cr con! ;                   
                                         
: c64del    9D con!  space  9D con! ;    
                                         
: c64page   93 con! ;                    
                                         
Code c64at  ( row col --)                
 2 # lda  Setup jsr                      
 N 2+ ldx  N ldy  clc  PLOT jsr          
(C16 \ ) 0D3 ldy  0D1 )Y lda   0CE sta   
 xyNext jmp  end-code                    
                                         
Code c64at?  ( -- row col)               
 SP 2dec txa  SP )Y sta                  
 sec  PLOT jsr                           
 28 # cpy  tya  CS ?[ 28 # sbc ]?        
 pha  txa  0 # ldx  SP X) sta  pla       
 Push0A jmp  end-code                    
( type display (bye          clv11.4.87) 
                                         
Code  c64type  ( adr len -- )            
 2 # lda  Setup jsr  0 # ldy             
  [[  N cpy  0<>                         
  ?[[  N 2+ )Y lda  (printable? jsr      
         CC ?[  Ascii . # lda  ]?        
 ConOut jsr  iny  ]]?                    
 (con!end jmp   end-code                 
                                         
Output: display   [ here output ! ]      
 c64emit c64cr c64type c64del c64page    
 c64at c64at? ;                          
                                         
(C64  | Create (bye  $FCE2  here 2- ! )  
                                         
(C16- | Create (bye  $FF52  here 2- ! )  
                                         
(C16+ | CODE   (bye  rom $FF52 jmp       
                             end-code )  
                                         
                                         
                                         
                                         
                                         
\ b/blk drive >drive drvinit  clv14:2x87 
                                         
400 Constant b/blk                       
                                         
0AA Constant blk/drv                     
                                         
Variable (drv    0 (drv !                
                                         
| : disk ( -- dev.no )   (drv @ 8 + ;    
                                         
: drive  ( drv# -- )                     
 blk/drv *  offset ! ;                   
                                         
: >drive ( block drv# -- block' )        
 blk/drv * +   offset @ - ;              
                                         
: drv?    ( block -- drv# )              
 offset @ + blk/drv / ;                  
                                         
: drvinit  noop ;                        
                                         
                                         
                                         
                                         
                                         
( i/o busoff                  10may85we) 
                                         
Variable i/o  0 i/o !  \ Semaphore       
                                         
Code busoff  ( --)   CLRCHN jsr          
Label unlocki/o  1 # ldy  0 # ldx        
 ;c:  i/o unlock ;                       
                                         
Label nodevice     0 # ldx  1 # ldy      
 ;c:  busoff   buffers unlock            
      true Abort" no device" ;           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ?device                     clv12jul87 
                                         
Label (?dev                              
 90 stx (C16 $ae sta ( ) LISTEN jsr      
        \ because of error in OS         
 60 # lda  SECOND jsr  UNLSN jsr         
 90 lda  0<> ?[ pla pla nodevice jmp ]?  
 rts    end-code                         
                                         
 Code (?device  ( dev --)                
 SP X) lda  (?dev jsr  SP 2inc           
 unlocki/o jmp  end-code                 
                                         
: ?device  ( dev -- )                    
 i/o lock  (?device ;                    
                                         
 Code (busout  ( dev 2nd -- )            
 MsgFlg stx  2 # lda  Setup jsr          
 N 2+ lda  (?dev jsr                     
 N 2+ lda  LISTEN jsr                    
 N lda  60 # ora SECOND jsr              
 N 2+ ldx  OutDev stx                    
 xyNext jmp  end-code                    
                                         
                                         
\ busout/open/close/in        clv12jul87 
                                         
: busout    ( dev 2nd -- )               
 i/o lock (busout ;                      
                                         
: busopen   ( dev 2nd -- )               
 0F0 or busout ;                         
                                         
: busclose  ( dev 2nd -- )               
 0E0 or busout busoff ;                  
                                         
 Code (busin  ( dev 2nd -- )             
 MsgFlg stx  2 # lda  Setup jsr          
 N 2+ lda  (?dev jsr                     
 N 2+ lda  TALK jsr                      
 N lda  60 # ora (C16 $ad sta ( )        
 TKSA jsr                                
\ because of error in old C16 OS         
 N 2+ ldx  InDev stx                     
 xyNext jmp end-code                     
                                         
: busin  ( dev 2nd -- )                  
 i/o lock  (busin ;                      
                                         
                                         
( bus-!/type/@/input derror?  24feb85re) 
                                         
Code bus!  ( 8b --)                      
 SP X) lda  CIOUT jsr  (xydrop jmp       
 end-code                                
                                         
: bustype  ( adr n --)                   
 bounds  ?DO  I c@ bus!  LOOP pause ;    
                                         
Code bus@  ( -- 8b)                      
 ACPTR jsr Push0A jmp  end-code          
                                         
: businput  ( adr n --)                  
 bounds  ?DO  bus@ I c! LOOP pause ;     
                                         
: derror?  ( -- flag )                   
 disk $F busin bus@  dup Ascii 0 -       
  IF  BEGIN emit bus@ dup #cr =  UNTIL   
  0= cr  THEN   0=  busoff ;             
                                         
                                         
                                         
                                         
                                         
                                         
( s#>s+t  x,x                 28may85re) 
                                         
165 | Constant 1.t                       
1EA | Constant 2.t                       
256 | Constant 3.t                       
                                         
| : (s#>s+t ( sector# -- sect track)     
      dup 1.t u< IF 15 /mod exit THEN    
 3 +  dup 2.t u< IF 1.t - 13 /mod 11 +   
                            exit THEN    
      dup 3.t u< IF 2.t - 12 /mod 18 +   
                            exit THEN    
 3.t - 11 /mod 1E + ;                    
                                         
| : s#>t+s  ( sector# -- track sect )    
 (s#>s+t  1+ swap ;                      
                                         
| : x,x ( sect track -- adr count)       
 base push  decimal                      
 0 <# #s drop Ascii , hold #s #> ;       
                                         
                                         
                                         
                                         
                                         
( readsector writesector      28may85re) 
                                         
100 | Constant b/sek                     
                                         
: readsector  ( adr tra# sect# -- flag)  
 disk 0F busout                          
 " u1:13,0," count   bustype             
 x,x bustype busoff pause                
 derror? ?exit                           
 disk 0D busin b/sek businput busoff     
 false ;                                 
                                         
: writesector  ( adr tra# sect# -- flag) 
 rot disk 0F busout                      
 " b-p:13,0" count bustype busoff        
 disk 0D busout b/sek bustype busoff     
 disk 0F busout                          
 " u2:13,0," count  bustype              
 x,x bustype busoff pause  derror? ;     
                                         
                                         
                                         
                                         
                                         
                                         
( 1541r/w                     28may85re) 
                                         
: diskopen  ( -- flag)                   
 disk 0D busopen  Ascii # bus! busoff    
 derror? ;                               
                                         
: diskclose ( -- )                       
 disk 0D busclose  busoff ;              
                                         
: 1541r/w  ( adr blk file r/wf -- flag)  
 swap Abort" no file"                    
 -rot  blk/drv /mod  dup (drv ! 3 u>     
 IF . ." beyond capacity" nip exit  THEN 
 diskopen  IF  drop nip exit  THEN       
 0 swap   2* 2* 4 bounds                 
 DO  drop  2dup I rot                    
     IF    s#>t+s readsector             
     ELSE  s#>t+s writesector THEN       
     >r b/sek + r> dup  IF  LEAVE  THEN  
 LOOP   -rot  2drop  diskclose  ;        
                                         
' 1541r/w  Is   r/w                      
                                         
                                         
                                         
\ index findex ink-pot         05nov87re 
                                         
: index ( from to --)                    
 1+ swap DO                              
   cr  I 2 .r  I block 1+  25  type      
   stop?  IF LEAVE THEN  LOOP ;          
                                         
: findex ( from to --)                   
 diskopen  IF  2drop  exit  THEN         
 1+ swap DO  cr  I 2 .r                  
   pad dup I 2* 2* s#>t+s readsector     
   >r 1+ 25 type                         
   r> stop? or IF LEAVE THEN             
 LOOP  diskclose  ;                      
                                         
Create ink-pot                           
    \ border bkgnd pen  0                
(C64  6 c,   6 c,  3 c, 0 c,   \ Forth   
     0E c,   6 c,  3 c, 0 c,   \ Edi     
      6 c,   6 c,  3 c, 0 c, ) \ User    
(C16 f6 c, 0f6 c, 03 c, 0 c,   \ Forth   
    0eE c, 0f6 c, 03 c, 0 c,   \ Edi     
    0f6 c, 0f6 c, 03 c, 0 c, ) \ User    
                                         
                                         
\ restore                      05nov87re 
                                         
(C16 \\ )                                
                                         
Label asave 0 c,    Label 1save 0 c,     
                                         
Label continue                           
 pha  1save lda  1 sta  pla  rti         
                                         
Label restore   sei  asave sta           
 continue $100 /mod                      
 # lda pha  # lda pha  php  \ for RTI    
 asave lda pha  txa pha  tya pha         
 1 lda 1save sta                         
 $36 # lda   1 sta  \ Basic off ROM on   
 $7F # lda  $DD0D sta                    
 $DD0D ldy  0< ?[                        
Label 6526-NMI $FE72 jmp  ]?             
 UDTIM jsr STOP jsr  \ RUN/STOP ?        
 6526-NMI bne        \ not >>-->         
 ' restart @ jmp  end-code               
                                         
                                         
                                         
                                         
\ C64:Init                     06nov87re 
(C16 \\ )                                
                                         
: init-system   $FF40 dup $C0 cmove      
 [ restore ] Literal  dup                
 $FFFA ! $318 ! ;  \ NMI-Vector to RAM   
                                         
Label first-init                         
 sei cld                                 
 IOINIT jsr  CINT jsr  RESTOR jsr        
  \ init. and set I/O-Vectors            
 $36 # lda   01 sta        \ Basic off   
 ink-pot    lda BrdCol sta \ border      
 ink-pot 1+ lda BkgCol sta \ backgrnd    
 ink-pot 2+ lda PenCol sta \ pen         
$80 # lda KeyRep sta  \ repeat all keys  
$17 # lda  $D018 sta  \ low/upp +        
  0 # lda  $D01A sta  \ VIC-IRQ off      
$1B # lda  $D011 sta  \ Textmode on      
  4 # lda   $288 sta  \ low screen       
 cli rts end-code                        
first-init dup bootsystem 1+ !           
               warmboot   1+ !           
Code c64init first-init jsr              
 xyNext jmp end-code                     
\ C16:Init                01oct87clv/re) 
                                         
(C64 \\ )                                
                                         
Code init-system $F7 # ldx  txs          
 xyNext jmp end-code                     
                                         
$fcb3 >label IRQ   \ normal IRQ          
$fffe >label >IRQ  \ 6502-Ptr to IRQ     
                                         
\ selfmodifying code:                    
Label RAMIRQ       \ the new IRQ         
   rom RAMIRQ $15 + sta RAMIRQ $17 + stx 
(  +9) RAMIRQ $1b + $100 u/mod # lda pha 
                               # lda pha 
(  +f) tsx $103 ,x lda pha   \ flags     
( +14) 0 # lda 0 # ldx IRQ jmp           
( +1b) ram rti end-code                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ C16:..Init              01oct87clv/re) 
                                         
(C64 \\ )                                
                                         
Label first-init                         
   \ will be called in ROM first time    
   \ later called from RAM               
 sei rom                                 
 RAMIRQ $100 u/mod    \ new IRQ          
   # lda >IRQ 1+ sta  \ .. install       
   # lda >IRQ sta                        
 $FF84 normJsr  $FF8A normJsr            
    \ CIAs init. and set I/O-Vectors     
 ink-pot    lda BrdCol sta \ border      
 ink-pot 1+ lda BkgCol sta \ backgrnd    
 ink-pot 2+ lda PenCol sta \ pen         
 $80 # lda KeyRep sta \ repeat all keys  
 $FF13 lda 04 # ora $FF13 sta \ low/upp  
 ram cli rts end-code                    
                                         
first-init dup bootsystem 1+ !           
               warmboot   1+ !           
                                         
Code c64init first-init jsr              
 xyNext jmp end-code                     
\ C16-Pushkeys C64-like   01oct87clv/re) 
                                         
                                         
(C16                                     
                                         
Label InitPKs \ Pushkeys: Daten          
00 c, 00 c,  \ curr. numb Char, currPtr  
01 c, 01 c, 01 c, 01 c, \ StrLength      
01 c, 01 c, 01 c, 01 c, \   "            
                                         
85 c, 86 c, 87 c, 89 c, \ Content        
8a c, 8b c, 8c c, 88 c, \   "            
                                         
                                         
here InitPKs - >label InitPKlen          
                                         
                                         
Code C64fkeys \ Pushkeys a la C64        
  InitPKlen # ldx                        
  [[ dex  0>= ?[[                        
    InitPKs ,X lda PKeys ,x sta ]]?      
  xyNext jmp end-code                    
                                         
)                                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( restart param.-passing     clv12.4.87) 
                                         
Code restart       here >restart !       
 ' (restart >body 100 u/mod              
 # lda  pha  # lda pha                   
 warmboot jmp   end-code                 
                                         
\ Code for parameter-passing to Forth    
                                         
                                         
      03 18 +thru     \ CBM-Interface    
(c16+ 19 1a +thru )   \ c16init RamIRQ   
                                         
Host  ' Transient 8 + @                  
  Transient  Forth  Context @ 6 + !      
Target     \ kotz wuerg !                
                                         
Forth also definitions                   
         : )     ; immediate             
(C64     : (C64  ; immediate )           
(C16     : (C16  ; immediate )           
(C64 \ ) : (C64  [compile] ( ; immediate 
(C16 \ ) : (C16  [compile] ( ; immediate 
: forth-83 ;  \ last word in Dictionary  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ Directory ultraFORTH 3of4   26oct87re 
                                         
.                   &0                   
..                  &0                   
rom-ram-sys         &2                   
Transient-Assembler &4                   
Assembler-6502      &5                   
2words             &14                   
unlink             &15                   
scr<>cbm           &16                   
(search            &17                   
Editor             &19                   
.blk               &46                   
Tracer/Tools       &47                   
Multi-Tasker       &57                   
EpsonRX80          &63                   
VC1526             &75                   
CP-80              &78                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ Content volksForth 3.81.02 cas16aug06 
                                         
                                         
rom ram sys          2 - 3               
Transient Assembler  4                   
Assembler-6502       5 - 12              
                    13       free        
2words              14                   
unlink              15                   
scr<>cbm            16                   
(search             17                   
Editor              19                   
.blk                46                   
Tracer Tools        47                   
Multi-Tasker        57                   
Printer: EpsonRX80  63                   
Printer: VC1526     75                   
Printer: CP-80      78                   
                                         
Shadows             85 ...               
                                         
                                         
                                         
                                         
                                         
\ rom ram sys                 cas16aug06 
\              Shadow with Ctrl+W--->    
                                         
\ needed for jumps                       
\ in the ROM Area                        
                                         
Assembler also definitions               
(16 \ Switch Bank 8000-FFFF              
: rom here 9 + $8000 u> abort" not here" 
       $ff3e sta ;                       
: ram  $ff3f sta ;                       
: sys rom jsr ram ;                      
\  if suffering from abort" not here"    
\  see next screen Screen --> C)         
                                         
                                         
(64 \ Switch Bank A000-BFFF              
: rom here 9 + $A000 u> abort" not here" 
      $37 # lda 1 sta ;                  
: ram $36 # lda 1 sta ;                  
C)                                       
                                         
                                         
                                         
                                         
\ sysMacro Long               cas16aug06 
                                         
(64  .( not for C64 !) \\ C)             
                                         
\ for advanced users, use macros         
                                         
here $8000 $20 - u> ?exit \ not possible 
                                         
                                         
' 0 | Alias ???                          
                                         
Label long   ROM                         
Label long1  ??? jsr  RAM  rts end-code  
                                         
| : sysMacro ( adr -- )                  
 $100 u/mod  pha  # lda  long1 2+ sta    
 # lda  long1 1+ sta  pla  long jsr ;    
                                         
: sys ( adr -- ) \ for Jsr to ROM        
 here 9 + $8000 u>                       
 IF  sysMacro  ELSE  sys  THEN ;         
                                         
                                         
                                         
                                         
\ transient Assembler         clv10oct87 
                                         
\ Basis: Forth Dimensions VOL III No. 5) 
                                         
\ internal loading         04may85BP/re) 
                                         
here   $800 hallot  heap dp !            
                                         
         1  +load                        
                                         
dp !                                     
                                         
Onlyforth                                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Forth-6502 Assembler        clv10oct87 
                                         
\ Basis: Forth Dimensions VOL III No. 5) 
                                         
Onlyforth  Assembler also definitions    
                                         
1 7  +thru                               
 -3  +load \ Makros: rom ram sys         
                                         
Onlyforth                                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Forth-83 6502-Assembler      20oct87re 
                                         
: end-code   context 2- @  context ! ;   
                                         
Create index                             
$0909 , $1505 , $0115 , $8011 ,          
$8009 , $1D0D , $8019 , $8080 ,          
$0080 , $1404 , $8014 , $8080 ,          
$8080 , $1C0C , $801C , $2C80 ,          
                                         
| Variable mode                          
                                         
: Mode:  ( n -)   Create c,              
  Does>  ( -)     c@ mode ! ;            
                                         
0   Mode: .A        1    Mode: #         
2 | Mode: mem       3    Mode: ,X        
4   Mode: ,Y        5    Mode: X)        
6   Mode: )Y       $F    Mode: )         
                                         
                                         
                                         
                                         
                                         
                                         
\ upmode  cpu                  20oct87re 
                                         
| : upmode ( addr0 f0 - addr1 f1)        
 IF mode @  8 or mode !   THEN           
 1 mode @  $F and ?dup IF                
 0 DO  dup +  LOOP THEN                  
 over 1+ @ and 0= ;                      
                                         
: cpu  ( 8b -)   Create  c,              
  Does>  ( -)    c@ c, mem ;             
                                         
 00 cpu brk $18 cpu clc $D8 cpu cld      
$58 cpu cli $B8 cpu clv $CA cpu dex      
$88 cpu dey $E8 cpu inx $C8 cpu iny      
$EA cpu nop $48 cpu pha $08 cpu php      
$68 cpu pla $28 cpu plp $40 cpu rti      
$60 cpu rts $38 cpu sec $F8 cpu sed      
$78 cpu sei $AA cpu tax $A8 cpu tay      
$BA cpu tsx $8A cpu txa $9A cpu txs      
$98 cpu tya                              
                                         
                                         
                                         
                                         
                                         
\ m/cpu                        20oct87re 
                                         
: m/cpu  ( mode opcode -)  Create c, ,   
 Does>                                   
 dup 1+ @ $80 and IF $10 mode +! THEN    
 over $FF00 and upmode upmode            
 IF mem true Abort" invalid" THEN        
 c@ mode @ index + c@ + c, mode @ 7 and  
 IF mode @  $F and 7 <                   
  IF c, ELSE , THEN THEN mem ;           
                                         
$1C6E $60 m/cpu adc $1C6E $20 m/cpu and  
$1C6E $C0 m/cpu cmp $1C6E $40 m/cpu eor  
$1C6E $A0 m/cpu lda $1C6E $00 m/cpu ora  
$1C6E $E0 m/cpu sbc $1C6C $80 m/cpu sta  
$0D0D $01 m/cpu asl $0C0C $C1 m/cpu dec  
$0C0C $E1 m/cpu inc $0D0D $41 m/cpu lsr  
$0D0D $21 m/cpu rol $0D0D $61 m/cpu ror  
$0414 $81 m/cpu stx $0486 $E0 m/cpu cpx  
$0486 $C0 m/cpu cpy $1496 $A2 m/cpu ldx  
$0C8E $A0 m/cpu ldy $048C $80 m/cpu sty  
$0480 $14 m/cpu jsr $8480 $40 m/cpu jmp  
$0484 $20 m/cpu bit                      
                                         
                                         
\ Assembler conditionals       20oct87re 
                                         
| : range?   ( branch -- branch )        
 dup abs  $7F u> Abort" out of range " ; 
                                         
: [[  ( BEGIN)  here ;                   
                                         
: ?]  ( UNTIL)  c, here 1+ - range? c, ; 
                                         
: ?[  ( IF)     c,  here 0 c, ;          
                                         
: ?[[ ( WHILE)  ?[ swap ;                
                                         
: ]?  ( THEN)   here over c@  IF swap !  
 ELSE over 1+ - range? swap c! THEN ;    
                                         
: ][  ( ELSE)   here 1+   1 jmp          
 swap here over 1+ - range?  swap c! ;   
                                         
: ]]  ( AGAIN)  jmp ;                    
                                         
: ]]? ( REPEAT) jmp ]? ;                 
                                         
                                         
                                         
\ Assembler conditionals       20oct87re 
                                         
$90 Constant CS     $B0 Constant CC      
$D0 Constant 0=     $F0 Constant 0<>     
$10 Constant 0<     $30 Constant 0>=     
$50 Constant VS     $70 Constant VC      
                                         
: not    $20 [ Forth ] xor ;             
                                         
: beq    0<> ?] ;   : bmi   0>= ?] ;     
: bne    0=  ?] ;   : bpl   0<  ?] ;     
: bcc    CS  ?] ;   : bvc   VS  ?] ;     
: bcs    CC  ?] ;   : bvs   VC  ?] ;     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ 2inc/2dec   winc/wdec        20oct87re 
                                         
: 2inc  ( adr -- )                       
 dup lda  clc  2 # adc                   
 dup sta  CS ?[  swap 1+ inc  ]?  ;      
                                         
: 2dec  ( adr -- )                       
 dup lda  sec  2 # sbc                   
 dup sta  CC ?[  swap 1+ dec  ]?  ;      
                                         
: winc  ( adr -- )                       
 dup inc  0= ?[  swap 1+ inc  ]?  ;      
                                         
: wdec  ( adr -- )                       
 dup lda  0= ?[  over 1+ dec  ]?  dec  ; 
                                         
: ;c:                                    
 recover jsr  end-code ]  0 last !  0 ;  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ;code Code code>          bp/re03feb85 
                                         
Onlyforth                                
                                         
: Assembler                              
 Assembler   [ Assembler ] mem ;         
                                         
: ;Code                                  
 [compile] Does>  -3 allot               
 [compile] ;      -2 allot   Assembler ; 
immediate                                
                                         
: Code  Create here dup 2- ! Assembler ; 
                                         
: >label  ( adr -)                       
 here | Create  immediate  swap ,        
 4 hallot heap 1 and hallot ( 6502-alig) 
 here 4 - heap  4  cmove                 
 heap last @ count $1F and + !  dp !     
  Does>  ( - adr)   @                    
  state @ IF  [compile] Literal  THEN ;  
                                         
: Label                                  
 [ Assembler ]  here >label Assembler ;  
                                         
\ free                        cas16aug06 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ 2! 2@ 2variable 2constant clv20aug87re 
                                         
Code 2!  ( d adr --)                     
 tya  setup jsr  3 # ldy                 
 [[  SP )Y lda  N )Y sta  dey  0< ?]     
 1 # ldy  Poptwo jmp  end-code           
                                         
Code 2@  ( adr -- d)                     
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 SP 2dec  3 # ldy                        
 [[  N )Y lda  SP )Y sta  dey  0< ?]     
 xyNext jmp  end-code                    
                                         
: 2Variable  ( --)   Create 4 allot ;    
             ( -- adr)                   
                                         
: 2Constant  ( d --)   Create , ,        
  Does> ( -- d)   2@ ;                   
                                         
\ 2dup  exists                           
\ 2swap exists                           
\ 2drop exists                           
                                         
                                         
                                         
\ unlink                    clv20aug87re 
                                         
$FFF0 >label plot                        
                                         
(64                                      
                                         
Code unlink  ( -- )                      
  $288 lda  $80 # ora  tay  txa          
  [[  $D9 ,X sty  clc  $28 # adc         
   CS ?[  iny  ]?  inx  $1A # cpx  0= ?] 
  $D3 lda  $28 # cmp                     
  CS ?[  $28 # sbc  $D3 sta  ]?          
  $D3 ldy  $D6 ldx  clc  plot jsr C)     
                                         
(16 : unlink  0 0  $7EE 2! ; C)          
(65n : unlink ; C)                       
                                         
Label setptrs                            
 0 # ldx  1 # ldy  Next jmp  end-code    
                                         
                                         
                                         
                                         
                                         
                                         
\ changing codes              cas16aug06 
                                         
( mapping commodore screen codes       ) 
                                         
                                         
Label (scr>cbm                           
 N 6 + sta $3F # and  N 6 + asl          
 N 6 + bit  0< ?[ $80 # ora  ]?          
            VC ?[ $40 # ora  ]?  rts     
                                         
Label (cbm>scr                           
 N 6 + sta $7F # and $20 # cmp           
 CS ?[ $40 # cmp                         
    CS ?[ $1F # and  N 6 + bit           
       0< ?[ $40 # ora  ]?  ]?  rts  ]?  
 Ascii . # lda  rts                      
                                         
Code cbm>scr  ( 8b1 -- 8b2)              
 SP X) lda  (cbm>scr jsr  SP X) sta      
 Next jmp  end-code                      
                                         
Code scr>cbm  ( 8b1 -- 8b2)              
 SP X) lda  (scr>cbm jsr  SP X) sta      
 Next jmp  end-code                      
                                         
\ fast search                 cas16aug06 
                                         
\needs Code -$D +load \ Trans Assembler  
                                         
Onlyforth                                
                                         
 ' 0< @ 4 +  >label puttrue              
puttrue 3 +  >label putfalse             
                                         
Code (search                             
( text tlen buffer blen -- adr tf / ff)  
 7 # ldy                                 
 [[  SP )Y lda  N ,Y sta dey  0< ?]      
 [[ N 4 + lda  N 5 + ora  0<> ?[         
 [[ N     lda   N 1+ ora  0<> ?[         
    N 2+ X) lda  N 6 + X) cmp  swap      
    0<> ?[[  N wdec  N 2+ winc  ]]?      
                                         
-->                                      
                                         
                                         
                                         
                                         
                                         
                                         
\ Edior fast search           cas16aug06 
                                         
 7 # ldy                                 
 [[  N ,Y lda  SP )Y sta  dey  0< ?]     
 [[  N 2+ winc  N 6 + winc  N wdec       
 N 4 + wdec  N 4 + lda  N 5 + ora        
 0= ?[  SP lda  clc  4 # adc  SP sta     
        CS ?[  SP 1+ inc  ]?             
        3 # ldy  N 3 + lda  SP )Y sta    
        N 2+ lda  dey  SP )Y sta  dey    
        puttrue jmp  ]?                  
 N lda  N 1+ ora  0= ?[                  
 3 roll  3 roll ]? ]?                    
 SP lda  clc  6 # adc  SP sta            
 CS ?[  SP 1+ inc ]?   1 # ldy           
 putfalse jmp  ]?                        
 N 2+ X) lda  N 6 + X) cmp  0= not ?]    
 7 # ldy                                 
 [[ SP )Y lda  N ,Y sta  dey  0< ?]      
 N wdec  N 2+ winc                       
 ( next char as first )  ]]  end-code    
                                         
                                         
                                         
                                         
\ Editor loadscreen           clv13jul87 
\ Idea and first implementation:  WE/re  
                                         
Onlyforth                                
\needs .blk       $1B +load \ .blk       
\needs Code       -$F +load \ Assembl    
\needs (search     -2 +load \ (search    
                                         
Onlyforth                                
(64 | : at  at curoff ; C) \ sorry       
                                         
\needs 2variable  -5 +load               
\needs unlink     -4 +load  \ unlink     
\needs scr>cbm    -3 +load  \ cbm><scr   
                                         
Vocabulary Editor                        
Editor also definitions                  
                                         
                1 $17 +thru  \ Editor    
              $18 $19 +thru  \ edit-view 
                  $1A +load  \ Ediboard  
                                         
Onlyforth  1 scr !  0 r# !               
                                         
save                                     
\ Edi Constants Variables     clv15jul87 
                                         
$28 | Constant #col $19 | Constant #row  
#col  #row  *           | Constant b/scr 
  Variable shadow   $55 shadow !         
| Variable ascr     1 ascr !             
|  Variable imode   imode off            
| Variable char     #cr char !           
| Variable scroll   scroll on            
| Variable send     1 send !             
| 2variable chars   | 2variable lines    
| 2variable fbuf    | 2variable rbuf     
                                         
(64 $288 C)  (16 $53e C) (65n $d061 C)   
>Label scradr                            
$d800 (16 drop $800 C) >Label coladr     
                                         
$d1  (16 drop $c8 C) (65n drop $e0 C)    
$d3  (16 drop $ca C) (65n drop $ec C)    
| Constant curofs  | Constant linptr     
$D020 (16 drop $ff19 C)                  
(64 $286  C) (16 $53b C) (65n $f1 C)     
| Constant pen | Constant border         
$d021 (16 drop $ff15 C)                  
| Constant bkgrnd                        
\ Edi special cmoves          cas16aug06 
( thanks to commodore....          )     
                                         
Label incpointer                         
 N    lda  clc  #col 1+ # adc            
 N    sta  CS ?[  N 1+  inc  ]?          
 N 2+ lda  clc  #col    # adc            
 N 2+ sta  CS ?[  N 3 + inc  ]?  rts     
                                         
| Code b>sc   ( blkadr --)               
 tya  setup jsr                          
 N 2+ stx  scradr lda  N 3 + sta         
 #row # ldx                              
 [[  #col 1- # ldy                       
     [[  N    )Y lda  (cbm>scr jsr       
         N 2+ )Y sta  dey  0< ?]         
     incpointer jsr  dex                 
 0= ?]                                   
 pen lda                                 
 [[ coladr        ,X sta                 
    coladr $100 + ,X sta                 
    coladr $200 + ,X sta                 
    coladr $300 + ,X sta                 
    inx  0= ?]  setptrs jmp   end-code   
                                         
\ Edi special cmoves cont.    cas16aug06 
( ... for screen format                ) 
                                         
| Code sc>b   ( blkadr --)               
 tya  setup jsr                          
 N 2+ stx  scradr lda  N 3 + sta         
 #row # ldx                              
 [[  0 # ldy                             
     [[  N 2+ )Y lda  (scr>cbm jsr       
         N )Y sta  iny  #col # cpy CS ?] 
     dex                                 
 0<> ?[[                                 
     bl # lda  N )Y sta                  
     incpointer jsr                      
 ]]?  setptrs jmp  end-code              
                                         
| Code >scrmove  ( from to 8bquan --)    
 3 # lda  setup jsr  dey                 
 [[  N cpy  0= ?[  setptrs jmp  ]?       
     N 4 + )Y lda  (cbm>scr jsr          
     N 2+  )Y sta  iny  0= ?]  end-code  
                                         
                                         
                                         
                                         
\ Edi changed?                cas16aug06 
                                         
| Code changed?   ( blkadr -- f)         
 tya  setup jsr                          
 N 2+ stx  scradr lda  N 3 + sta         
 #row # ldx                              
 [[  #col 1- # ldy                       
     [[  N )Y lda  (cbm>scr jsr          
         N 2+ )Y cmp                     
         0<> ?[  $FF # lda  PushA jmp ]? 
         dey 0<  ?]                      
     incpointer jsr  dex                 
 0= ?]                                   
 txa  PushA jmp  end-code                
                                         
| : memtop  sp@ #col 2* - ;              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Edi c64-specials           clv2:jull87 
                                         
| Code scrstart  ( -- adr)               
 txa pha scradr lda  Push jmp end-code   
                                         
                                         
| Code rowadr  ( -- adr)                 
 curofs lda  #col # cmp  txa             
 CS ?[  #col 1- # lda  ]?                
 linptr adc pha linptr 1 + lda  0 # adc  
 Push jmp  end-code                      
                                         
| Code curadr  ( -- adr)                 
 clc curofs lda linptr adc  pha          
 linptr 1 + lda 0 # adc Push jmp         
 end-code                                
(64                                      
| Code unlinked?     \ -- f              
 $D5 lda  #col # cmp  CC ?[  dex  ]?     
 txa  PushA jmp  end-code C)             
                                         
                                         
                                         
                                         
                                         
\ Edi scroll? put/insert/do  clv2:jull87 
                                         
| : blank.end?  ( -- f)                  
 scrstart [ b/scr #col - ] Literal +     
 #col -trailing nip  0=  scroll @ or ;   
                                         
| : atlast?  ( -- f)                     
 curadr  scrstart b/scr + 1-  =          
 scroll @ 0=  and ;                      
                                         
| : putchar  ( -- f)                     
 char c@ con! false ;                    
                                         
| : insert  ( -- f)                      
 atlast?  ?dup ?exit                     
(64  unlinked? C) (16 true C)            
 rowadr #col + 1- c@  bl = not  and      
 blank.end? not  and  dup ?exit          
 $94 con! ;                              
                                         
| : dochar  ( -- f)                      
 atlast?  ?dup ?exit                     
 imode @ IF insert ?dup ?exit            
 THEN putchar ;                          
                                         
\ Edi cursor control          cas16aug06 
                                         
| : curdown  ( -- f)                     
 scroll @ 0=  row  #row 2-  u>  and      
 dup ?exit $11 con! ;                    
                                         
| : currite  ( -- f)                     
 atlast? dup ?exit $1D con! ;            
                                         
' putchar | Alias curup                  
' putchar | Alias curleft                
' putchar | Alias home                   
' putchar | Alias delete                 
                                         
| : >""end  ( -- ff)                     
 scrstart b/scr -trailing nip            
 b/scr 1- min #col /mod swap at false ;  
                                         
| : +tab  ( -- f)                        
 0  $a 0 DO  drop currite dup            
            IF LEAVE THEN  LOOP ;        
                                         
| : -tab  ( -- f)                        
 5 0 DO $9D con!  LOOP  false ;          
                                         
\ Edi cr, clear/newline       cas16aug06 
                                         
| : <cr>  ( -- f)                        
 row 0 at  unlink  imode off  curdown ;  
                                         
| : clrline  ( -- ff)                    
 rowadr #col bl fill false ;             
                                         
| : clrright  ( -- ff)                   
 curadr #col col - bl fill false ;       
                                         
| : killine  ( -- f)                     
 rowadr dup #col + swap                  
 scrstart $3C0 + dup >r                  
 over - cmove                            
 r> #col bl fill false ;                 
                                         
| : newline  ( -- f)                     
 blank.end? not  ?dup ?exit              
 rowadr dup #col + scrstart b/scr +      
 over - cmove>  clrline ;                
                                         
                                         
                                         
                                         
\ Edi character handling      cas16aug06 
                                         
| : dchar  ( -- f)                       
 currite  dup ?exit $14 con! ;           
                                         
| : @char  ( -- f)                       
 chars 2@ + 1+  lines @ memtop min       
 u>  dup ?exit                           
 curadr c@  chars 2@ +  c!               
 1 chars 2+ +! ;                         
                                         
| : copychar  ( -- f)                    
 @char  ?dup ?exit  currite ;            
                                         
| : char>buf  ( -- f)                    
 @char  ?dup ?exit  dchar ;              
                                         
| : buf>char  ( -- f)                    
 chars 2+ @ 0=  ?dup ?exit               
 insert        dup ?exit                 
 -1 chars 2+ +!                          
 chars 2@ +  c@  curadr c! ;             
                                         
                                         
                                         
\ Edi line handling, imode    cas16aug06 
                                         
| : @line  ( -- f)                       
 lines 2@ +  memtop  u>  dup ?exit       
 rowadr  lines 2@ +  #col  cmove         
 #col lines 2+ +! ;                      
                                         
| : copyline  ( -- f)                    
 @line  ?dup ?exit  curdown ;            
                                         
| : line>buf  ( -- f)                    
 @line  ?dup ?exit  killine ;            
                                         
| : !line  ( --)                         
 #col negate lines 2+ +!                 
 lines 2@ +  rowadr  #col  cmove  ;      
                                         
| : buf>line  ( -- f)                    
 lines 2+ @ 0=  ?dup ?exit               
 newline  dup ?exit  !line ;             
                                         
| : setimd  ( -- f)   imode on false ;   
                                         
| : clrimd  ( -- f)   imode off false ;  
                                         
\ Edi the stamp               cas16aug06 
                                         
Forth definitions                        
: rvson $12 con! ;  : rvsoff $92 con! ;  
                                         
Code ***volksFORTH83***                  
     Next here 2- !  end-code            
: Forth-Gesellschaft   [compile] \\ ;    
immediate                                
                                         
Editor definitions                       
Create stamp$ $12 allot stamp$ $12 erase 
                                         
| : .stamp  ( -- ff)                     
 stamp$ 1+ count  scrstart #col +        
 over -   swap >scrmove false ;          
                                         
: getstamp  ( --)                        
 input push  keyboard  stamp$ on         
 cr ." your stamp: "  rvson $10 spaces   
 row $C at  stamp$ 2+ $10 expect         
 rvsoff  span @ stamp$ 1+ c! ;           
                                         
| : stamp?  ( --)                        
 stamp$ c@ ?exit getstamp ;              
\ Edi the screen#             cas16aug06 
                                         
| : savetop  ( --)                       
 scrstart pad #col 2* cmove              
 scrstart #col 2* $A0 fill ;             
| : resttop  ( --)                       
 pad scrstart #col 2* cmove ;            
| : updated?  ( scr# -- n)               
 block 2- @ ;                            
| : special  ( --)                       
 curon BEGIN pause key? UNTIL curoff ;   
                                         
| : drvScr ( --drv scr')                 
 scr @ offset @ + blk/drv u/mod swap ;   
                                         
| : .scr#  ( -- ff) at? savetop  rvson   
 0 0 at drvScr ." Scr # " . ." Drv " .   
 scr @ updated? 0=                       
 IF ." not " THEN ." updated"  1 1 at    
 [ ' ***volksFORTH83*** >name ] Literal  
 count type 2 spaces                     
 [ ' Forth-Gesellschaft >name ] Literal  
 count $1F and type                      
 rvsoff at special resttop false ;       
                                         
\ Edi exits                   cas16aug06 
                                         
| : at?>r#  ( --)                        
 at? swap #col 1+ * + r# ! ;             
                                         
| : r#>at  ( --)                         
 r# @  dup  #col 1+  mod  #col =  -      
 b/blk 1- min  #col 1+  /mod  swap at ;  
                                         
| : cancel  ( -- n)                      
 unlink  %0001  at?>r# ;                 
                                         
| : eupdate ( -- n)                      
 cancel  scr @ block changed?            
 IF .stamp drop  scr @ block sc>b        
    update %0010 or THEN ;               
                                         
| : esave   ( -- n)   eupdate %0100 or ; 
                                         
| : eload   ( -- n)   esave   %1000 or ; 
                                         
                                         
                                         
                                         
                                         
\ leaf thru Edi               clv01aug87 
                                         
| : elist  ( -- ff)                      
 scr @ block b>sc  imode off  unlink     
 r#>at  false ;                          
                                         
| : next    ( -- ff)                     
 eupdate drop  1 scr +!  elist ;         
                                         
| : back    ( -- ff)                     
 eupdate drop -1 scr +!  elist ;         
                                         
| : >shadow  ( -- ff)                    
 eupdate drop  shadow @ dup drvScr nip   
 u> not IF negate THEN  scr +!  elist ;  
                                         
| : alter  ( -- ff)                      
 eupdate drop  ascr @  scr @             
 ascr !  scr !  elist ;                  
                                         
                                         
                                         
                                         
                                         
                                         
\ Edi digits                    2oct87re 
                                         
Forth definitions                        
                                         
: digdecode  ( adr cnt1 key -- adr cnt2) 
 #bs case?   IF  dup  IF                 
                 del 1- THEN exit THEN   
 #cr case?   IF  dup span !  exit THEN   
 capital dup digit?                      
 IF  drop >r 2dup + r@ swap c!           
     r> emit  1+  exit  THEN  drop ;     
                                         
Input: digits                            
 c64key c64key? digdecode c64expect ;    
                                         
Editor definitions                       
                                         
| : replace  ( -- f)                     
 fbuf @ 0 DO  #bs con!  LOOP             
 false rbuf @ 0 DO insert or LOOP        
 dup ?exit                               
 rbuf 2@ curadr swap >scrmove            
 eupdate drop ;                          
                                         
                                         
\ Edi >bufs                   cas16aug06 
                                         
| : .buf  ( adr count --)                
 type Ascii < emit                       
 #col 1- col - spaces ;                  
                                         
| : >bufs  ( --)                         
 input push                              
 unlink savetop at?  rvson               
 1 0 at ." replace with: "               
 at? rbuf 2@ .buf                        
 0 0 at ." >     search: "               
 at? fbuf 2@ .buf                        
 0 2  2dup at  send @ 3 u.r  2dup at     
 here 1+ 3 digits expect  span @ ?dup    
 IF  here under c!  number drop send !   
     THEN  at  send @ 3 u.r  keyboard    
 2dup at fbuf 2+ @  #col 2- col - expect 
 span @ ?dup IF  fbuf !  THEN            
 at fbuf 2@ .buf                         
 2dup at rbuf 2+ @  #col 2- col - expect 
 span @ ?dup IF  rbuf !  THEN            
 at rbuf 2@ .buf                         
 rvsoff resttop at ;                     
                                         
\ Edi esearch                 clv06aug87 
                                         
| : (f      elist drop                   
 fbuf 2@  r# @  scr @ block  +           
 b/blk r# @ - (search 0=                 
 IF  0  ELSE  scr @ block -  THEN        
 r# !  r#>at ;                           
                                         
| : esearch  ( -- f)                     
 eupdate drop  >bufs                     
 BEGIN BEGIN  (f  r# @                   
       WHILE  key  dup Ascii r =         
              IF replace ?dup            
                 IF nip exit THEN THEN   
              3 = ?dup ?exit             
       REPEAT  drvScr nip send @ -       
       stop? 0= and ?dup                 
 WHILE 0< IF   next drop                 
          ELSE back drop THEN            
 REPEAT true ;                           
                                         
                                         
                                         
                                         
                                         
\ Edi keytable                cas16aug06 
| : Ctrl  ( -- 8b)                       
 [compile] Ascii $40 - ; immediate       
| Create keytable                        
Ctrl n c, Ctrl b c, Ctrl w c, Ctrl a c,  
$1F c, Ctrl ^       (16 drop $92 C) c,   
$0D c,   $8D c,                          
Ctrl c c, Ctrl x c, Ctrl f c, Ctrl l c,  
$85 c,   $89 c,    $86 c,    $8A c,      
$9F c,   $1C c,   00 (16 drop $1e C) c,  
$8B c,   $87 c,    $88 c,    $8C c,      
$1D c,   $11 c,    $9D c,    $91 c,      
$13 c,   $93 c,    $94 c,                
$14 c,    Ctrl d c, Ctrl e c, Ctrl r c,  
Ctrl i c, Ctrl o c,                      
                             $ff c,      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Edi actiontable             cas16aug06 
                                         
                                         
| Create actiontable ]                   
next      back      >shadow   alter      
esearch   copyline                       
<cr>      <cr>                           
cancel    eupdate   esave     eload      
newline   killine   buf>line  line>buf   
.stamp    .scr#           copychar       
char>buf  buf>char  +tab      -tab       
currite   curdown   curleft   curup      
home      >""end    insert               
delete    dchar     clrline   clrright   
setimd    clrimd                         
                              dochar  [  
| Code findkey  ( key n -- adr)          
 2 # lda  setup jsr  N ldy  dey          
 [[  iny  keytable ,Y lda  $FF # cmp     
     0<> ?[  N 2+ cmp  ]?  0= ?]         
 tya  .A asl  tay                        
 actiontable    ,Y lda  pha              
 actiontable 1+ ,Y lda  Push jmp         
end-code                                 
                                         
\ Edi show errors             cas16aug06 
                                         
                                         
' 0   | Alias dark                       
                                         
' 1   | Alias light                      
                                         
| : half  ( n --)                        
 border c!  pause $80 0 DO LOOP ;        
                                         
| : blink ( --)                          
 border push  dark half light half       
              dark half light half ;     
                                         
| : ?blink ( f1 -- f2)                   
 dup true = IF  blink 0=  THEN ;         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Edi init                    cas16aug06 
                                         
' Literal | Alias Li  immediate          
                                         
Variable (pad       0 (pad !             
                                         
| : clearbuffer  ( --)                   
 pad       dup  (pad  !                  
 #col 2* + dup  fbuf  2+ !               
 #col    + dup  rbuf  2+ !               
 #col    + dup  chars !                  
 #col 2* +      lines !                  
 chars 2+ off  lines 2+ off              
 [ ' ***volksFORTH83*** >name ] Li       
 count >r fbuf 2+ @ r@ cmove r> fbuf !   
 [ ' Forth-Gesellschaft >name ] Li       
 count $1F and >r                        
 rbuf 2+ @ r@ cmove r> rbuf ! ;          
                                         
| : initptr ( --)                        
 pad (pad @ = ?exit clearbuffer ;        
                                         
                                         
                                         
                                         
\ Edi show                    cas16aug06 
                                         
' name >body 6 +  | Constant 'name       
(16 \ c16 is using standard C)           
                                         
(64                                      
| Code curon                             
 $D3 ldy    $D1 )Y lda  $CE sta          
 $80 # eor  $D1 )Y sta                   
 xyNext jmp  end-code                    
                                         
| Code curoff                            
 $CE lda  $D3 ldy  $D1 )Y sta            
 xyNext jmp  end-code                    
                                         
C)                                       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Edi show                    cas16aug06 
                                         
| : showoff                              
 ['] exit 'name !  rvsoff  curoff ;      
                                         
| : show  ( --)                          
 blk @ ?dup 0= IF  showoff exit  THEN    
 >in @ 1-  r# !  rvsoff curoff rvson     
 scr @  over - IF  scr !  elist          
 1 0 at .status THEN r#>at curon drop ;  
                                         
Forth definitions                        
                                         
: (load  ( blk pos --)                   
 >in push  >in !  ?dup 0= ?exit          
 blk push  blk !  .status interpret ;    
                                         
: showload  ( blk pos -)                 
 scr push  scr off  r# push              
 ['] show 'name ! (load showoff ;        
                                         
Editor definitions                       
                                         
                                         
                                         
\ Edi edit                    clv01aug87 
| : setcol ( 0 / 4 / 8 --)               
 ink-pot +                               
 dup c@ border c! dup 1+ c@ bkgrnd c!    
  2+ c@ pen c! ;                         
| : (edit  ( -- n)                       
 4 setcol $93 con!                       
 elist drop  scroll off                  
 BEGIN key dup char c!                   
   0 findkey execute ?blink ?dup UNTIL   
 0 0 at killine drop  scroll on          
 0 setcol (16 0 $7ea c! C) \ Append-Mode 
;                                        
Forth definitions                        
: edit ( scr# -) (16 c64fkeys C)         
 scr !  stamp?  initptr  (edit           
 $18 0 at  drvScr ." Scr " . ." Drv " .  
 dup 2 and 0=  IF ." not "     THEN      
                  ." changed"            
 dup 4 and     IF save-buffers THEN      
 dup 6 and 6 = IF ." , saved"  THEN      
     8 and     IF ." , loading" cr       
       scr @  r# @  showload   THEN ;    
                                         
                                         
\ Editor Forth83             clv2:jull87 
                                         
: l  ( scr -)   r# off  edit ;           
: r  ( -)       scr @ edit ;             
: +l ( n -)     scr @ + l ;              
                                         
: v  ( -) ( text)                        
 '  >name  ?dup IF  4 - @  THEN  ;       
                                         
: view  ( -) ( text)                     
 v ?dup                                  
 IF  l  ELSE  ." from keyboard"  THEN ;  
                                         
Editor definitions                       
\ todo: redundant with curadr above      
(16 | : curaddr \ --Addr                 
     linptr @ curofs c@ + ; C)           
                                         
: curlin  ( --curAddr linLen) \ & EOLn   
(64 linptr @ $D5 c@ -trailing            
   dup $d3 c! C)                         
(65n linptr @ $EC c@ -trailing C)        
(16 $1b con! ascii j con! curaddr        
    $1b con! ascii k con! $1d con!       
     curaddr  over - C) ;                
\ Edidecode                  ccas16aug06 
                                         
: edidecode  ( adr cnt1 key -- adr cnt2) 
 $8D case? IF  imode off cr exit  THEN   
 #cr case? IF  imode off                 
curlin dup span @ u> IF drop span @ THEN 
  bounds ?DO                             
  2dup +  I c@ scr>cbm  swap c!  1+ LOOP 
  dup span !  exit  THEN                 
 dup char c!                             
 $12 findkey execute ?blink drop ;       
                                         
                                         
: ediexpect ( addr len1 -- )             
 initptr  span !                         
 0 BEGIN  dup span @  u<                 
   WHILE  key decode  REPEAT             
 2drop space ;                           
                                         
Input: ediboard                          
 c64key c64key? edidecode ediexpect ;    
                                         
ediboard                                 
                                         
                                         
\ .status                     cas16aug06 
                                         
' noop Is .status                        
                                         
: .blk  ( -)                             
 blk @ ?dup IF  ."  Blk " u. ?cr  THEN ; 
                                         
' .blk Is .status                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ tracer: loadscreen          cas16aug06 
                                         
Onlyforth                                
                                         
\needs Code -$2B +load \ Trans Assembler 
                                         
\needs Tools   Vocabulary Tools          
                                         
Tools also definitions                   
                                         
   1 6  +thru  \ Tracer                  
   7 8  +thru  \ Tools for decompiling   
                                         
Onlyforth                                
                                         
\\                                       
                                         
This nice Forth Tracer has been          
developed by B. Pennemann and co         
for Atari ST. CL Vogt has ported it      
back to the volksForth 6502 C-16 and     
C-64                                     
                                         
                                         
                                         
\ tracer: wcmp variables      clv04aug87 
                                         
Assembler also definitions               
                                         
: wcmp ( adr1 adr2--) \ Assembler-Macro  
 over lda dup cmp swap  \ compares word  
 1+   lda 1+  sbc ;                      
                                         
                                         
Only Forth also Tools also definitions   
                                         
| Variable (W                            
| Variable <ip      | Variable ip>       
| Variable nest?    | Variable trap?     
| Variable last'    | Variable #spaces   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ tracer:cpush oneline        cas16aug06 
                                         
| Create cpull    0  ]                   
 rp@ count 2dup + rp! r> swap cmove ;    
                                         
: cpush  ( addr len -)                   
 r> -rot   over  >r                      
 rp@ over 1+ - dup rp!  place            
 cpull >r  >r ;                          
                                         
| : oneline  &82 allot keyboard display  
 .status  space  query  interpret        
 -&82 allot  rdrop                       
 ( delete quit from tnext )  ;           
                                         
: range ( adr--) \ gets <ip ip>          
 ip> off  dup <ip !                      
 BEGIN 1+ dup @                          
   [ Forth ] ['] unnest = UNTIL          
 3+ ip> ! ;                              
                                         
                                         
                                         
                                         
                                         
\ tracer:step tnext           clv04aug87 
                                         
| Code step                              
 $ff # lda trap? sta trap? 1+ sta        
           RP X) lda  IP sta             
 RP )Y lda  IP 1+ sta  RP 2inc           
 (W lda  W sta   (W 1+ lda   W 1+ sta    
Label W1-  W 1- jmp  end-code            
                                         
| Create: nextstep step ;                
                                         
Label  tnext IP 2inc                     
 trap? lda  W1- beq                      
 nest? lda 0=  \ low(!)Byte test         
 ?[ IP <ip wcmp W1- bcc                  
    IP ip> wcmp W1- bcs                  
 ][ nest? stx  \ low(!)Byte clear        
 ]?                                      
  trap? dup stx 1+ stx \ disable tracer  
  W lda  (W sta    W 1+ lda   (W 1+ sta  
                                         
                                         
                                         
                                         
                                         
\ tracer:..tnext              clv12oct87 
                                         
 ;c: nest? @                             
 IF nest? off r> ip> push <ip push       
    dup 2- range                         
    #spaces push 1 #spaces +! >r THEN    
 r@  nextstep >r                         
 input push    output push               
 2- dup last' !                          
 cr #spaces @ spaces                     
 dup 4 u.r @ dup 5 u.r space             
 >name .name  $10 col - 0 max spaces .s  
 state push  blk push  >in push          
 [ ' 'quit      >body ] Literal  push    
 [ ' >interpret >body ] Literal  push    
 #tib push  tib #tib @ cpush  r0 push    
 rp@ r0 !                                
 ['] oneline Is 'quit  quit ;            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ tracer:do-trace traceable   cas16aug06 
                                         
| Code do-trace \ installs TNEXT         
 tnext 0 $100 m/mod                      
     # lda  Next $c + sta                
     # lda  Next $b + sta                
 $4C # lda  Next $a + sta  Next jmp      
end-code                                 
                                         
| : traceable ( cfa--<IP ) recursive     
 dup @                                   
 ['] :    @ case? IF >body     exit THEN 
 ['] key  @ case? IF >body c@ Input  @ + 
                   @ traceable exit THEN 
 ['] type @ case? IF >body c@ Output @ + 
                   @ traceable exit THEN 
 ['] r/w  @ case? IF >body               
                   @ traceable exit THEN 
 @  [ ' Forth @ @ ] Literal =            
                  IF @ 3 + exit THEN     
 \ for defining words with DOES>         
 >name .name ." can't be DEBUGged"       
 quit ;                                  
                                         
                                         
\ tracer:User-Words           cas16aug06 
                                         
: nest   \ trace into current word       
 last' @ @ traceable drop nest? on ;     
                                         
: unnest \ proceeds at calling word      
 <ip on ip> off ; \ clears trap range    
                                         
: endloop last' @ 4 + <ip ! ;            
\ no trace of next word to skip LOOP..   
                                         
' end-trace Alias unbug \ cont. execut.  
                                         
: (debug  ( cfa-- )                      
 traceable range                         
 nest? off trap? on #spaces off          
 Tools do-trace ;                        
                                         
Forth definitions                        
                                         
: debug  ' (debug ; \ word follows       
                                         
: trace'            \ word follows       
 ' dup (debug execute end-trace ;        
                                         
\ tools for decompiling,      clv12oct87 
                                         
( interactive use                      ) 
                                         
Onlyforth Tools also definitions         
                                         
| : ?:  ?cr dup 4 u.r ." :"  ;           
| : @?  dup @ 6 u.r ;                    
| : c?  dup c@ 3 .r ;                    
| : bl  $24 col - 0 max spaces ;         
                                         
: s  ( adr - adr+)                       
 ( print literal string)                 
 ?:  space c? 4 spaces dup count type    
 dup c@ + 1+ bl  ;  ( count + re)        
                                         
: n  ( adr - adr+2)                      
 ( print name of next word by its cfa)   
 ?: @? 2 spaces                          
 dup @ >name .name 2+ bl ;               
                                         
: k  ( adr - adr+2)                      
 ( print literal value)                  
 ?: @? 2+ bl ;                           
                                         
( tools for decompiling, interactive   ) 
                                         
: d  ( adr n - adr+n) ( dump n bytes)    
 2dup swap ?: 3 spaces  swap 0           
 DO  c? 1+ LOOP                          
 4 spaces -rot type bl ;                 
                                         
: c  ( adr - adr+1)                      
 ( print byte as unsigned value)         
 1 d ;                                   
                                         
: b  ( adr - adr+2)                      
 ( print branch target location )        
 ?: @? dup @  over + 6 u.r 2+ bl  ;      
                                         
( used for : )                           
( Name String Literal Dump Clit Branch ) 
( -    -      -       -    -    -      ) 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( debugging utilities      bp 19 02 85 ) 
                                         
                                         
: unravel   \  unravel perform (abort"   
 rdrop rdrop rdrop                       
 cr ." trace dump is "  cr               
 BEGIN  rp@   r0 @ -                     
 WHILE   r>  dup  8 u.r  space           
         2- @  >name .name  cr           
 REPEAT (error ;                         
                                         
' unravel errorhandler !                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Multitasker               BP 13.9.84 ) 
                                         
Onlyforth                                
                                         
\needs multitask  1 +load  save          
                                         
  2  4 +thru        \ Tasker             
\    5 +load        \ Demotask           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Multitasker               BP 13.9.84 ) 
                                         
\needs Code -$36 +load  \ transient Ass  
                                         
Code stop                                
 SP 2dec  IP    lda  SP X) sta           
          IP 1+ lda  SP )Y sta           
 SP 2dec  RP    lda  SP X) sta           
          RP 1+ lda  SP )Y sta           
 6 # ldy  SP    lda  UP )Y sta           
     iny  SP 1+ lda  UP )Y sta           
 1 # ldy  tya  clc  UP adc  W sta        
 txa  UP 1+ adc  W 1+ sta                
 W 1- jmp   end-code                     
                                         
| Create taskpause   Assembler           
 $2C # lda  UP X) sta  ' stop @ jmp      
end-code                                 
                                         
: singletask                             
 [ ' pause @ ] Literal  ['] pause ! ;    
                                         
: multitask   taskpause ['] pause ! ;    
                                         
                                         
\ pass  activate           ks 8 may 84 ) 
                                         
: pass  ( n0 .. nr-1 Tadr r -- )         
 BEGIN  [ rot ( Trick ! ) ]              
  swap  $2C over c! \ awake Task         
  r> -rot           \ IP r addr          
  8 + >r            \ s0 of Task         
  r@ 2+ @  swap     \ IP r0 r            
  2+ 2*             \ bytes on Taskstack 
                    \ incl. r0 & IP      
  r@ @ over -       \ new SP             
  dup r> 2- !       \ into ssave         
  swap bounds  ?DO  I !  2 +LOOP  ;      
restrict                                 
                                         
: activate ( Tadr --)                    
 0 [ -rot ( Trick ! ) ]  REPEAT ;        
-2 allot  restrict                       
                                         
: sleep  ( Tadr --)                      
 $4C swap c! ;       \ JMP-Opcode        
                                         
: wake  ( Tadr --)                       
 $2C swap c! ;       \ BIT-Opcode        
                                         
\ building a Task           BP 13.9.84 ) 
                                         
| : taskerror  ( string -)               
 standardi/o  singletask                 
 ." Task error : " count type            
 multitask stop ;                        
                                         
: Task ( rlen  slen -- )                 
 allot              \ Stack              
 here $FF and $FE =                      
 IF 1 allot THEN     \ 6502-align        
 up@ here $100 cmove \ init user area    
 here  $4C c,       \ JMP opcode         
                    \     to sleep Task  
 up@ 1+ @ ,                              
 dup  up@ 1+ !      \ link Task          
 3 allot            \ allot JSR wake     
 dup  6 -  dup , ,  \ ssave and s0       
 2dup +  ,          \ here + rlen = r0   
 under  + here - 2+ allot                
 ['] taskerror  over                     
 [ ' errorhandler >body c@ ] Literal + ! 
 Constant ;                              
                                         
                                         
\ more Tasks           ks/bp  26apr85re) 
                                         
: rendezvous  ( semaphoradr -)           
 dup unlock pause lock ;                 
                                         
| : statesmart                           
 state @ IF [compile] Literal THEN ;     
                                         
: 's  ( Tadr - adr.of.taskuservar)       
 ' >body c@ + statesmart ; immediate     
                                         
\ Syntax:   2  Demotask 's base  !       
\ makes Demotask working binary          
                                         
: tasks  ( -)                            
 ." MAIN " cr up@ dup 1+ @               
 BEGIN  2dup - WHILE                     
  dup [ ' r0 >body c@ ] Literal + @      
  6 + name> >name .name                  
  dup c@ $4C = IF ." sleeping" THEN cr   
 1+ @ REPEAT  2drop ;                    
                                         
                                         
                                         
                                         
\ Taskdemo                    clv12aug87 
                                         
: taskmark ; \needs cbm>scr : cbm>scr ;  
                                         
: scrstart  ( -- adr)                    
  (64 $288 C) (16 $53e C) c@ $100 * ;    
                                         
Variable counter  counter off            
                                         
$100 $100 Task Background                
                                         
: >count  ( n -)                         
 Background 1 pass                       
 counter !                               
 BEGIN  counter @  -1 counter +! ?dup    
 WHILE  pause 0 <# #s #>                 
  0 DO  pause  dup I + c@  cbm>scr       
        scrstart I +  c!  LOOP  drop     
 REPEAT                                  
 BEGIN stop REPEAT ; \ stop's forever    
: wait  Background sleep ;               
: go    Background wake ;                
                                         
multitask       $100 >count  page        
                                         
\ printer loadscreen          27jul85re) 
                                         
Onlyforth hex                            
                                         
Vocabulary Print                         
Print definitions also                   
                                         
Create Prter 2 allot  ( Semaphor)        
Prter off                                
                                         
  : ) ; immediate                        
  : (u ; immediate  \ for user-port      
  : (s  [compile] ( ; immediate          
\ : (s ; immediate  \ for serial bus     
\ : (u  [compile] ( ; immediate          
                                         
(s  1 +load )                            
                                         
 2 $A +thru                              
                                         
Onlyforth                                
                                         
clear                                    
                                         
                                         
\ Buffer for the ugly SerBus  28jul85re) 
                                         
$100 | Constant buflen                   
                                         
| Variable Prbuf  buflen allot Prbuf off 
                                         
| : >buf  ( char --)                     
 Prbuf count + c!  1 Prbuf +! ;          
                                         
| : full?  ( -- f)   Prbuf c@ buflen = ; 
                                         
| : .buf  ( --)                          
 Prbuf count -trailing                   
 4 0 busout bustype busoff Prbuf off ;   
                                         
: p!  ( char --)                         
 pause  >r                               
 r@ $C ( Formfeed  ) =                   
 IF  r> >buf .buf exit  THEN             
 r@ $A ( Linefeed  ) =                   
 r@ $D ( CarReturn ) = or  full? or      
 IF  .buf  THEN  r> >buf ;               
                                         
                                         
                                         
\ p! ctrl: ESC esc:           28jul85re) 
                                         
(u                                       
: p!  \ char --                          
 $DD01 c!  $DD00 dup c@ 2dup             
 4 or swap c!  $FB and swap c!           
  BEGIN  pause  $DD0D c@ $10 and         
  UNTIL ;  )                             
                                         
| : ctrl:  ( 8b --)   Create c,          
  does>  ( --)   c@ p! ;                 
                                         
   7 ctrl: BEL    | $7F ctrl: DEL        
| $d ctrl: CRET   | $1B ctrl: ESC        
  $a ctrl: LF       $0C ctrl: FF         
                                         
| : esc:   ( 8b --)   Create c,          
  does>  ( --)   ESC c@ p! ;             
                                         
 $30 esc: 1/8"       $31 esc: 1/10"      
 $32 esc: 1/6"                           
 $54 esc: suoff                          
 $4E esc: +jump      $4F esc: -jump      
                                         
                                         
\ printer controls            28jul85re) 
                                         
| : ESC2   ESC  p! p! ;                  
                                         
  : gorlitz  ( 8b --)   BL ESC2 ;        
                                         
| : ESC"!"  ( 8b --)   $21 ESC2 ;        
                                         
| Variable Modus  Modus off              
                                         
| : on:  ( 8b --)  Create c,             
  does>  ( --)                           
  c@ Modus c@ or dup Modus c! ESC"!" ;   
                                         
| : off:  ( 8b --)   Create $FF xor c,   
  does>  ( --)                           
  c@ Modus c@ and dup Modus c! ESC"!" ;  
                                         
 $10 on: +dark    $10 off: -dark         
 $20 on: +wide    $20 off: -wide         
 $40 on: +cursiv  $40 off: -cursiv       
 $80 on: +under   $80 off: -under        
|  1 on: (12cpi                          
|  4 on: (17cpi     5 off: 10cpi         
                                         
\ printer controls            28jul85re) 
                                         
: 12cpi   10cpi (12cpi ;                 
: 17cpi   10cpi (17cpi ;                 
: super   0 $53 ESC2 ;                   
: sub     1 $53 ESC2 ;                   
: lines  ( #lines --)  $43 ESC2 ;        
: "long  ( inches --)   0 lines p! ;     
: american   0 $52 ESC2 ;                
: german     2 $52 ESC2 ;                
                                         
: prinit                                 
(s  Ascii x gorlitz  Ascii b gorlitz     
    Ascii e gorlitz  Ascii t gorlitz     
    Ascii z gorlitz  Ascii l gorlitz )   
(u  $FF $DD03 c!                         
    $DD02 dup c@  4 or swap c! ) ;       
                                         
| Variable >ascii  >ascii on             
                                         
: normal   >ascii on                     
  Modus off  10cpi  american  suoff      
  1/6"  $c "long  CRET ;                 
                                         
                                         
\ Epson printer interface     08sep85re) 
                                         
| : c>a  ( 8b0 -- 8b1)                   
 >ascii @ IF                             
dup $41 $5B uwithin IF $20 or  exit THEN 
dup $C1 $DB uwithin IF $7F and exit THEN 
dup $DC $E0 uwithin IF $A0 xor THEN      
 THEN ;                                  
                                         
| Variable pcol  pcol off                
| Variable prow  prow off                
                                         
| : pemit  c>a p!  1 pcol +! ;           
| : pcr   CRET LF  1 prow +!  0 pcol ! ; 
| : pdel   DEL  -1 pcol +! ;             
| : ppage  FF  0 prow !  0 pcol ! ;      
| : pat    ( zeile spalte -- )           
  over   prow @ < IF  ppage  THEN        
  swap prow @ - 0 ?DO pcr LOOP           
  dup  pcol < IF  CRET  pcol off  THEN   
  pcol @ - spaces ;                      
| : pat?   prow @  pcol @ ;              
| : ptype  ( adr count --)  dup pcol +!  
 bounds ?DO  I c@ c>a p!  LOOP ;         
                                         
\ print  pl                    02oct87re 
                                         
| Output: >printer                       
 pemit pcr ptype pdel ppage pat pat? ;   
                                         
                                         
: bemit   dup  c64emit  pemit ;          
: bcr          c64cr    pcr   ;          
: btype   2dup c64type  ptype ;          
: bdel         c64del   pdel  ;          
: bpage        c64page  ppage ;          
: bat     2dup c64at    pat   ;          
                                         
| Output: >both                          
 bemit bcr btype bdel bpage bat pat? ;   
                                         
Forth definitions                        
                                         
: Printer                                
  normal  (u prinit )  >printer ;        
: Both                                   
  normal  >both ;                        
                                         
                                         
                                         
\ 2scr's nscr's thru      ks  28jul85re) 
                                         
Forth definitions                        
                                         
| : 2scr's  ( blk1 blk2 --)              
 cr LF  17cpi  +wide +dark $15 spaces    
 over 3 .r $13 spaces dup 3 .r           
 -dark -wide cr  b/blk 0 DO              
  cr I c/l / $15 .r  4 spaces            
  over block I +  C/L 1- type  5 spaces  
  dup  block I +  C/L 1- -trailing type  
 C/L +LOOP  2drop  cr ;                  
                                         
| : nscr's  ( blk1 n -- blk2)   2dup     
 bounds DO I  over I + 2scr's LOOP + ;   
                                         
: pthru  ( from to --)                   
 Prter lock  Output push Printer  1/8"   
 1+ over - 1+ -2 and 6 /mod              
 ?dup IF swap >r                         
 0 DO 3 nscr's 2+ 1+ page LOOP  r> THEN  
 ?dup IF 1+ 2/ nscr's page THEN drop     
 Prter unlock ;                          
                                         
                                         
\ Printing with shadows       28jul85re) 
                                         
Forth definitions                        
                                         
| : 2scr's  ( blk1 blk2 --)              
 cr LF  17cpi  +wide +dark $15 spaces    
 dup  3 .r                               
 -dark -wide cr  b/blk 0 DO              
  cr I c/l / $15 .r  4 spaces            
  dup  block I +  C/L 1- type  5 spaces  
  over block I +  C/L 1- -trailing type  
 C/L +LOOP  2drop  cr ;                  
                                         
| : nscr's  ( blk1 n -- blk2)            
 0 DO dup [ Editor ]  shadow @   2dup    
 u> IF negate THEN                       
 + over 2scr's 1+ LOOP ;                 
                                         
: dokument  ( from to --)                
 Prter lock  Output push  Printer        
 1/8"  1+ over - 3 /mod                  
 ?dup IF swap >r                         
 0 DO 3 nscr's page LOOP  r> THEN        
 ?dup IF nscr's page THEN drop           
 Prter unlock ;                          
\ 2scr's nscr's thru      ks  28jul85re) 
                                         
Forth definitions  $40 | Constant C/L    
                                         
| : 2scr's  ( blk1 blk2 --)              
 pcr LF LF 10cpi +dark  $12 spaces       
 over 3 .r  $20 spaces dup 3 .r          
 cr 17cpi -dark                          
 $10 C/L * 0 DO cr over block I + C/L    
 6 spaces type 2 spaces                  
 dup block I + C/L -trailing type        
 C/L  +LOOP  2drop cr ;                  
                                         
| : nscr's ( blk1 n -- blk2)   under 0   
 DO 2dup dup rot + 2scr's 1+ LOOP nip ;  
                                         
: 64pthru  ( from to --)                 
 Prter lock  >ascii push  >ascii off     
 Output push  Printer                    
 1/6" 1+ over - 1+ -2  and 6 /mod        
 ?dup IF swap >r                         
 0 DO 3 nscr's 2+ 1+ page LOOP  r> THEN  
 ?dup IF 1+ 2/ nscr's page THEN drop     
 Prter unlock  ;                         
                                         
\ pfindex                      02oct87re 
                                         
Onlyforth Print also                     
                                         
: pfindex  ( from to --)                 
 Prter lock  Printer  &12 "long          
 +jump  findex  cr page  -jump           
 Prter unlock  display  ;                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Printspool                   02oct87re 
                                         
\needs tasks  .( Tasker?!) \\            
                                         
$100 $100 Task Printspool                
                                         
: spool  ( from to --)                   
 Printspool 2 pass                       
                                         
 pthru                                   
 stop ;                                  
                                         
: endspool  ( --)                        
 Printspool activate                     
 stop ;                                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Printer Routine C1526       cas16aug06 
                                         
( not useable for Printspool!!   re)     
                                         
Onlyforth  Vocabulary Print              
                                         
Print also Definitions                   
                                         
: prinit   4 7 busout ;                  
\needs FF  : FF noop ;                   
: CRET     $d bus! ;                     
                                         
: pspaces  ( n -)                        
  0 ?DO  BL bus! LOOP ;                  
                                         
1 2 +thru                                
                                         
Only Forth also Definitions              
                                         
( save )                                 
                                         
                                         
                                         
                                         
                                         
\ Printer interface 1526       02oct87re 
                                         
Variable Pcol   Variable Prow            
                                         
| : pemit  bus!    1 Pcol +! ;           
| : pcr    CRET    1 Prow +!  0 Pcol ! ; 
| : pdel   ;                             
| : ppage  FF  0 Prow !  0 Pcol ! ;      
| : pat    ( zeile spalte -- )           
  over   Prow @ < IF  ppage  THEN        
  0 rot  Prow @ - bounds ?DO pcr LOOP    
  dup  Pcol @ - pspaces  Pcol ! ;        
| : pat?   Prow @  Pcol @ ;              
| : ptype  ( adr count -)  dup Pcol +!   
 bounds ?DO  I c@ bus! LOOP ;            
                                         
| Output: >printer                       
 pemit pcr ptype pdel ppage pat pat? ;   
                                         
Forth definitions                        
                                         
: printer   prinit >printer ;            
                                         
: display   cr busoff display ;          
                                         
\ printer routinen             20oct87re 
                                         
Only Forth also definitions              
                                         
4 Constant B/scr                         
                                         
: .line  ( line# scr# --)                
  block swap c/l * + c/l 1- type ;       
                                         
: .===                                   
 c/l 1- 0 DO  Ascii = emit  LOOP ;       
                                         
: prlist ( scr# --)                      
 dup block drop    printer               
 $E emit ." Screen Nr. " dup . $14 emit  
 cr .===                                 
 l/s 0 DO I over .line cr LOOP drop      
 .=== cr cr cr  display ;                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ CP-80 Printer loadscreen    clv14oct87 
                                         
Onlyforth hex                            
                                         
Vocabulary Print  Print definitions also 
                                         
Create Prter 2 allot  ( Semaphor)        
                                         
0 Prter !   \ Prter unlock /clv          
                                         
1 6 +thru                                
                                         
Only Forth also definitions              
                                         
(  clear   )                             
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ p! ctrl: ESC esc:         07may85mawe) 
                                         
Print definitions                        
                                         
: p!  ( 8b -)                            
 BEGIN  pause  $DD0D c@  $10 and  UNTIL  
 $DD01 c! ;                              
                                         
| : ctrl:  ( B -)   Create c,            
  does>  ( -)   c@ p! ;                  
                                         
   07 ctrl: BEL    | $7F ctrl: DEL       
| $0D ctrl: CRET   | $1B ctrl: ESC       
  $0A ctrl: LF       $0C ctrl: FF        
                                         
| : esc:   ( B -)   Create c,            
  does>  ( -)   ESC c@ p! ;              
                                         
 $30 esc: 1/8"       $31 esc: 1/10"      
 $32 esc: 1/6"       $20 esc: gorlitz    
                                         
| : ESC2   ESC  p! p! ;                  
                                         
                                         
                                         
( printer controls          07may85mawe) 
                                         
 $0e esc: +wide  $14 esc: -wide          
 $45 esc: +dark  $46 esc: -dark          
 $47 esc: +dub   $48 esc: -dub           
 $0f esc: +comp  $12 esc: -comp          
                                         
: +under 1 $2D esc2 ;                    
: -under 0 $2D esc2 ;                    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( printer controls          07may85mawe) 
                                         
  $54 esc: suoff                         
                                         
: super   0 $53 ESC2 ;                   
                                         
: sub     1 $53 ESC2 ;                   
                                         
: lines  ( lines -)   $43 ESC2 ;         
                                         
: "long  ( inches -)   0 lines p! ;      
                                         
: american   0 $52 ESC2 ;                
                                         
: german     2 $52 ESC2 ;                
                                         
: pspaces  ( n -)                        
  0 swap bounds ?DO  BL p!  LOOP ;       
                                         
| : initport  0 $DD01 c! $FF $DD03 c! ;  
                                         
: prinit   initport                      
  american  suoff  1/6"                  
  &12 "long  CRET ;                      
                                         
( CP80  printer interface     26mar85re) 
                                         
| Variable unchanged?  unchanged? off    
                                         
| : c>a  ( 8b0 - 8b1)                    
 unchanged? @ ?exit                      
 dup $41 $5B uwithin                     
                IF  $20 or  exit THEN    
 dup $C1 $DB uwithin                     
                IF  $7F and exit THEN    
 dup $DC $E0 uwithin                     
                IF  $A0 xor      THEN ;  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
( print  pl                   06may85we) 
                                         
Variable Pcol   Variable Prow            
                                         
| : pemit  c>a p!  1 Pcol +! ;           
| : pcr    CRET    1 Prow +!  0 Pcol ! ; 
| : pdel   DEL  -1 Pcol +! ;             
| : ppage  FF  0 Prow !  0 Pcol ! ;      
| : pat    ( zeile spalte -- )           
  over   Prow @ < IF  ppage  THEN        
  0 rot  Prow @ - bounds ?DO pcr LOOP    
  dup  Pcol @ - pspaces  Pcol ! ;        
| : pat?   Prow @  Pcol @ ;              
| : ptype  ( adr count -)  dup Pcol +!   
 bounds ?DO  I c@ c>a p!  LOOP ;         
                                         
| Output: >printer                       
 pemit pcr ptype pdel ppage pat pat? ;   
                                         
Forth definitions                        
                                         
: Printer   prinit  >printer ;           
                                         
                                         
                                         
( 3scr's nscr's thru      ks07may85mawe) 
Forth definitions                        
                                         
| : 3scr's  ( blk  -)                    
 cr  -comp +dark                         
  $B spaces dup    3 .r                  
 $19 spaces dup 1+ 3 .r                  
 $19 spaces dup 2+ 3 .r                  
 cr  +comp  -dark  L/S C/L *  0 DO       
  cr 5 spaces dup  block I + C/L 1- type 
   8 spaces dup 1+ block I + C/L 1- type 
   8 spaces dup 2+ block I + C/L 1- type 
 C/L +LOOP  drop  cr LF ;                
                                         
| : nscr's ( blk1 n - blk2)  under 0     
 DO dup 3scr's over + LOOP nip ;         
                                         
: pthru  ( from to -)                    
 Output @ -rot  Printer Prter lock 1/8"  
 1+ over - 1+ 9 /mod                     
 ?dup IF swap >r                         
 0 DO 3 nscr's  page LOOP  r> THEN       
 ?dup IF 1- 3 / 1+ 0                     
   DO dup 3scr's 3 + LOOP  THEN drop     
 Prter unlock  Output ! ;                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ LongJsr for C16            cas16aug06 
                                         
                                         
Memory model                             
                                         
$0000 - $8000 : LowRAM                   
$8000 - $ffff : HighRAM  & ROM           
                                         
switch to RAM      Switch to ROM         
sys can be used like jsr                 
                                         
                                         
ROM-Call like       '0ffd2 sys'          
                                         
 rom jsr ram  == $ff3e sta jsr $ff3f sta 
                                         
not possible if HERE > $8000             
Guess why?                               
                                         
--- On the C64 BASIC and OS can be       
 banked seperatly. This macros are       
 only needed for the basic ROM           
                                         
                                         
                                         
\\  LongJsr for  C16          cas16aug06 
                                         
WARNING! Systemcrash if used incorrect   
                                         
                                         
                                         
this makro must be under $8000           
                                         
a call like ' $ffd2 sysMacro'            
will generate                            
   pha                                   
   $ff # lda  LONG1 2+ sta               
   $d2 # lda  LONG1 1+ sta               
   pla  LONG jsr                         
call in ROM will be done with a detour   
                                         
                                         
sys decided if direct or indirect call   
                                         
                                         
                                         
WARNING! Zero-Flag will be destroyed!    
                                         
                                         
                                         
( transient Forth-6502 Assemclcas16aug06 
( Basis: Forth Dimensions VOL III No. 5) 
                                         
The Assembler will be loaded completely  
into the HEAP and is only usable till    
the next 'clear' or 'save', after that   
he is complete removed from the memory.  
You cannot use it, but it also don't     
eats up valuable memory.                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ free                        cas16aug06 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for tracer:loadscreen      cas16aug06 
                                         
                                         
ToDo                                     
***For the next volks4th version ****    
                                         
Sync <IP IP>-handling with Atari and     
CPM                                      
here some examples to test               
                                         
                                         
| : aa dup drop ;                        
| : bb aa ;                              
\\                                       
debug bb                                 
trace' aa                                
                                         
trace' Forth                             
                                         
                                         
                                         
IP 2inc is done on CBM-Atari before or   
after                                    
                                         
                                         
\\ for tracer:wcmp variables  cas16aug06 
                                         
                                         
                                         
used like this       adr1 adr2 wcmp      
compares whole word, result is           
     Carry=1  : (adr1) >= (adr2)         
     Carry=0  : (adr1) <  (adr2)         
all other flags are not defined          
                                         
                                         
Temporary storage for W                  
area to be traced                        
Flag: trace word     Flag: trace yes?no  
unknown              level of nesting    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ for tracer:cpush oneline    cas16aug06 
                                         
                                         
                                         
                                         
saves LEN bytes from ADDR on the return  
stack. the next UNNEST or EXIT will      
place them back                          
                                         
                                         
Main loop                                
command can be entered                   
                                         
                                         
                                         
gets area to trace                       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ for tracer:step tnext       cas16aug06 
                                         
will be used at the end of TNEXT,        
 to enable TRAP? again and to fix the    
 broken NEXT-Routine                     
                                         
                                         
                                         
                                         
                                         
This Routine will be patched on NEXT     
and is the key part of the tracer        
 if no traced:                           
 trace current WORD?                     
    no:   is IP inside the debug area?   
          no: then go                    
    yes:  delete half! part              
                                         
 disable trap? ( the tracer shouldn't    
 trace itself )                          
                                         
                                         
                                         
                                         
                                         
\ tracer:..tnext              cas16aug06 
                                         
Forth-Part of TNEXT                      
 trace into current WORD?                
   yes: push DEBUG area, increment new   
        nestinglevel                     
 STEP should be executed later           
 PUSHed all important data               
                                         
 print information line                  
                                         
                                         
                                         
 PUSHed more data                        
                                         
 PUSHed the Return-Stack-Pointer !!      
 and pretends an empty Return-Stack      
 connects ONELINE into the               
 MAIN-COMMAND-LOOP and calls it          
                                         
                                         
                                         
                                         
                                         
                                         
\ tracer:do-trace traceable   cas16aug06 
                                         
installs (patched) TNEXT into NEXT       
 (NEXT is the innerst Routine,           
  that ends every word definition)       
                                         
                                         
                                         
                                         
checks, wethr a word can be traced       
  and looks up its address               
 :      -def.  <IP=cfa+2                 
 INPUT: -def.  <IP from input-Vektor     
                                         
 OUTPUT:-def.  <IP from output-Vektor    
                                         
 DEFER  -def.  <IP from  [cfa+2]         
                                         
 DOES>  -def.  <IP=[cfa]+3               
                                         
 all other definitions won't work        
                                         
                                         
                                         
                                         
\ tracer:user words           cas16aug06 
                                         
NEST enters a word for tracing           
                                         
                                         
UNNEST continues program execution to    
     the end of traced word              
                                         
ENDLOOP start tracing after next word    
     (usable inside loops)               
                                         
UNBUG disables tracing                   
                                         
                                         
                                         
                                         
                                         
                                         
DEBUG <word> marks the word to be        
     traced. If <word> is called, the    
     tracer kicks in                     
                                         
                                         
TRACE' will call <word> and start trace. 
                                         
\\ tools for decompil         cas16aug06 
                                         
\ if the word                            
                                         
                                         
: test 5   0   DO    ." do you like me?" 
    key Ascii y =                        
    IF   ." your fault " leave           
    ELSE ." yes sure! " THEN LOOP        
  ." !" ;                                
                                         
\\ should be inspected,                  
                                         
                                         
  please turn page..>                    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\  tools for decompil         cas16aug06 
                                         
cr                                       
tools                                    
trace' test                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\                             cas16aug06 
                                         
set order to FORTH FORTH ONLY   FORTH    
                                         
                                         
                                         
                                         
for multitasking                         
                                         
                                         
                                         
Centronics-Interface on User-Port        
(s Text till ) will be skipped           
serial Interface (commented out)         
(u Text till ) will be skipped           
                                         
load next screen only for serial bus     
                                         
                                         
                                         
                                         
                                         
remove unneded word headers              
                                         
                                         
\ When using the serial       cas16aug06 
bus, sendind chars one by one is too     
slow                                     
                                         
Buffer for chrs to send to printer       
                                         
add char to buffer                       
                                         
                                         
Buffer full?                             
                                         
print buffer and clean                   
                                         
                                         
                                         
Mainroutine to send to serial bus        
store char                               
is Formfeed?                             
  yes, print buffer incl. Formfeed       
is Linefeed?                             
or CR, or is the buffer filled?          
  yes, print buffer and CR/LF marked     
                                         
                                         
                                         
\                             cas16aug06 
                                         
                                         
Mainroutine for centronics intrface      
send char to port , emit Strobe-Edge     
                                         
wait for Busy-Signal to disappear        
                                         
                                         
send controlcodes to printr              
                                         
                                         
Controlcodes for Printer in Hex          
representation                           
                                         
Adjust if needed!                        
                                         
send ESC-Sequence to printer             
                                         
                                         
Linefeed in Inch                         
                                         
disable Superscript and Subscript        
skip perforation on/off                  
                                         
\                             cas16aug06 
                                         
Escape + 2 Chars                         
                                         
 only for Goerlitz-Interface             
                                         
special Epson-Controlmode                
                                         
  Copy of Printer-Control-Register       
                                         
switch Bit in control register on        
                                         
                                         
                                         
switch Bit in control register off       
                                         
                                         
                                         
These Controlcodes need to be adjusted   
for other printers with ctrl: ESC2       
and prn                                  
                                         
Linewidth in characters per inch         
replace with Elite, Pica or Compress if  
needed                                   
\                             cas16aug06 
                                         
adjust these if needed                   
                                         
                                         
                                         
Call as        66 lines                  
Call as        11 "long                  
Fonts, can be extended                   
                                         
                                         
Initializing ...                         
 . for Goerlitz-Interface                
                                         
                                         
 . for Centronics:  Port B on send       
            PA2 on send for Strobe       
                                         
Flag for char-convert                    
                                         
enable printer with standardvalues       
                                         
                                         
                                         
                                         
                              cas16aug06 
                                         
convert Commodore's Special-Ascii in     
standard ASCII                           
                                         
                                         
                                         
                                         
                                         
                                         
Routines for printing            command 
                                         
                                         
send chr to printer              emit    
CR and LF to printer             cr      
delete char          (?!)        del     
emit formfeed                    page    
position proterhead on column    at      
and row, new page if necessary           
                                         
                                         
                                         
get printhead position           at?     
emit string                      type    
                                         
                              cas16aug06 
                                         
create outputtable  >printer             
                                         
Routines for printer and screen          
(both)                                   
                                         
Output first on Screen                   
( Routines from DISPLAY )                
and on printer                           
( Routines from >PRINTER )               
                                         
                                         
                                         
create outputtable >both                 
                                         
                                         
                                         
words are avalable from Forth            
                                         
switch output to printer                 
                                         
switch output to screen and printer      
                                         
                                         
                              cas16aug06 
                                         
                                         
                                         
print two screen side by side            
screennumber in bold and 17cpi           
                                         
                                         
formatted output of both Screens         
                                         
                                         
                                         
                                         
will print screen this:    1    3        
way                        2    4        
                                         
prints scrren from to                    
store Outputdevice and enable printer    
calculate printposition for each         
Screen and print according to layout     
                                         
                                         
                                         
                                         
                                         
                              cas16aug06 
                                         
                                         
                                         
like 2scr's (with Shadow)                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
like nscr's (with Shadow)                
                           screen Shadow 
                           scr+1  Sh+1   
                                         
                                         
like pthru  (with Shadow)                
                                         
                                         
                                         
                                         
                                         
                                         
                              cas16aug06 
                                         
                                         
                                         
same again for standard forth screens    
with 16 lines and 64 chars               
                                         
                                         
                                         
                                         
                                         
                                         
                                         
see above                                
                                         
                                         
like pthru, but for standard screens     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                              cas16aug06 
                                         
                                         
                                         
print fast index on printer              
                      12" Papiersize     
 skip perforation                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
Background print              cas16aug06 
                                         
Multitasker is needed                    
                                         
Create workarea for task                 
                                         
enable backgroud printing                
 from to will be passed to task          
 on next PAUSE the task will execute     
 pthru and will go to sleep              
                                         
                                         
abort background task                    
 task will be activated to go to sleep   
 again immeditaly                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\    Printer interface 1526  cas16aug06 
                                         
This driver also works with:             
                                         
 C16 & CITIZEN-100DM \ see Handbook      
                                         
                                         
                                         
                                         
                                         
FF : Formfeed is missing here            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                              clv14oct87 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ Directory volksFORTH 4of4   26oct87re 
                                         
.                          0             
..                         0             
C16-Tape-Demo              2             
C64-Grafic-Demo            6             
cload/csave              &13             
Tape-Version:LoadScreen  &16             
Ramdisk                  &21             
Supertape                &32             
auto-Decompiler          &51             
Screenswitch             &61             
Grafic                   &64             
Math                     &90             
Sieve Benchmark         &138             
Grafic-Demo             &144             
Sprite-Demo             &160             
Sprite-Data             &165             
Sprite-Editor           &166             
                                         
                                         
                                         
                                         
                                         
                                         
\\ Content volksFORTH 4of4     26oct87re 
                                         
Directory                       0        
Content                         1        
                                         
C16-Tape  -Demo           &2-  &5        
C64-Grafic-Demo           &6- &12        
cload csave              &13- &15        
Tape-Version:LoadScreen  &16- &20        
Ramdisk                  &21- &30        
                              &31 free   
Supertape                &32- &50        
automatic Decompiler     &51- &60        
Screens via UserPort C64 &61- &63        
Grafic  C64 only!!       &64- &88        
                              &89 free   
Math                     &90- &96        
                         &97-&100 free   
Tape Ramdisk Supertape  &101-&135 shadow 
                                         
Sieve Benchmark              &138        
Grafic-Demo C64 only!!  &144-&155        
Sprite-Demo C64 only!!  &160-&164        
Sprite-Data                  &165        
Sprite Editor           &166-&168        
\ DemoL:C16Tape-Demo ?dload   clv10oct87 
                                         
\ Demo: 80 Screens in total !!!          
\ checks if a word is defined:           
                                         
| : exists? ( string--flag)              
      cr capitalize dup find nip under   
      0= IF ." not " THEN ." found: "    
      count type ;                       
                                         
\ last accessed diskf:                   
                                         
| Variable LastDisk   -1 LastDisk !      
                                         
\ load SCR from DISK, if WORD named      
\ STRING is not in Forth Dictionary      
| : ?dload  ( string scr disk--)         
  2 pick exists?                         
  IF drop drop drop exit THEN            
  dup LastDisk @ -                       
  IF flush ."  Insert #" dup .           
     key drop  dup LastDisk ! THEN       
  drop ."  scr#" dup . cr                
  load exists? 0= error" ???" ;          
-->                                      
\ DemoL:?reloc                clv10oct87 
                                         
\ relocates system call COLD if necces.  
| : ?reloc  ( s0 r0 limit --)            
 dup           limit =                   
 2 pick origin $a + @ = and              
 3 pick origin  8 + @ = and              
                                         
 IF drop drop drop exit THEN             
        ['] limit >body ! \ limit        
            origin $A + ! \ r0           
    dup 6 + origin   1+ ! \ task         
            origin  8 + ! \ s0           
 cold ;                                  
                                         
\ compiles forward references that will  
\ be loaded later                        
| : (forward"    "lit capitalize find    
 IF execute                              
 ELSE count type ."  unsatisfied" quit   
 THEN ; restrict                         
| : forward"  compile (forward" ," ;     
 immediate  restrict                     
-->                                      
                                         
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
                                         
\ DemoL:C16DemoLoad          cclv14oct87 
                                         
\ This word load the complete            
\ Demo-Version. Will be installed as     
\ 'COLD and later as C16DEMO             
                                         
| : c16DemoLoad                          
  $9000 $9400 $c000 ?reloc               
  Forth     " Code"       5 3 ?dload     
  Forth     " Editor"   $13 3 ?dload     
  Forth     " debug"    $2f 3 ?dload     
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
                                         
                                         
\ Graphic-Demo for C64        23oct87re  
                                         
(16 .( Not for C16!) \\ C)               
                                         
Onlyforth                                
                                         
\needs buffers      .( Buffers?!)    \\  
\needs demostart    .( Demostart?!)  \\  
\needs tasks        .( Tasker??!)    \\  
\needs help         .( help??!)      \\  
\needs graphic      &58 +load            
\needs .message2    1 2 +thru            
Graphic also                             
\needs moire        6 +load              
                                         
\needs slide  &154 +load  \ the Demo     
                                         
 3 5 +thru                               
                                         
1 Scr !  0 R# !                          
                                         
save                                     
                                         
                                         
                                         
\ demo-version                 06nov87re 
                                         
| : (center."  "lit count                
 C/L over - 2/ spaces type cr ;          
restrict                                 
                                         
| : c."  compile (center." ," ;          
immediate restrict                       
                                         
| : .FGes c." Forth Gesellschaft e.V." ; 
                                         
| : .vF83  c." *** volksFORTH-83 ***" ;  
                                         
| : .(c)   c." (c) 1985-2006"            
c." Bernd Pennemann  Klaus Schleisiek"   
c." Georg Rehfeld  Dietrich Weineck"     
c." Claus Vogt  Ewald Rieger "           
c." Carsten  Strotmann  " ;              
                                         
| : .source  c." www.forth-ev.de"        
      cr     c." volksforth.sf.net" ;    
                                         
                                         
| : wait   BEGIN  key 3 -  UNTIL ;       
                                         
\ demo-version                 20oct87re 
                                         
: .message1  ( -- )   singletask         
 page .vF83 cr .(c) cr                   
 c." volksForth is free software"        
 c." see file COPYING in the"            
 c." distribution package"               
 multitask wait ;                        
                                         
: .message2  ( -- )                      
 page c." You now have created a"        
 c." worksystem with Editor,"            
 c." Debugger and Assembler!"            
 c." Please insert an empty, formatted"  
 c." Disk and save the new system with"  
 c." SAVESYSTEM <name> (eg. FORTH)"      
 c." as a loadable program file"         
 cr .vF83 cr                             
 c." Information on volksForth from"     
 .FGes c." on:" cr .source wait ;        
                                         
                                         
                                         
                                         
                                         
\ demo-version                 20oct87re 
                                         
graphic  also                            
                                         
| Variable end?                          
                                         
: killdemo  ( -)                         
 killsprites endslide                    
 singletask  .message2                   
 ['] 1541r/w Is r/w                      
 ['] noop Is 'cold                       
 ['] noop Is 'restart                    
 ['] (quit   Is 'quit                    
 nographic                               
 [ ' demostart >name 4 - ] Literal       
 (forget  save  &16 buffers ;            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ demo-version                 06nov87re 
                                         
| : demor/w  ( adr blk r/wf - f)         
 end? @  0 max  dup small  red colored   
 -1 end? +!  sprite push  killsprites    
 1541r/w ;                               
                                         
| : demoquit                             
  BEGIN .status cr query interpret       
   state @ IF   ."  compiling"           
           ELSE ."  vF83" THEN           
   end? @ 0< dup                         
   IF drop                               
    cr ." Kill the Demo? n/y "           
    key capital Ascii Y =                
    dup not IF  del del del  THEN        
   THEN                                  
  UNTIL  killdemo ;                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ demo-version                 20oct87re 
                                         
: demonstration                          
 Onlyforth graphic                       
 ['] demor/w Is r/w                      
 ['] killdemo Is 'cold                   
 slide multitask pause   4 end? !        
 ['] demoquit Is 'quit                   
 ['] (error errorhandler !               
 ['] noop Is 'abort                      
 .message1  linien text                  
 key drop  moire text  key drop          
 ." help" row 1- 0 at abort ;            
                                         
' demonstration Is 'cold                 
' killdemo Is 'restart                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ cSave cLoad..               clv10oct87 
                                         
Onlyforth                                
\needs Code   .( need Assembler!) quit   
                                         
$ff90 >label setMsg   $90 >label status  
$ffba >label setlfs $ffbd >label setNam  
$FFD8 >label BSAVE  $FFD5 >label BLOAD   
Label slPars                             
 setup jsr (16 rom C)                    
 $80 # lda setMsg jsr 0 # lda status sta 
 N lda sec 8 # sbc  (drv    sta          
       CC ?[ dex ]? (drv 1+ stx          
 N ldx     N  1+ ldy 1 #  lda setlfs jsr 
 N 4 + ldx N 5 + ldy N 2+ lda setnam jsr 
 N 6 + ldx N 7 + ldy                     
 rts end-code                            
Label slErr \ AR=Kernalerror             
 CC ?[ 0 # lda ]? pha                    
 status lda $bf # and                    
 (16 ram C) push jmp end-code            
-->                                      
                                         
                                         
FORTH-GESELLSCHAFT (c) bp/ks/re/we/clv   
\ ..cSave cLoad               clv10oct87 
                                         
Code cSave ( f t+1 Name Nlen dev--err)   
 5 # lda    SLPars jsr                   
 N 8 + # lda bsave jsr                   
 slErr jmp end-code                      
                                         
Code cLoad ( f Name Nlen dev--t+1 err)   
 4 # lda    SLPars jsr                   
 0 # lda     bload jsr                   
 php pha tya pha txa pha 0 # ldy         
 SP 2dec pla SP )y sta iny pla SP )Y sta 
 pla plp slErr jmp  end-code             
                                         
-->                                      
                                         
\\ possible errors                       
 AR CF ST                  Basic  Forth  
 xx  L 00 no error            0     0    
 00  H 00 stop-key           1e    1e    
 00  L 60 end-of-tape        04    00    
 00  L 10 load/verify-error  1d/1c 1d    
 00  L 60 Checksumerror      1d    1d    
0-8  H 00 Kernal-Error       0-8  0-8    
FORTH-GESELLSCHAFT (c) bp/ks/re/we/clv   
\ ..cSave cLoad Luxus         clv10oct87 
                                         
                                         
Code .err ( err#-err# ) \ prints message 
 SP x) lda 0>=                           
 ?[ (16 tax dex rom $8654 jsr C)         
    (64 .A asl tax rom                   
    $a326 ,x lda $24 sta                 
    $a327 ,x lda $25 sta dey C) dey      
    [[ iny $24 )y lda php  $7f # and     
       $ffd2 jsr plp 0< ?]               
    (16 ram C) (64 ram C)                
  ]? xyNext jmp end-code                 
                                         
                                         
: derr?  ( err# -- flag)                 
 dup IF cr dup u. .err ." error" THEN    
 dup $ff and 5 = not                     
 (drv @ -1 > and                         
 IF derror? or THEN                      
 (drv @ 0 max (drv ! ;                   
                                         
\\ for usage after CSAVE and CLOAD.      
   The last line is only for             
   Compatibility with old version.       
\ TapeVersion:LoadScreen      clv12oct87 
                                         
Onlyforth                                
                                         
\needs Code  .( ?! Code !?)   quit       
                                         
              5 +load    \ Ramdisk       
             -3 +load    \ csave/load    
           1  3 +thru    \ Tape          
        (16 $10 +load C) \ superTape     
              4 +load    \ savesys       
                                         
Onlyforth                                
Variable autoload   autoload off         
                                         
: tapeInit  cr cr ." Tape2.00 "          
 \if supertape supertape                 
 ['] ramr/w Is r/w  1 drive              
 autoload @                              
 IF autoload off loadramdisk THEN ;      
                                         
save                                     
' tapeInit Is 'restart                   
\ restart                                
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Ramdisk TapeInterface       clv29jul87 
                                         
Onlyforth Ramdisk also                   
                                         
: saveRamDisk                            
  rd behind id count bsave ;             
                                         
                                         
: loadRamDisk                            
 rd? 0=                                  
 IF range memtop  rdnew rd THEN          
 " RD." count bload drop ;               
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
\ RD: loadscreen              clv01aug87 
                                         
Onlyforth                                
                                         
(16 $fd00 C) (64 $c000 C)                
Constant memtop                          
                                         
Vocabulary Ramdisk                       
Ramdisk also definitions                 
                                         
      1   9 +thru                        
                                         
Onlyforth                                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ RD: basics                  clv01aug87 
                                         
Variable (rd     (rd off                 
$31 constant plen                        
                                         
: adr>   ( adr--ofs) (rd @ -          ;  
: >adr   ( ofs--adr) (rd @ +          ;  
: adr@   ( ofs--adr) >adr @ >adr      ;  
: rd?    ( -- adr flag )                 
   (rd @ dup   dup   @ plen =     and ;  
: rd     ( -- adr)                       
   rd? 0= abort" no Ramdisk" ;           
                                         
| : take   ( adr--   ) adr> 2 >adr !  ;  
                                         
: adr    ( --adr   ) 2   adr@         ;  
: data   ( --adr   ) adr 4 +          ;  
                                         
| : end    ( --adr   ) 4   adr@       ;  
: behind ( --adr   ) end 4 +          ;  
| : end+   ( len--   ) 4   >adr +!    ;  
                                         
: blk#   ( --adr   ) 8   >adr         ;  
: id     ( --adr   ) $10 >adr         ;  
                                         
\ RD: new delete len@ len!    clv01aug87 
                                         
| : ?full      end 6 adr@ b/blk - 4 -    
             u> abort" Ramdisk full" ;   
                                         
| : new ( --)  end take ?full ;          
                                         
| : len! ( len--) \ end new block        
 ?dup 0= ?exit                           
 blk# @   end 2+ !  4 + dup end !        
 end+  end off ;                         
                                         
| : len@ ( --len) \ gen length           
 adr @ dup 0= ?exit 4 - ;                
                                         
                                         
: delete  ( --)                          
 adr dup @ under + adr behind over -     
 cmove                                   
 negate end+ ;                           
                                         
                                         
                                         
                                         
                                         
\ RD: search binary           clv01aug87 
                                         
: search ( blk --) \ set current Block   
 rd BEGIN dup @ + dup @ WHILE            
  ( blk adr ) 2dup 2+ @ = UNTIL          
 take  blk# ! ;                          
                                         
| : notRD? ( blk--flag) blk/drv u< ;     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
Onlyforth Ramdisk also                   
                                         
: binary ( blk--blk) \ no ComPand        
 dup offset @ + notRD? ?exit             
 dup block drop update                   
 delete new b/blk len! ;                 
                                         
                                         
                                         
\ RD: cbm>7bit 7bit>cbm       clv01aug87 
                                         
Label cbm>7b \ AR=char -- 7bitChar       
 $80 # cmp 0< ?[ rts ]?                  
 $c0 # cmp CS ?[ $e0  # cmp CC ?[        
       $a0 # adc rts ]? ]?               
 $1f # and       rts end-code            
Label 7b>cbm \ AR=7bitChar -- char       
 $60 # cmp CC ?[ rts ]?                  
 $a0 # sbc rts end-code                  
                                         
Code c>7 sp x) lda cbm>7b jsr putA jmp   
Code 7>c sp x) lda 7b>cbm jsr putA jmp   
end-code                                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ RD: cp1 cp2                 clv01aug87 
                                         
Label cp1 ( from to count--tocount)      
 3 # lda setup jsr N 2+ lda N 6 + sta    
 N 3+ lda N 7 + sta dey  $7f # ldx       
 N lda 0=                                
 ?[ N 1+ lda 0= ?[ pla pla 0 # lda       
   push0a jmp ]? ][ N 1+ inc ]? rts      
                                         
Label cp2                                
 sec N 2+ lda N 6 + sbc pha              
     N 3+ lda N 7 + sbc push jmp         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ RD: expand compress         clv01aug87 
                                         
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
\ RD: ramR/W                  clv01aug87 
                                         
| : endwrite ( compLen--)                
 data under + ( [from ]to )              
 BEGIN 1- dup c@ $7f u> WHILE            
   2dup u> UNTIL 1+ swap - len! ;        
                                         
| : endread  ( toAdr expLen--)           
 under + b/blk rot - bl fill ;           
                                         
: ramR/W ( adr blk file R/NotW -- error) 
 2 pick notRD?                           
 IF 1541r/w                              
 ELSE swap abort" no file"               
  swap search len@ b/blk = ( adr r? b?)  
  IF   0= IF data ELSE data swap THEN    
          b/blk cmove                    
  ELSE 0= IF   delete new data b/blk     
               compress endwrite         
          ELSE dup data swap len@        
               expand endread            
                                         
 THEN THEN false THEN ;                  
                                         
                                         
\ RD: id rduse/del/new        clv01aug87 
                                         
: .rd  ( --)     (rd @ u. rd drop        
  end u. 6 adr@ u. id count type ;       
                                         
: id! ( adr count--)                     
  $20 id c! id count bl fill             
  $1a umin id 3 + place                  
  " RD." count id 1+ swap cmove ;        
                                         
: id" Ascii " parse id! ; \ id" name     
                                         
: rduse ( from --) (rd ! ;               
: rddel  ( --)                           
  rd @ dup 2 >adr ! 4 >adr ! end off ;   
| : range ( adr--adr)                    
  limit umax memtop umin ;               
: rdnew ( from to--)                     
  range swap range swap                  
  2dup $500 - u> abort" range!"          
  over plen over ! rduse                 
  swap - 6 >adr !                        
  rddel 0 0 id! ;                        
                                         
                                         
\ RD: rdcheck                 clv01aug87 
                                         
| : ?error IF ." error " THEN ;          
                                         
: rdcheck                                
 .rd                                     
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:Supertape LoadScreen     clv01aug87 
                                         
(64 .( not for C64!! ) quit C)           
                                         
\needs Code .( needs Assembler!) quit    
                                         
Assembler                                
\needs rom  .( ??! rom  !??) quit        
Onlyforth                                
                                         
   1  $12 +thru \ load supertape         
                                         
                                         
\\ Supertape was developed by german     
   magazin c't ( www.heise.de )          
   We thank the publisher for            
   permission to adapt SuperTape         
   for volksForth                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:Labels..                 clv16jun87 
                                         
\ ------ hardware-Addresses -----------  
$0001 >Label pCass                       
$ff02 >Label pTimerB                     
$ff09 >Label pTimerBCtrl                 
$ff3f >Label pRamOn                      
$ff3e >Label pRamOff                     
                                         
\ ------ System-Vectors --------------   
$0330 >Label vSave                       
$032e >Label vLoad                       
                                         
\ --- Input-Params Load/Save ---------   
$ae >Label zDeviceNr                     
$ad >Label zSecadd                       
$af >Label zFilenameZ                    
$ab >Label zFileNameC                    
$b4 >Label zBasLoadAdd                   
$b2 >Label zIOStartZ                     
$9d >Label zProgEndZ                     
                                         
\ --- Output Params for Load/Save ----   
$90 >Label zStatus                       
                                         
\ ST:..Labels                 clv16jun87 
                                         
\ ------ used System Routines ---------  
$e38d >Label xCassMotorOn                
$e3b0 >Label xCassMotorOff               
$e364 >Label xCassPrtOn                  
$e378 >Label xCassPrtOff                 
$f050 >Label xLoad                       
$f1a4 >Label xSave                       
$f189 >Label xMsgLoadVerify              
$e31b >Label xPressplay                  
$e319 >Label xPressRec                   
$ebca >Label xFoundFile                  
$f160 >Label xSearching                  
$ffd2 >Label kOutput                     
                                         
\ ------ used Zeropage Addresses ------  
                                         
$5f >Label zBeginZ                       
$61 >Label zEndZ                         
$93 >Label zVerifyFlag                   
$59 >Label ZBlockKind                    
$58 >Label zBit                          
$57 >Label zByte                         
$ff >Label zTmp                          
\ ST:..Labels                 clv16jun87 
                                         
                                         
$d8 >Label zReservAA                     
$5d >Label zCheckSum                     
$63 >Label zCheckSumB                    
$da >Label zTmpSP                        
                                         
                                         
\ --- other Systemadressen ----------    
$07c8          >Label sTime              
$0332  dup     >Label sCassBuffer        
$19 + $100 mod >Label cCassBufferEnd     
                                         
\ --------- Konstanten --------------    
$07 >Label cDeviceST                     
$2a >Label cHeaderMark                   
$c5 >Label cDataMark                     
$4f >Label chsl                          
$b5 >Label clsl                          
$78 >Label chssh    $34 >Label chssl     
$ff >Label clssh    $78 >Label clssl     
$16 >Label cSyncByte                     
$0b >Label cSyncBytesLoad                
$40 >Label cSyncByteCount                
\ ST:verschiedenes            clv28jul87 
                                         
Label btlBeg                             
Label puffinit \ Load Pointer to Buffer  
 sCassbuffer $100 u/mod                  
 # lda    zBeginZ 1+ sta zEndZ 1+ sta    
 # lda    zBeginZ    sta                 
 cCassbufferEnd # lda     zEndZ    sta   
 rts end-code                            
                                         
Label timerBStart                        
 sTime lda          pTimerB      sta     
 0   #  lda         pTimerB   1+ sta     
 $10 #  lda         pTimerBCtrl  sta     
 rts end-code                            
                                         
Label delayMotor \ Motor start Delay     
 0 # ldx 0 # ldy                         
 [[ [[ dex 0= ?] dey 0= ?]               
 rts end-code                            
                                         
                                         
                                         
                                         
                                         
\ ST:stEnde etc.              clv23jul87 
                                         
Label stEnd         0 # lda  $2c c,      
Label loadError   $1d # lda  $2c c,      
Label eot         $04 # lda  $2c c,      
Label verError    $1c # lda  $2c c,      
Label brkError    $1e # lda              
 pRamOff sta  pha                        
 xCassMotorOff jsr  xCassPrtOff jsr      
 zTmpSP ldx   pla  txs                   
 zBeginZ ldx  zBeginZ 1+ ldy             
 01 # cmp cli rts end-code               
                                         
                                         
\\  cbm: stop: ar=0  cf=1                
        normal ar=0  cf=0  st=0          
        eot                 $80          
 load/vererr                $10          
    checksum                $60          
                            ...          
kernal-errors ar=0..8 cf=1               
                                         
 s.ROM:$a803                             
                                         
                                         
\ ST:bitRead                  clv18jun87 
                                         
Label bitRead  \ cur.Byte in AR          
 $10 # lda [[ ptimerBctrl bit 0<> ?]     
 pCass lda  $10 # and  zBit cmp          
 0<> ?[ clc ]?        zBit sta           
 zByte ror zByte lda                     
 0< ?[ zCheckSum wInc ]?                 
 [[ pCass lda $10 # and  zBit cmp 0<> ?] 
 zBit sta timerBStart jsr                
 zByte lda rts end-code                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:stRead..                 clv05aug87 
                                         
Label stRead \ reads a block             
 zBlockKind sta  0 # ldx                 
Label syncron                            
 [[ bitRead jsr cSyncByte # cmp 0= ?]    
 cSyncBytesLoad # ldx                    
 [[ $08 # ldy                            
    [[ bitRead jsr dey 0= ?]             
    cSyncByte # cmp         syncron bne  
    dex 0= ?]                            
 [[ $08 # ldy                            
    [[ bitRead jsr dey 0= ?]             
    cSyncByte # cmp 0<> ?]               
 zBlockKind cmp 0<>                      
 ?[ cDataMark # cmp        syncron beq   
 $10 # lda zStatus sta loadError jmp ]?  
 0 # lda zCheckSum sta zCheckSum 1+ sta  
 $08 # ldy                               
    [[ bitRead jsr dey 0= ?] zTmp sta    
                                         
                                         
                                         
                                         
                                         
\ ST:..stRead                 clv28jul87 
                                         
 [[ [[                                   
  zCheckSum    lda  zCheckSumB    sta    
  zCheckSum 1+ lda  zCheckSumB 1+ sta    
  bitRead jsr      bitRead jsr           
  zVerifyFlag lda 0=                     
  ?[ zTmp lda   zBeginZ )Y sta ]?        
  bitRead jsr      bitRead jsr           
  zTmp lda      zBeginZ )Y cmp           
  0<> ?[ inx ]?                          
  bitRead jsr      bitRead jsr           
  zBeginZ wInc                           
  bitRead jsr      bitRead jsr           
  zTmp sta                               
 zBeginZ 1+ lda  zEndZ 1+ cmp 0= ?]      
 zbeginZ    lda  zEndZ    cmp 0= ?]      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:..stRead                 clv05aug87 
                                         
 zTmp lda ZCheckSumB cmp 0<> ?[          
Label SError zStatus lda  $60 # ora      
         zStatus sta loadError jmp ]?    
 $08 # ldy                               
    [[ BitRead Jsr dey 0= ?]             
 zCheckSumB 1+ cmp        SError bne     
 0 # cpx  0<> ?[ $10 # lda zStatus sta   
                       verError jmp ]?   
Label ldRTS rts end-code                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:stLoad..                 clv23jul87 
                                         
Label stLoad                             
 zVerifyFlag sta  0 # lda zStatus sta    
 zDeviceNr  lda  cDeviceST # cmp 0<>     
 ?[ xLoad jmp ]? \ CBM-Routine           
Label loadNext                           
 tsx  zTmpSP stx                         
 xPressplay jsr ldRTS bcs                
 sei     zVerifyFlag lda pha             
 0 # lda zVerifyFlag sta                 
 xSearching jsr                          
Label ldWrongFile                        
 xCassMotorOn jsr delayMotor jsr         
 xCassPrtOn   jsr puffInit   jsr         
 clsl # lda   sTime sta                  
 cHeaderMark # lda  stRead jsr           
 $63 # ldy  xFoundFile jsr               
 0 # ldy [[ sCassBuffer ,Y lda           
    kOutput jsr  iny  $10 # cpy  0= ?]   
 $ff # ldy                               
                                         
                                         
                                         
                                         
\ ST:..stLoad                 clv23jul87 
                                         
                                         
Label ldComp                             
 [[ iny zFileNameC cpy 0<>               
  ?[[ pRamOn sta zFilenameZ )Y lda       
  pRamOff sta                            
  sCassBuffer ,Y cmp         ldComp beq  
  Ascii ?      # cmp         ldComp beq  
  sCassBuffer $10 + lda  $02 # and 0<>   
  ?[ $80 # lda zStatus sta eot jmp ]?    
  xCassPrtOff jsr       ldWrongFile jmp  
 ]]? pla  zVerifyFlag sta                
 xMsgLoadVerify jsr                      
 zBasLoadAdd    lda  zBeginZ    sta      
 zBasLoadAdd 1+ lda  zBeginZ 1+ sta      
 zSecAdd lda 0<>                         
 ?[ sCassBuffer $11 + lda zBeginZ   sta  
   sCassBuffer $12 + lda zBeginZ 1+ sta  
 ]?                                      
 clc sCassBuffer $13 + lda               
 zBeginZ    adc zEndZ    sta             
 sCassBuffer $14 +  lda                  
 zBeginZ 1+ adc zEndZ 1+ sta             
                                         
\ ST:..stLoad                 clv14oct87 
                                         
                                         
 chsl # lda    sTime sta                 
 sCassBuffer $10 + lda 0>=               
 ?[ clsl # lda sTime sta ]?              
 pRamOn sta  cDataMark # lda stRead jsr  
 stEnd jmp end-code                      
                                         
Label loadsys \ load and start           
 loadnext jsr CS ?[ brk ]?               
 loadnext jsr CS ?[ brk ]?               
 origin 8 - jmp \ Forth-Cold vector      
Label btlEnd                             
base @ hex                               
Create g----    7 allot                  
loadsys 0 <# #s Ascii g hold #cr hold #> 
g---- place                              
base !                                   
: >lower ( str--) count bounds           
 DO I c@ $7f and I c! LOOP ;             
                                         
g---- >lower  forget >lower              
                                         
                                         
\ ST:wByte w4bits             clv16jun87 
                                         
Label wByte here 3 + Jsr \ write byte    
Label w4bits             \ upper 4 Bits  
 $04 # ldy                               
 [[ zByte lsr CS                         
    ?[ zReservAA 1+ lda  sTime sta ]?    
    $10 # lda [[ pTimerBCtrl bit 0<> ?]  
    timerBStart jsr                      
    pCass lda  $02 # eor pCass sta       
    CC ?[ $10 # lda                      
       [[ pTimerBCtrl bit 0<> ?]         
       timerBStart jsr                   
       pCass lda  $02 # eor pCass sta    
    ][ zCheckSum    lda 0 # adc          
       zCheckSum    sta                  
       zCheckSum 1+ lda 0 # adc          
       zCheckSum 1+ sta                  
       zReservAA lda sTime sta ]?        
    dey 0= ?] rts  end-code              
                                         
                                         
                                         
                                         
                                         
\ ST:stWrite                  clv18jun87 
                                         
Label stWrite \ writes a block           
 pha cSyncByteCount # ldx                
 [[ cSyncByte # lda  zByte sta           
    wByte Jsr dex 0= ?]                  
 pla  zbyte sta  wByte Jsr               
 0 # ldy zCheckSum sty zCheckSum 1+ sty  
 [[ [[                                   
  zBeginZ  )Y lda  zByte sta w4bits jsr  
  zBeginZ  wInc              w4bits jsr  
  zBeginZ     lda   zEndZ    cmp 0= ?]   
  zBeginZ  1+ lda   zEndZ 1+ cmp 0= ?]   
 zCheckSum lda  zCheckSum 1+ ldx         
 zByte sta        wByte jsr              
 txa   zByte sta  wByte jsr              
 wByte jmp end-code                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:saveName                 clv26jul87 
                                         
Label saveName \ no error checking!      
 bl # lda  $0f # ldy                     
 [[ sCassBuffer ,Y sta  dey 0= ?]        
 zFileNameC ldy ram                      
 [[ dey 0>= ?[[ zFileNameZ )Y lda        
    sCassBuffer ,Y sta ]]? rom           
Label rsRTS rts end-code                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:stSave..                 clv16jun87 
                                         
Label stSave                             
 zDeviceNr lda cDeviceST # cmp 0<>       
 ?[ sec $0e # and 0= ?[ clc ]?           
                            xSave jmp ]? 
 tsx  zTmpSP stx                         
 saveName jsr                            
 clc  xPressRec  jsr          rsRTS bcs  
 sei  xCassPrtOn jsr xCassMotorOn jsr    
 delayMotor jsr                          
 zSecAdd lda  sCassbuffer &16 + sta      
 zIOStartZ    lda sCassBuffer &17 + sta  
 zIOStartZ 1+ lda sCassBuffer &18 + sta  
 sec zProgEndZ lda  zIOStartZ    sbc     
 sCassBuffer &19 + sta                   
 zProgEndZ 1+ lda   zIOStartZ 1+ sbc     
 sCassBuffer &20 + sta                   
 0 # lda sCassBuffer &21 +               
 dup sta 1+ dup sta 1+ dup sta 1+ sta    
 pTimerB 1+ sta                          
 sCassBuffer $100 u/mod                  
 # lda zBeginZ  1+ sta  zEndZ 1+ sta     
 # lda zBeginZ     sta                   
 cCassBufferEnd # lda   zEndZ    sta     
\ ST:..stSave                 clv16jun87 
                                         
                                         
 clssh # lda  zReservAA 1+ sta           
 clssl # lda  zReservAA    sta           
 pTimerB sta                             
 $10 # lda  pTimerBCtrl sta              
 cHeaderMark # lda  stWrite jsr          
 delayMotor jsr                          
 zSecAdd bit 0<                          
 ?[ chssh # lda  zReservAA 1+ sta        
    chssl # lda  zReservAA    sta        
    pTimerB sta ]?                       
 zIOStartZ     lda  zBeginZ     sta      
 zIOStartZ  1+ lda  zBeginZ  1+ sta      
 zProgEndZ     lda  zEndZ       sta      
 zProgEndZ  1+ lda  zEndZ    1+ sta      
 pRamOn sta cDataMark # lda stWrite jsr  
 delayMotor jsr stEnd jmp end-code       
                                         
                                         
                                         
                                         
                                         
                                         
\ ST:supertape savebooter     clv10oct87 
                                         
: supertape  \ --                        
 7 device !                              
 stLoad vLoad !  stSave vSave !          
 ." ST2.20 " ;                           
                                         
| : (n" >in store n" ;                   
                                         
: btl ( --[from ]to )                    
 [ BtlBeg ] Literal [ BtlEnd ] Literal ; 
                                         
| : btlName ( --adr count)               
 pad $16 bl fill                         
 (n" $10 umin pad     swap cmove         
 g---- count pad $a + swap cmove         
 pad $10 ;                               
                                         
: stSavSys ( --)  \ Name" follows        
  device store 1 device !                
  btl btlName               bsave        
  7 device !                             
  origin $17 - btl drop (n" bsave        
  btl nip here           n" bsave ;      
                                         
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ decompile each type of word 29nov85re  
                                         
| : .word   ( IP - IP')                  
 dup @ >name .name 2+ ;                  
                                         
| : .lit    ( IP - IP')                  
 .word dup @ . 2+ ;                      
                                         
| : .clit   ( IP - IP')                  
 .word dup c@ . 1+ ;                     
                                         
| : .string ( IP - IP')                  
 cr .word count 2dup type ascii " emit   
 space + ;                               
                                         
| : .do  ( IP - IP')   ." DO " 4 + ;     
                                         
| : .loop  ( IP - IP')   ." LOOP " 4 + ; 
                                         
| : .exit    ( IP - IP' f)               
 dup maxbranch @ u< IF  .word exit  THEN 
 dup @ [ Forth ] ['] unnest =            
 IF  ." ; "  ELSE  .word ." ; -2 allot " 
 THEN  0= ;                              
                                         
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
                                         
                                         
\ Classify a word              22jul85we 
                                         
5 associative: definition-class          
' quit @ ,        ' 0 @ ,                
' scr @ ,         ' base @ ,             
' 'cold @ ,                              
                                         
6 case: .definition-class                
.:                .constant              
.variable         .user-variable         
.defer            .other  ;              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Top level of Decompiler    20aug85mawe 
                                         
: ((see    ( cfa -)                      
 maxbranch off  thenbranch off           
 cr dup dup @                            
 definition-class .definition-class      
 .immediate ;                            
                                         
' ((see Is (see                          
                                         
Forth definitions                        
                                         
: see   ' (see ;                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Commodore hole Screens       20oct87re 
                                         
Onlyforth                                
                                         
: <init   0 $DD03 c! ;                   
                                         
: get  ( -- 8b)                          
 BEGIN  $DD0D c@ $10 and  UNTIL          
 $DD01 c@ dup $DD01 c! ;                 
                                         
: <sync  ( --)                           
 <init  BEGIN  get $55 =  UNTIL          
 BEGIN  get dup $55 =                    
 WHILE  drop  REPEAT  abort" SyncErr" ;  
                                         
: sum  ( oldsum n -- newsum n)           
 swap over + swap ;                      
                                         
: check  ( sum.int  8b.sum.read --)      
 swap $FF and - abort" ChSumError" ;     
                                         
-->                                      
                                         
                                         
                                         
\ Commodore hole Screens       20oct87re 
                                         
: download  ( n --)                      
 <sync  0 swap buffer b/blk bounds       
 DO  get  sum  I c!  LOOP                
 get check update ;                      
                                         
: downthru  ( start count --)            
 bounds DO  I download  LOOP ;           
                                         
-->                                      
                                         
\\ sync needs: xx $55 $55 00 data        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Commodore sendscreens        20oct87re 
                                         
: >init  $FF $DD03 c! ;                  
                                         
: put ( 8b -)                            
 $DD01 c!  BEGIN  stop?                  
  IF  <init true abort" terminated" THEN 
  $DD0D c@ $10 and  UNTIL ;              
                                         
: >sync  ( --)                           
 >init $10 0 DO $55 put  LOOP  0 put ;   
                                         
: upload  ( n --)                        
 >sync  0 swap  block b/blk bounds       
 DO  I c@ sum  put  LOOP                 
 $FF and  put  <init  ;                  
                                         
: upthru  ( from to -- )                 
 1+ swap DO  I . cr  I upload  LOOP ;    
                                         
                                         
                                         
                                         
                                         
                                         
\ Graphic Load-Screen          20oct87re 
                                         
(16 .( C64 Only ) \\ C)                  
                                         
Onlyforth                                
                                         
\needs Code         .( Assembler??!) \\  
                                         
\needs lbyte         1 +load             
                                         
\needs 100u/       &26 +load             
                                         
Vocabulary graphic                       
                                         
' graphic | Alias Graphics               
                                         
Graphics also definitions                
                                         
  2 &15 +thru  \ hires graphic           
&16 &20 +thru  \ sprites                 
&21 &23 +thru  \ turtle graphic          
                                         
Onlyforth                                
                                         
                                         
\ >byte hbyte lbyte            20oct87re 
                                         
Code >byte   ( 16b - 8bl 8bh)            
 SP )Y lda pha txa SP )Y sta SP 2dec     
 txa SP )Y sta pla Puta jmp   end-code   
                                         
: hbyte >byte nip ;                      
: lbyte >byte drop ;                     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Graphics constants           20oct87re 
                                         
| $0288 Constant scrpage                 
| $E000 Constant bitmap                  
| $D800 Constant charset                 
| $C400 Constant colram                  
| $C000 Constant vidram                  
\ $C800 Constant sprbuf                  
                                         
   bitmap hbyte $40 /mod  3 swap -       
| Constant bank                          
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
                                         
                                         
                                         
\ Gr movecharset clrscreen     20oct87re 
                                         
| Code movecharset                       
 sei  $32 # lda  1 sta   dey  8 # ldx    
 N sty  N 2+ sty  $D8 # lda  N 1+ sta    
 charset hbyte # lda  N 3 + sta          
  [[                                     
   [[  N )Y lda  N 2+ )Y sta  iny  0= ?] 
  N 1+ inc  N 3 + inc  dex  0= ?]        
 $36 # lda   1 sta  cli  iny             
 Next jmp  end-code                      
                                         
                                         
: clrscreen ( -- ) bitmap &8000 erase ;  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Gr Variables (text (hires    20oct87re 
                                         
| Variable cbmkey                        
| Variable switchflag                    
| Variable textborder                    
| Variable hiresborder                   
| Variable switchline                    
| Variable chflag                        
                                         
Label (text                              
 $1B # lda  $D011 sta                    
 tmoffs # lda  $D018 sta                 
 textborder lda  $D020 sta  rts          
                                         
Label (hires                             
 $3B # lda  $D011 sta                    
 bmoffs # lda  $D018 sta                 
 hiresborder lda  $D020 sta  rts         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Gr rasterirq graphicirq      20oct87re 
                                         
Label windowhome                         
 switchline lda sec $30 # sbc            
 .A lsr .A lsr .A lsr  sec 1 # sbc       
  $D6 cmp CC ?[ rts ]?                   
  tax inx 2 # ldy $CC sty $CD sty        
  $CE lda $D3 ldy $D1 )Y sta             
  0 # ldy $CF sty clc $FFF0 jsr          
  0 # ldy $D1 )y lda $CE sta $CC sty     
  rts                                    
                                         
Label graphicirq                         
$28D lda  2 # and 0= ?[ oldirq jmp ]?    
[[ $FF9F jsr $28D lda 0= ?] cbmkey ) jmp 
                                         
Label rasterirq                          
 $D019 lda $D019 sta                     
 $15 # ldx [[ dex 0= ?] N lda ( Blind!!) 
 chflag lda  1 # eor chflag sta tax      
 0= ?[ (hires jsr ][ (text jsr ]?        
 switchline ,x lda $D012 sta             
 windowhome jsr                          
 $DC0D lda  1 # and graphicirq bne       
 irqend jmp                              
\ Gr IRQ-handling   (window    20oct87re 
                                         
Label setirq                             
 sei graphicirq >byte                    
 # lda irqvec 1+ sta    # lda irqvec sta 
 $F0 # lda $D01A sta $81 # lda $DC0D sta 
 cli rts                                 
                                         
| Code resetirq                          
 sei oldirq >byte                        
 # lda irqvec 1+ sta    # lda irqvec sta 
 $F0 # lda $D01A sta $81 # lda $DC0D sta 
 cli Next jmp end-code                   
                                         
Label (window                            
 rasterirq >byte                         
 # lda irqvec 1+ sta  # lda irqvec sta   
 $7F # lda $DC0D sta $F1 # lda $D01A sta 
 switchflag stx chflag stx               
 windowhome jmp                          
                                         
                                         
                                         
                                         
                                         
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
                                         
                                         
                                         
\ Gr (plot compute             20oct87re 
                                         
Label (plot  ( x y -)                    
 2 # lda  setup jsr      3 # ldx         
 [[ y0 ,X lda  pointy ,X sta  dex  0< ?] 
 $C7 # lda sec y0 sbc y0 sta             
Label compute  sei  1 dec                
 y0 lda  $F8 # and  pha                  
 bytnr sta  0 # lda  bytnr 1+ sta  clc   
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
\ Gr plot flip clpx            20oct87re 
                                         
Code plot  ( x y -)                      
 (plot jsr                               
 bytnr 1+ ldx bitmap hbyte # cpx         
 cs ?[ bytnr )Y ora  bytnr )Y sta ]?     
Label  romon                             
 1 inc  cli  xyNext jmp  end-code        
                                         
Code flip  ( x y -)                      
 (plot jsr                               
 bytnr 1+ ldx bitmap hbyte # cpx         
 cs ?[ bytnr )Y eor  bytnr )Y sta ]?     
 romon jmp  end-code                     
                                         
Code unplot ( x y -)                     
 (plot jsr                               
 bytnr 1+ ldx bitmap hbyte # cpx cs ?[   
 $FF # eor  bytnr )Y and bytnr )Y sta ]? 
 romon jmp  end-code                     
                                         
\\ compute disables IRQ, the words       
plot, flip, unplot and line enable the   
IRQ again. Not nice, but the only was    
because of the branch in 'line'.         
\ Gr line 1                    20oct87re 
                                         
Code line  ( x1 y1 x0 y0 -)              
 4 # lda  setup jsr                      
Label (drawto                            
 3 # ldx                                 
 [[ y0 ,X lda  pointy ,X sta  dex  0< ?] 
 $C7 # lda sec y1 sbc y1 sta             
 $C7 # lda sec y0 sbc y0 sta             
                                         
 ix sty  iy sty  ct sty  dey             
 ax sty  ay sty  ct 1+ sty  dey          
 x1 lda  x0 cmp  x1 1+ lda  x0 1+ sbc    
 CC ?[  sec  x0 lda  x1 sbc  dx sta      
        x0 1+ lda  x1 1+ sbc  dx 1+ sta  
        ix sty                           
    ][  x1 lda  x0 sbc  dx sta           
        x1 1+ lda  x0 1+ sbc  dx 1+ sta  
    ]?  y1 lda  y0 cmp                   
 CC ?[  sec  y0 lda  y1 sbc  dy sta      
        iy sty                           
    ][               y0 sbc  dy sta      
    ]?  dx 1+ lda                        
                                         
                                         
\ Gr line 2                    20oct87re 
                                         
 0= ?[  dx lda  dy cmp                   
  CC ?[  dy ldx  dy sta  dx stx          
         ix lda  ay sta  iy lda  ax sta  
         iny  ix sty  iy sty  ]?  ]?     
 dx 1+ lda  .A lsr  offset 1+ sta        
 dx lda     .A ror  offset sta           
sec  CC ?[  .( Trick!! )                 
 [[ ix lda                               
    0<> ?[ 0>= ?[  x0 winc               
               ][  x0 wdec  ]?  ]?       
    clc  y0 lda  ax adc  y0 sta          
    clc  offset lda  dy adc  offset sta  
    CS ?[  offset 1+ inc  ]?   ct winc   
    dx lda  offset cmp  dx 1+ lda        
    offset 1+ sbc                        
    CC ?[  sec  offset lda  dx sbc       
           offset sta  offset 1+ lda     
           dx 1+ sbc  offset 1+ sta      
           ay lda                        
           0<> ?[  0>= ?[  x0 winc       
                       ][  x0 wdec ]? ]? 
           clc  y0 lda  iy adc  y0 sta   
    ]?                                   
\ Gr line 3 flipline           20oct87re 
                                         
 swap  ]?  .( Part 2 of trick! )         
 compute jsr                             
 bytnr 1+ ldx bitmap hbyte # cpx cs ?[   
Label mode                               
 bytnr )Y ora  bytnr )Y sta ]?           
 1 inc  cli                              
    dx lda  ct cmp                       
    dx 1+ lda  ct 1+ sbc  CC ?]          
 xyNext jmp  end-code                    
                                         
Code drawto  ( x1 y1 -)                  
 3 # ldy                                 
 [[ pointy ,Y lda  y1 ,Y sta  dey  0< ?] 
 2 # lda setup jsr  (drawto jmp          
end-code                                 
                                         
: flipline   ( x1 y1 x0 y0 -)            
 $51 ( eor )  mode c! line               
 $11 ( ora )  mode c! ;                  
                                         
\ bad self-modifying code                
                                         
                                         
\ Sprite constants             20oct87re 
                                         
  $C800 Constant sprbuf                  
| $D000 Constant sprbase                 
| $D010 Constant xposhi                  
  $D015 Constant sprite                  
| $D017 Constant yexpand                 
  $D01C Constant 3colored                
| $D01D Constant xexpand                 
| $D025 Constant sprmcol                 
| $D027 Constant sprcol                  
                                         
| Create sbittab                         
 $01 c, $02 c, $04 c, $08 c,             
 $10 c, $20 c, $40 c, $80 c,             
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Spr setbit set formsprite    20oct87re 
                                         
| Code setbit   ( bitnr adr fl  -)       
 3 # lda  setup jsr  dey                 
 N 4 + ldx  sbittab ,X lda               
 N ldx                                   
 0= ?[ $FF # eor  N 2+ )Y and            
    ][  N 2+ )Y ora  ]?                  
 N 2+ )Y sta  xyNext jmp  end-code       
                                         
: set   ( bitnr adr  -)   True  setbit ; 
                                         
: reset ( bitnr adr  -)   False setbit ; 
                                         
: getform  ( adr mem#  -)                
 $40 * sprbuf + $40 cmove ;              
                                         
| : sprite!   ( mem# spr# adr -)         
 $3F8 + + c! ;                           
                                         
: formsprite  ( mem# spr# -)             
 >r sprbuf $3F00 and $40 / + dup         
 r@ vidram sprite!  r> colram sprite! ;  
                                         
                                         
\ Spr move sprpos              20oct87re 
                                         
: xmove   ( x spr#  -)                   
 2dup 2* sprbase + c!                    
 xposhi rot $FF > setbit ;               
                                         
: ymove   ( y spr#  -)                   
 2* 1+ sprbase + c! ;                    
                                         
: move    ( y x spr#  -)                 
 under xmove ymove ;                     
                                         
                                         
: sprpos  ( spr# - y x)                  
 dup >r 2* 1+ sprbase + c@               
 r@ 2* sprbase + c@                      
 r> sbittab + c@ xposhi c@ and           
 IF $100 + THEN ;                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Sprite Qualities             20oct87re 
                                         
: high    ( spr# -)   yexpand set ;      
                                         
: low     ( spr# -)   yexpand reset ;    
                                         
: wide    ( spr# -)   xexpand set ;      
                                         
: slim    ( spr# -)   xexpand reset ;    
                                         
: big     ( spr# -)   dup high wide ;    
                                         
: small   ( spr# -)   dup low slim ;     
                                         
: behind  ( spr# -)   $D01B set ;        
                                         
: infront ( spr# -)   $D01B reset ;      
                                         
: colored ( spr# col  -)                 
 swap sprcol + c! ;                      
                                         
                                         
                                         
                                         
                                         
\ Spr sprcolors setsprite      20oct87re 
                                         
: sprcolors  ( col# col#  -)             
 sprmcol 1+ c! sprmcol c! ;              
                                         
: setsprite  ( mem# y x color spr# -)    
 under >r colored   r@ move              
 r@ under formsprite small               
 r@ 3colored reset  r> sprite set ;      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Tu heading left right        20oct87re 
                                         
| Variable xpos     | Variable ypos      
| Variable deg      | Variable pen       
                                         
| : 100*/  ( n1 n2 n3 - n4)  &100 */ ;   
                                         
: heading     ( - deg)    deg @ ;        
: setheading  ( deg -)    deg ! ;        
                                         
: right  ( deg -)                        
 deg @ swap - &360 mod deg ! ;           
                                         
: left   ( deg -)                        
 deg @ + &360 mod deg ! ;                
                                         
                                         
' clrscreen  Alias cs                    
' pencolor   Alias pc                    
' background Alias bg                    
' hires      Alias fullscreen            
' window     Alias splitscreen           
                                         
                                         
                                         
\ Tu positions pen home        20oct87re 
                                         
: xcor    ( - x)     xpos @ 100u/ ;      
: ycor    ( - y)     ypos @ 100u/ ;      
                                         
: setx    ( x -)     100* xpos ! ;       
: sety    ( y -)     100* ypos ! ;       
: setxy   ( x y -)   sety setx ;         
                                         
: pendown  pen on ;                      
: penup    pen off ;                     
                                         
: home                                   
 &160 &96 setxy &90 setheading pendown ; 
                                         
: draw     clrscreen home &20 window ;   
: nodraw   text page ;                   
                                         
                                         
' left       Alias lt                    
' right      Alias rt                    
' setheading Alias seth                  
' pendown    Alias pd                    
' penup      Alias pu                    
                                         
\ Tu forward back              20oct87re 
                                         
: tline   ( x1 y1 x2 y2 -)               
 >r >r >r  100u/  r> 100u/               
        r> 100u/  r> 100u/  line ;       
                                         
: forward  ( distance -)                 
 >r xpos @ ypos @                        
 over deg @ cos r@ 100*/ + dup xpos !    
 over deg @ sin r> 100*/ + dup ypos !    
 pen @ IF tline ELSE 2drop 2drop THEN ;  
                                         
: back     ( distance -)                 
 negate forward ;                        
                                         
: turtlestate ( - pen bg pc)             
 pen c@ colram c@ dup                    
 &15 and swap &16 / ;                    
                                         
' forward     Alias fd                   
' back        Alias bk                   
' turtlestate Alias ts                   
                                         
                                         
                                         
\ Gr arc ellipse circle        20oct87re 
                                         
: arc     ( hr vr strt end -)            
 >r >r 2dup max &360 swap /              
 r> 2* 2* r> 1+ 2* 2* swap rot >r        
  DO over I 2/ 2/ cos &10005 */          
     over I 2/ 2/ sin &10005 */          
     plot                                
  r@ +LOOP                               
 r> 2drop drop ;                         
                                         
: ellipse ( x y hr vr -)                 
 2swap c-y ! c-x ! m-flag on             
 0 &90 arc m-flag off ;                  
                                         
: circle  ( x y r -)                     
 dup 3 4 */ ellipse ;                    
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Math Load-Screen            20oct87re  
                                         
Onlyforth                                
                                         
base @  decimal                          
                                         
   1  2 +thru  \ Trigonometry            
   3  4 +thru  \ roots                   
   5  6 +thru  \ 100* 100u/              
                                         
base !                                   
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Ma sinus-table               20oct87re 
\    Sinus-Table from FD Vol IV/1        
                                         
| : table    ( values n -)               
 Create 0 DO , LOOP                      
 ;code       ( n - value)                
 SP X) lda  clc  1 # adc  .A asl  tay    
 W )Y lda  SP X) sta                     
 iny  W )Y lda  1 # ldy  SP )Y sta       
 Next jmp  end-code                      
                                         
10000 9998 9994 9986 9976 9962 9945 9925 
 9903 9877 9848 9816 9781 9744 9703 9659 
 9613 9563 9511 9455 9397 9336 9272 9205 
 9135 9063 8988 8910 8829 8746 8660 8572 
 8480 8387 8290 8192 8090 7986 7880 7771 
 7660 7547 7431 7314 7193 7071 6947 6820 
 6691 6561 6428 6293 6157 6018 5878 5736 
 5592 5446 5299 5150 5000 4848 4695 4540 
 4384 4226 4067 3907 3746 3584 3420 3256 
 3090 2924 2756 2588 2419 2250 2079 1908 
 1736 1564 1392 1219 1045 0872 0698 0523 
 0349 0175 0000                          
                                         
&91 | table sintable                     
\ Ma sin, cos, tan             20oct87re 
                                         
| : s180   ( deg -- sin*10000:sin 0-180) 
 dup &90 >                               
   IF &180 swap - THEN                   
 sintable ;                              
                                         
: sin     ( deg -- sin*10000)            
 &360 mod dup 0< IF &360 + THEN          
 dup &180 >                              
    IF &180 - s180 negate                
    ELSE s180 THEN ;                     
                                         
: cos     ( deg -- cos*10000)            
 &360 mod &90 + sin ;                    
                                         
: tan     ( deg -- tan*10000)            
 dup sin swap cos ?dup                   
   IF &100 swap */ ELSE 3 * THEN ;       
                                         
                                         
                                         
                                         
                                         
                                         
\ Ma sqrt 1                    20oct87re 
                                         
Code d2*  ( d1 - d2)                     
 2 # lda setup jsr                       
 N 2+ asl N 3 + rol  N rol N 1+ rol      
 SP 2dec N 3 + lda SP )y sta             
 N 2+ lda SP x) sta                      
 SP 2dec N 1+ lda SP )y sta              
 N lda SP x) sta                         
 Next jmp end-code                       
                                         
: du< &32768 + rot &32768 + rot rot d< ; 
| : easy-bits  ( n1 -- n2)               
 0 DO                                    
  >r d2* d2*  r@ -  dup 0<               
    IF   r@ +   r> 2* 1-                 
    ELSE        r> 2* 3 +                
    THEN LOOP ;                          
                                         
| : 2's-bit                              
 >r d2* dup 0<                           
  IF    d2* r@ - r> 1+                   
  ELSE  d2* r@ 2dup u<                   
   IF drop r> 1-  ELSE -  r> 1+  THEN    
  THEN ;                                 
\ Ma sqrt 2                    20oct87re 
                                         
| : 1's-bit                              
 >r dup 0<                               
  IF 2drop r> 1+                         
  ELSE d2* &32768 r@  du< 0=             
    negate R> +                          
  THEN ;                                 
                                         
: sqrt    ( ud1 - u2)                    
 0 1  8 easy-bits                        
 rot drop 6 easy-bits                    
 2's-bit 1's-bit ;                       
                                         
\\                                       
                                         
: xx                                     
 &16 * &62500 um*                        
 sqrt 0 <# # # # ascii . hold #s #>      
 type space ;                            
                                         
                                         
                                         
                                         
                                         
\ 100*                         20oct87re 
                                         
Code 100*  ( n1 - n2)                    
 SP X) lda  N sta  SP )Y lda  N 1+ sta   
 N asl N 1+ rol  N asl N 1+ rol          
                                         
 N lda N 2+ sta  N 1+ lda N 3 + sta      
                                         
 N 2+ asl N 3 + rol  N 2+ asl N 3 + rol  
 N 2+ asl N 3 + rol                      
                                         
 clc N lda N  2+ adc N sta               
  N 1+ lda N 3 + adc N 1+ sta            
                                         
 N 2+  asl N 3 + rol                     
                                         
 clc N lda N  2+ adc  SP X) sta          
  N 1+ lda N 3 + adc  SP )Y sta          
                                         
 Next jmp end-code                       
                                         
                                         
                                         
                                         
                                         
\ 100/                         20oct87re 
                                         
Label 4/+                                
 N 7 + lsr N 6 + ror N 5 + ror N 4 + ror 
 N 7 + lsr N 6 + ror N 5 + ror N 4 + ror 
 clc N  lda N 4 + adc N     sta          
  N 1+  lda N 5 + adc N 1+  sta          
  SP X) lda N 6 + adc SP X) sta          
  SP )Y lda N 7 + adc SP )Y sta  rts     
                                         
Code  100u/  ( u - n)                    
 N stx  N 4 + stx                        
 SP X) lda  .A asl N 1+  sta  N 5 + sta  
 SP )Y lda  .A rol SP X) sta  N 6 + sta  
 txa .A rol        SP )Y sta  N 7 + sta  
 4/+ jsr                                 
 N 7 + lsr N 6 + ror N 5 + ror N 4 + ror 
 4/+ jsr                                 
 Next jmp end-code                       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for csave cload            clv10oct87 
                                         
                                         
The Assembler must be loaded             
                                         
                                         
set Labels                               
                                         
                                         
 Save parameter starting at N            
 Enable SysMessages    Status to 0       
 (set drv for derror?                    
 Device#, Sec.Address, File#             
 Address-of-Filename Length              
 Address in XY                           
                                         
                                         
 One of 8 Kernalerrors?                  
 check Status/destroy EOI-Bit            
 send both back as Error Number          
                                         
                                         
                                         
                                         
                                         
\\ for ..csave cload          clv10oct87 
                                         
                                         
 prepare Parameter     (XR=to+1)         
 Pointer to from in AR and BSAVE         
 Error?                                  
                                         
                                         
 prepare Parametr      (XR=from)         
 Load (no Verify) BLOAD                  
 to+1 will be given back                 
 place on the Forth Stack                
 Error?                                  
                                         
                                         
                                         
Errorsources for CBM-Routinen:           
(1) Kernal-Result                        
(2) Status-Register                      
(3) Disk-Errorchannel                    
                                         
                                         
                                         
                                         
                                         
\\ for ..csave cload Luxus    clv10oct87 
                                         
                                         
                                         
This routine is using the BASIC          
Basic-Errormessages, so that the         
messages doesn need to be defined        
again. This is using the BASIC ROM.      
The BASIC Rom should only be used if     
no Site Effects occur, which is the      
case here.                               
                                         
                                         
                                         
                                         
                                         
creates an Errormessage from Error-      
number                                   
If not "device not presen"               
if is querying the serial bus for        
device error message                     
                                         
                                         
                                         
                                         
\\ for TapeVersion            clv01aug87 
                                         
The Tapeversion was developed for C16    
with 64kB, but also works on the C64     
                                         
                                         
It conists of 3 parts                    
   A virtual floppy in memory (Ramdisk)  
   An Interface to the external Device   
     Tape Recorder                       
   Supertape loader                      
     (only for C16)                      
                                         
                                         
                                         
                                         
Initializing:                            
 init Supertape if possible              
 redefine and activate R/W               
 if AUTOLOAD enabled, load Ramdisk       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD: loadscreen         clv05aug87 
                                         
This Ramdisk is using a compressed       
format                                   
                                         
To allow switching of ramdisks, the      
code contains one variable (RD that      
contains a pointer to the ramdisk.       
All other variables are stored in the    
Ramdisk Memory area                      
                                         
                                         
Binaerblocks must be marked with BINARY  
this Ramdisk support all Block Forth-    
Words that use R/W                       
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ For RD:                    clv01aug87 
                                         
\ All Pointers are offsets from First    
                                         
rd ==0 ==>   no Ramdisk                  
                                         
rd -->Length of Parametrblock            
+2 -->current Block                      
+4 -->End of last Block+1                
+6 -->End of Ramdisk-Area+1              
+8 -->Number of current Block            
+16-->Name                               
End of Parameterblock                    
     1.RD-Block                          
     2.RD-Block                          
       .                                 
     0000                                
                                         
adr-->current RD-Block (absolute Addr)   
   -->Length (incl. 4 bytes RD-Data)     
 2+-->Blocknumber                        
 2+-->..Data..                           
                                         
                                         
                                         
\\ for RD:                    clv01aug87 
                                         
NEW checks for enough space and          
    set current block to free space      
                                         
                                         
                                         
LEN! stores the length of new block      
    and patches END                      
    If length is=0 nothing happends      
    Creates 0000 at the End of Ramdisk   
                                         
LEN@ returns length of current Block     
    If not available, returns 0          
                                         
                                         
DEL deletes current block and patches    
    END                                  
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD:                    clv01aug87 
                                         
SEARCH set current block to searched     
  Block, if not found, to END            
  Blocknumber will be stored in BLK#     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
BINARY disables compression of Block     
  for example for Binary-Data            
  A binary block will be detected if     
  length is $400                         
                                         
                                         
                                         
\\ for RD: c>7 7 >c           clv01aug87 
                                         
Convert CBM-Chars to 7bit                
All chars $c0..$e0 will be $60..80       
All other >=$80 will be $00..20          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD: cp1 cp2            clv01aug87 
                                         
Start routine for COMPRESS & EXPAND      
                                         
                                         
                                         
                                         
                                         
                                         
Endroutine for COMPRESS & EXPAND         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD: expand compress    clv01aug87 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD:ramR/W              clv01aug87 
                                         
ENDWRITE removes Blanks at end of Block  
   and set LEN!                          
                                         
                                         
                                         
ENDREAD fills Reminder of block with     
        Blank                            
                                         
RAMR/W  replaces the R/W-Routine         
  (binary) Blocks in full length will    
  copied by CMOVE, shorter blocks will   
  be copied with COMPRESS (write) and    
  EXPAND (read).                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD:id rduse..          clv01aug87 
                                         
.RD  print information about current RD  
                                         
                                         
ID!  set name of Ramdisk                 
                                         
                                         
                                         
                                         
ID"  reads name of Ramdisk               
                                         
RDUSE switches (without checks) to RD    
RDDEL clears Ramdisk                     
                                         
                                         
                                         
RDNEW creates a new Ramdisk and          
      checks (almost) everything         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for RD: rdcheck            clv01aug87 
                                         
                                         
                                         
RDCHECK checks pointer of Ramdisk and    
        prints table of contents         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:LoadScreen          clv01aug87 
                                         
Supertape is a fast loader using         
3600 Bd or 7200 Bd approx. 10 times      
fster then the original CBM-Routines     
                                         
 Usage:                                  
  DeviceNumber  =  7 ==> Supertape       
  SecAddress   >=$80 ==> 7200 Bd         
                <$80 ==> 3600 Bd         
                ..everything else like   
                  CBM                    
StorageFormat 8Bit per Byte, Lowbit 1st  
Selfregulating, on each Bitborder is     
a edge-switch                            
If there is anotherone in the middle     
the bit is  Bit=0, else=1.               
                                         
Format: sync #$2a 25b:Header 2b:checksum 
        sync #$c5 len:Data   2b:checksum 
Sync  = 64b:#$16                         
Header=16b:Name                          
       1b:SecAdd 2b:from 2b:len 4b:#$00  
                                         
                                         
\\ for ST:Labels.             clv16jun87 
                                         
-------- hardware-Addresses-----------   
1  Cassettenport                         
2  Time for Timer2                       
1  controllregister for Timer2           
1  Writeaccess switches to RAM           
1  Writeaccess switches to ROM           
                                         
-------- System-Vectors  -------------   
2  Save-Vector of System will be patched 
2  Load-Vector of System will be patched 
                                         
----- Input-Parameter Load/Save-----     
1  Device-Number                         
1  Secundaryaddress (controls Device)    
2  Pointer to filenames                  
1  Number of Chars in Filename           
2  Startaddress for LOAD                 
2  Startaddress for SAVE                 
2  Endaddress+1 for SAVE                 
                                         
----- Outpute-Parameter for Load/Save -- 
1  Status Flags of OS                    
                                         
\\ zu ST:..Labels             clv16jun87 
                                         
-------- benutzte System-Routinen -----  
   start Cassette Motor                  
   stop  Cassette Motor                  
   init Cassette Port                    
   init Cassette Port                    
   normal  Load-Routine                  
   normal  Save-Routine                  
   print 'Loading' or 'Verifying'        
   print 'Press play..'                  
   print 'Press Record.. '               
   print 'Found'                         
   print 'Searching'                     
   print one char                        
                                         
-------- used Zeropage-Addresses -----   
                                         
2  Address of current I/O  Byte          
2  Address of last    I/O  Byte +1       
1  next Block: Verify/-Load              
1  next Block: Header/Data               
1  last State of Cassetteport            
1  already loaded part of current Byte   
1  last loaded byte                      
\\ for ST:..Labels            clv16jun87 
                                         
                                         
2  short/long Impuls for Save            
2  Checksum                              
                                         
1  Stackpointer for Error Exit           
                                         
                                         
----- additional Systemaddresses-----    
1  Time for next TimerBStart             
c0 Buffer for Cassetteoperations         
-  End of Buffer, Low-Byte               
                                         
----------- Constants  --------------    
   DeviceNumber of Supertape             
   1.Byte of Headerblock                 
   1.Byte of Datablock                   
   Time 7600 Baud loading                
   Time 3600 Baud loading                
   Time 7600 Bd save long/short Impuls   
   Time 7600 Bd save long/short Impuls   
   Byte for Sync-Header                  
   min. Number of SyncBytes for Loading  
   Number of SyncBytes for Saving        
\\ for ST:misc                clv28jul87 
                                         
Start of Bootstraploader                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
 (1)                                     
Start Timer Number 2                     
 (1)                                     
with time in STIME                       
                                         
                                         
                                         
                                         
Wait-Loop                                
                                         
(1) the Sequence 'brk brk bit brk brk'   
    stops overwriting data at boottime   
    if a read-error occurs               
                                         
\\ for ST:stEnd etc.         clv18jun87  
                                         
                no     Error (Bit--)     
                Load-     "  (Bit--)     
 AR := ErrorNr  EOT -     "  (Bit--)     
                Verify-   "  (Bit--)     
                Stop-     "              
 Switch to ROM, push Error               
 Port exit                               
 repair Stack                            
 xr-yr := Load-EndAddress                
 CF    := Error, enable Interrupt        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:bitRead             clv16jun87 
                                         
                                         
wait for timer                    (?)    
Carry := 1 , if level equal == Bit=1     
 save bit                                
 rotate in byte                          
if Bit=1: increment checksum             
wait for edge                            
save portstate, set timer                
return current byte                      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ zu ST:stRead..             clv28jul87 
                                         
 Data/or Header,Verifyerror := 0         
                                         
                                         
 syncronizing                            
                                         
 read Byte                               
                                         
 no Sync Byte? search for it             
                                         
 Header detected                         
    read Byte                            
    until Header ends AR=Block-kind      
 searched Block Kind? yes, read it       
 searched for Header, data found, cont.  
 othr Kund? Error                        
 Checksum := 0                           
 Read byte                               
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:..stRead            clv28jul87 
                                         
--- Loop from Load-Start till end        
 Checksum                                
             := Checksum                 
 read 2 Bit                              
 only Verify?                            
 else: load Byte                         
 read 2 Bit                              
 compare Byte                            
 increment verify error                  
 read 2 bit                              
 pointer to next byte                    
 new byte                                
 new byte                                
--- end of loop                          
--- end of loop                          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:..stRead            c2v27jul87 
                                         
 Checksum-Error?                         
   else Status                           
   and  LoadError-Exit                   
 read byte                               
                                         
 Checksum-Error?                         
 Verifyerror?                            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:stLoad..            clv16jun87 
                                         
will be load-vector of system            
 save Verify and Load, clear status      
 for Supertape?                          
 if not -> CBM-Routine                   
 save stack for error handling           
 'Press play on Tape' Stop?,then return  
 disable IRQ                             
 set to load                             
 'Searching...'                          
                                         
 Initializing                            
                                         
 3600 Baud/Load                          
 Search Header and Load                  
 'Found ..'                              
 print Filename                          
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:..stLoad            clv16jun87 
                                         
                                         
                                         
 compare all chars                       
                                         
  same as in entred filename?            
                           continue      
  entered Char   '?'  ?    continue      
  End-Of-Tape         ?                  
                           then NotFound 
  else: enable Screen, cont. search      
 repair Verify Flag                      
 'loading'/'verifying'                   
 LoadAddress  := from System             
                                         
 SecAdd.=1?                              
                                         
   then loadaddress from header          
                                         
 LoadEnd                                 
         :=                              
             LoadAddress                 
            +FileLength                  
                                         
\\ for ST:..stLoad            c2v27jul87 
                                         
                                         
 7200 Baud/Load                          
 saved with 3600 Bd (==Secadd>$80)?      
 then 3600 Bd/Load                       
 switch to RAM, load Datablock           
 End                                     
                                         
Will be used for Bootstraploader         
                                         
                                         
                                         
                                         
Creates a string of Form 'g78b5',        
with address LOADSYS                     
will be used as Monitor-Command,         
with address of Bootstraploader          
s.a. SAVEBOOTER                          
                                         
This String cannot contain capital       
Letters                                  
                                         
                                         
                                         
\\ for ST:wByte w4bits        clv16jun87 
                                         
                                         
                                         
 4 Bits                                  
 --- Loop over 4 Bits                    
    bit=1?, set full timer               
    wait for timer                       
    start new                            
    write edge                           
    bit=0?                               
       wait for timer                    
       and start new                     
       write edge (Bit-border)           
    bit=1?                               
       increment Checksum                
                                         
                                         
       set half time                     
 --- End of loop                         
                                         
                                         
                                         
                                         
                                         
\\ for Rd:stWrite             clv18jun87 
                                         
 AR=BlockKind                            
 save                                    
 SynchronisationBytes                    
 ..write                                 
 write BlockKind                         
 Checksum:= 0                            
 --- Loop for 1st till last Byte         
                   upper 4 Bits          
                   lower 4 Bits write    
 --- Loop...                             
 --- ..End                               
 Checksum..                              
 ..write Low Byte                        
 ..write High Byte                       
 few Extrabits, ensures that loading     
 will end                                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:saveName            clv01aug87 
                                         
writes FileName in Cassettebuffer        
 CassetteBuffer  [0..$10]                
              := <blanks>                
 CassetteBuffer  [0..FileNameLength]     
              :=                         
                 FileName                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:stSave..            clv01aug87 
                                         
will by pacthed into OS Vector           
 DeviceNr = Supertape?                   
 else: use                               
    CBM-Save-Routine                     
 StackPointer saved for Errorhandling    
 FileName in Buffer                      
 ' Press Play & Record on Tape'  STOP?   
 Initializing                            
                                         
                                         
 Startaddress in Buffer -- change???     
                        -- for COPY?     
 FileLength                              
 ..calculate                             
 ..and                                   
 ..write into buffer                     
 CassBuffer [$21..$24]                   
                           := 0          
 Time-HighByte := 0                      
 SaveStartAdresse                        
               := CassetteBuffer         
 SaveEndAddress                          
               := Cassett.Buffer-End     
\\ for ST:..STSave            clv01aug87 
                                         
                                         
 3600Baud/short  SaveImpuls (==Bit=0)    
         /long   SaveImpuls (==Bit=1)    
 set                                     
 TimerNummer2   enabled                  
 Header  (==Buffer) write                
 write Pause                             
 7200Bd requested  (==SecAdd>=$80) ?     
 then 7200Bd/short  SaveImpuls           
            /long   SaveImpuls           
      set                                
 SaveBeginAddress                        
           := from System                
 SaveEndAddress                          
           := from System                
 enable RAM, write Data Block            
 write Pause, finish                     
                                         
                                         
                                         
                                         
                                         
                                         
\\ for ST:supertape stSavSys  clv10oct87 
                                         
SUPERTAPE                                
.. set current device                    
.. patches OS vectors                    
.. prints message                        
                                         
!! A Supertape-System must be saved in   
!! 3 Parts:                              
!!  1. Mini-Supertape                    
!!  2. Part of System before             
!!  3. Part of System aftr               
!! Part 1 will be saved in CBM-Format    
!! and is loading Part 2,3 in ST-Format  
                                         
  Attache Filename to gLOADSYS           
                                         
                                         
                                         
  1. from BUFFINIT to excl. BTL save in  
  CBM-Format                             
  use ST-Format                          
  2. store                               
  3.   "                                 
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Sieve benchmark              20oct87re 
                                         
Onlyforth                                
                                         
: allot  ( u --)                         
 dup sp@ here - $180 -  u>               
 abort" no room" allot ;                 
                                         
&8192 Constant size                      
Create flags   size allot                
: do-prime  ( -- #primes )               
 flags size 1 fill    0                  
 size    0 DO flags I + c@               
           IF  I 2* 3+ dup I +           
             BEGIN  dup size <           
             WHILE  0 over flags + c!    
                    over +               
             REPEAT  2drop 1+            
           THEN                          
        LOOP ;                           
: benchmark   9 0 DO do-prime drop  LOOP 
 do-prime . ." Primes" ;                 
: .primes   size 0 DO  flags I + c@      
 IF  I 2* 3+ .  THEN ?cr                 
 stop? IF  LEAVE  THEN  LOOP ;           
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Graphic-Demos Loadscreen     20oct87re 
                                         
Only Forth also definitions              
                                         
\needs Graphic -&80 +load                
                                         
Graphic also definitions                 
 page  .( Loading .....)                 
                                         
 1   4 +thru   \ Demo1,2,3,4 Demo        
 5     +load   \ Sinplot                 
 6 &11 +thru   \ Turtle demos            
                                         
                                         
wave wave1 triangle lines moire          
sinplot                                  
ornament circles worm coil               
town                                     
                                         
&20 window                               
                                         
                                         
                                         
                                         
                                         
\ Plot wave                    20oct87re 
                                         
&100 | Constant &100                     
&160 | Constant &160                     
: wave                                   
 cs red cyn colors hires                 
 &100 0 DO                               
 &99 0 DO                                
   I dup * J dup * + &150 / 1 and        
    IF &160 J + &100 I + plot            
       &160 J - &100 I + plot            
       &160 J - &100 I - plot            
       &160 J + &100 I - plot THEN       
  LOOP LOOP ;                            
                                         
: wave1                                  
 cs blu yel colors hires                 
 &160 0 DO                               
 &99 0 DO                                
   I dup * J dup * + 100u/ 1 and 0=      
    IF &160 J + &100 I + plot            
       &160 J - &100 I + plot            
       &160 J - &100 I - plot            
       &160 J + &100 I - plot THEN       
  LOOP LOOP ;                            
\ lineplot triangle            20oct87re 
                                         
| : grinit                               
 clrscreen                               
 yel blu colors hires ;                  
                                         
: triangle                               
 grinit                                  
 0 2 DO                                  
   &160 0 DO                             
      I &199 &160 I 2/     J + flipline  
   &320 I - &199 &160 I 2/ J + flipline  
   2 +LOOP                               
 -1 +LOOP text ;                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ lineplot linies moire        20oct87re 
                                         
: lines                                  
 grinit                                  
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
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ lineplot boxes               20oct87re 
                                         
Variable x0       Variable y0            
Variable x1       Variable y1            
                                         
: box   ( x1 y1 x0 y0 -)                 
 y0 ! x0 ! y1 ! x1 !                     
 x1 @ y0 @ x0 @ over flipline            
 x1 @ y1 @ over y0 @ flipline            
 x0 @ y1 @ x1 @ over flipline            
 x0 @ y0 @ over y1 @ flipline ;          
                                         
Create colortab                          
 blk c, lbl c, red c, lre c,             
 pur c, grn c, blu c,                    
                                         
: boxes                                  
 grinit                                  
 &10 3 DO                                
  &160 0 DO I dup &318 I - &198 I - box  
        J +LOOP                          
   I 3 - colortab + c@  pencolor         
   LOOP ;                                
                                         
                                         
\ Graphic sinplot              20oct87re 
                                         
&10000 Constant 10k                      
                                         
: sinplot                                
 grinit                                  
 &319  &96   0 &96 line                  
 &160 &197 &160  0 line                  
 &152 &160 negate DO                     
  I &160 + &96 I sin &96 10k */ +        
  I &168 + &96 I 8 + sin &96 10k */ +    
  line                                   
 8 +LOOP                                 
 &152 &160 negate DO                     
  I &160 + &96 I cos &96 10k */ +        
  I &168 + &96 I 8 + cos &96 10k */ +    
  line                                   
 8 +LOOP  ;                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Turtle demos                 20oct87re 
                                         
| : tinit    ( -- )                      
 clrscreen  hires   \ showturtle         
 red cyn colors ;                        
                                         
| : shome  ( -- )                        
 tinit &65 0 setxy &90 seth pendown ;    
                                         
: polygon   ( length edges -- )          
 &360 over /                             
 swap 0 DO  over forward                 
            dup right     LOOP 2drop ;   
                                         
| : ring  ( edges -- )                   
 &200 over / swap                        
 &18 0 DO  2dup polygon                  
          &20 right  LOOP  2drop ;       
                                         
: ornament  ( -- )                       
 tinit home                              
 &10 3 DO  clrscreen  I dup 7 -          
          IF  ring  ELSE  drop  THEN     
          LOOP ;                         
                                         
\ Turtle demos 1               20oct87re 
                                         
: circles  ( -- )                        
 tinit                                   
  2 -1 DO home                           
   &10 0 DO                              
    &20 I 2* - &20 polygon               
    xcor &10 I 2/  - - setx              
    ycor &10 I - J * - sety              
   LOOP                                  
  2 +LOOP ;                              
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Turtle demos 2               20oct87re 
                                         
| : (worm      ( length -- )  recursive  
 dup 5 < IF  drop exit  THEN             
 dup forward &90 right                   
 2- (worm ;                              
                                         
| : (coil  ( length -- )  recursive      
 dup 5 < IF drop exit THEN               
 dup forward &91 right                   
 2- (coil ;                              
                                         
: worm ( -- )                            
 shome &190 (coil ;                      
                                         
                                         
: coil ( -- )                            
 shome 5 forward &190 (coil ;            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Turtle demos 3               20oct87re 
                                         
| : startpos                             
 &15 0 setxy &90 setheading ;            
                                         
| : continue ( -- )                      
 &90 right penup &55 forward             
 pendown &90 left ;                      
                                         
| : chimney                              
 xcor ycor                               
 &50 fd &30 rt &15 fd &30 lt             
 &30 fd &90 rt &12 fd &90 rt  8 fd       
 setxy &90 setheading ;                  
                                         
| : house                                
 &50 4 polygon &50 forward  &30 right    
 &50 3 polygon &30 left  &50 back        
 &90 right &15 forward &90 left          
 &20 4 polygon                           
 &90 left &15 forward &90 right          
 chimney ;                               
                                         
                                         
                                         
\ Turtle demos 4               20oct87re 
                                         
| : rowofhouses                          
 tinit startpos                          
 4 0 DO house continue LOOP house ;      
                                         
| : housewindow                          
 xcor ycor                               
 penup &30 fd &90 rt &10 fd &90 lt       
 pendown                                 
 &10 4 polygon &90 rt                    
 penup &20 fd &90 lt                     
 pendown &10 4 polygon                   
 setxy ;                                 
                                         
: town       rowofhouses                 
 startpos 4 0 DO housewindow continue    
 LOOP                                    
 housewindow ;                           
                                         
                                         
                                         
                                         
                                         
                                         
\ Turtle demos 5               20oct87re 
                                         
| : (medal ( len grad -- ) recursive     
 stop? 0= and ?dup                       
 IF  over 3 / swap 1-                    
  4 0 DO 2dup (medal 2 pick forward      
         &90 right  LOOP 2drop           
  THEN drop ;                            
                                         
: medal                                  
 tinit shome &192 5 (medal ;             
                                         
\\                                       
                                         
: (6medals   ( len grad -)  recursive    
 ?dup IF  over 3 / swap 1-               
  6 0 DO 2dup (6medals 2 pick forward    
         &60 right  LOOP 2drop           
  THEN drop ;                            
                                         
: 6medals                                
 tinit shome &80 &55 setxy               
 &85 3 (6medals ;                        
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Sprite-Demo                  23oct87re 
                                         
\needs graphic   -&96 +load              
                                         
Onlyforth graphic also  Forth            
                                         
.( Loading...)                           
                                         
  1   4 +thru                            
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Sprite-Demo                  20oct87re 
                                         
Create Shapes  5 $40 * allot             
 blk @ 4 +  block                        
 Shapes  5 $40 * cmove                   
                                         
: init  ( -)                             
 graphic page                            
 blu border  blu background              
 5 0 DO                                  
     Shapes  I $40 * +  I getform LOOP   
 grn wht sprcolors                       
 5 0 DO  I 0 0 wht I setsprite  LOOP     
 5 0 DO  I small  I high  I 3colored set 
         I behind LOOP  ;                
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Sprite-Demo                  20oct87re 
                                         
: ypos  ( spr# - y)  sprpos drop ;       
                                         
: xpos  ( spr# - x)  sprpos nip ;        
                                         
&26 Constant Distance                    
                                         
: 1+0-1  ( n - +1/0/-1)                  
 dup 0= not swap 0< 2* 1+ and ;          
                                         
: follow-sprite ( spr# -)                
>r r@ xpos  r@ 1- xpos  Distance +       
   over -  1+0-1 + &344 min  r@ xmove    
   pause                                 
   r@ ypos  r@ 1- ypos                   
   over -  1+0-1 +           r> ymove    
   pause ;                               
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ Sprite-Demo                  20oct87re 
                                         
: follow-cursor  ( spr# -)               
>r r@ xpos  Col 8 * &33 +                
   over -  1+0-1 +  r@ xmove  pause      
   r@ ypos  Row 8 * &59 +                
   over -  1+0-1 +  r> ymove  pause ;    
                                         
: follow  ( spr# -)                      
pause  dup IF   follow-sprite            
           ELSE follow-cursor THEN ;     
                                         
: killsprites  ( -)  0 sprite c! ;       
                                         
: slide-sprites  ( -)                    
5 0 DO  I follow  I 1+ 0 DO  I follow    
LOOP LOOP ;                              
                                         
\\                                       
                                         
: testslide ( -)                         
init BEGIN  slide-sprites                
            key dup con!  3 = UNTIL ;    
                                         
                                         
\ Sprite-Demo                  20oct87re 
                                         
\needs tasks   .( Tasker? ) \\           
                                         
$100 $100 Task Demo                      
                                         
: slide  ( -)                            
 Demo activate                           
 init BEGIN  slide-sprites  REPEAT ;     
                                         
: endslide  ( -)                         
 killsprites  Demo activate  stop ;      
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
\ tiny sprite editor           06nov87re 
                                         
Onlyforth Graphic also definitions       
                                         
\needs sprbuf  Create sprbuf $100 allot  
\needs >byte : >byte $100 /mod ;         
                                         
| Variable cbase  2 cbase !              
                                         
| : width ( -- n )  &16 cbase @ / ;      
                                         
| : (l: ( -- )                           
 base push  cbase @ base !               
 name number  name number drop           
 >r  >byte drop  r@ c!                   
 >byte r@ 1+ c!  r> 2+ c! ;              
                                         
: l: (l: quit ;                          
                                         
: #.r  ( n width -- )                    
 >r 0 <#  r> 0 DO  #  LOOP  #> type ;    
                                         
: arguments  ( n -- )                    
 depth < not abort" Arguments?" ;        
                                    -->  
\ tiny sprite editor           06nov87re 
                                         
| Create savearea $1A allot              
| Variable xsave    | Variable ysave     
| Variable saved    saved off            
                                         
| : savesprites  ( -- )                  
 saved @ ?exit                           
 sprite savearea $1A cmove  0 sprite c!  
 7 sprpos xsave ! ysave ! saved on ;     
                                         
: fertig  ( -- )                         
 saved @ not ?exit                       
 ysave @ xsave @ 7 move                  
 savearea sprite $1A cmove saved off ;   
                                         
| : sprline  ( adr line -- )             
 base push  dup 2* + +  cr               
 ." l: "  cbase @ base !                 
 dup count width #.r  count width #.r    
 c@ width #.r  ." . $" hex 4 #.r ;       
                                         
                                         
                                         
                                    -->  
\ tiny sprite editor           06nov87re 
                                         
| : slist  ( mem# -- )                   
 $40 * sprbuf +                          
 &21 0 DO  dup I sprline                 
           stop? IF  LEAVE  THEN  LOOP   
 drop cr  ." fertig"  0 0 at quit ;      
                                         
: sed  ( mem# -- )                       
 1 arguments  &32 min                    
 page dup . ." sed \ 1 color"            
 savesprites  2 cbase !                  
 dup $40 $128 yel 7 setsprite            
 7 3colored reset  7 big  slist ;        
                                         
: ced  ( mem# -- )                       
 1 arguments  &32 min                    
 page dup . ." ced \ 3 colors"           
 savesprites  4 cbase !                  
 blk gr2 sprcolors                       
 dup $40 $128 yel 7 setsprite            
 7 3colored set  7 high  slist ;         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
