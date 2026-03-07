\ The head of C65-native VolkForth
\ This runs VolksForth natively on the Mega65 ROM
\ See vf-head-c65.fth for a version that maps the C64 ROM
\ instead for less features but better compatibiltiy.

Onlyforth

2001 dup  displace !
Target definitions   here!


\ *** Block No. 16, Hexblock 10
10 fthpage

\ FORTH Preamble and ID

0D c, 20 c, 0A c, 00 c, 9E c, 28 c, 38 c, 32 c,
30 c, 38 c, 29 c, 00 c, 00 c, 00 c, 00 c, \ SYS(8208)

Assembler
  nop  0 jmp  here 2- >label >c65init
  nop  0 jmp  here 2- >label >restart

here dup origin!
\ Here are coldstart- and Uservariables
\
0 jmp  0 jsr  here 2- >label >wake
end-code
$100 allot

\ savesystem assumes that origin is at displace@+0x17.
\ so injecting the  C65 init here: Configure memory map
\ and ROM...
Label c65init  c65init >c65init !
 \ disable cpu-based memory mapping
 0 jmp  here 2- >label >cold
end-code 
 
Create logo
  ," volksFORTH-83 3.9.6-C65n  "
