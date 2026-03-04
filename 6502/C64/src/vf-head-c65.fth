\ The head of C65 VolkForth
\ This runs mostly the C64 VolksForth using
\ C65's emulation ROM.
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
\ and ROM to mostly resemble a C64
Label c65init  c65init >c65init !
 \ disable cpu-based memory mapping
 sei  36 # lda   1 sta \ ROM on
 0 # lda   tax  tay  taz   map nop ( eom)
 41 # lda   0 sta  \ 40 MHz cpu
 \ enable VIC IV registers
 \ 47 # lda  D02f sta   53 # lda  D02f sta
 20 # lda  D031 sta \ disable H640 mode
\ continue with init in vf-cbm-core.fs
 0 jmp  here 2- >label >cold
end-code 
 
Create logo
  ," volksFORTH-83 3.9.6-C65  "
