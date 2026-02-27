#! /bin/bash

## Build a .d81 800 kB disk image containing both the VolksForth PRG
## file plus the blocks of all the 4 vforth4_1.d64 disks.

## Copyright (C) David Kuehling 2026

## License: BSD 2-Clause license

## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES ARE DISCLAIMED.  SEE
## THE FILE ../../../LICENSE FOR DETAILS.

## This is primarily meant for running an adapted C64 version of
## VolksForth on the Mega65 machine, which is very similar to the C65
## and comse with a built-in 1581 drive.

set -euxo pipefail
cd "$(dirname "$0")"

## Start with empty .d81 image (800 KiB) with a proper BAM etc.
rm -f empty.d81
cbmconvert -D8 empty.d81 -d empty.d64
cp empty.d81 vforth4.d81

## forth blocks 0..169 correspond to tracks 1..17.  Mark those as in use via the
## first BAM sector
dd if=/dev/zero of=vforth4.d81 bs=2 count=$((3*17)) \
   seek=$((0x61910/2)) conv=notrunc

## same for  blocks 200..369  (tracks 21..37)
dd if=/dev/zero of=vforth4.d81 bs=2 count=$((3*17)) \
   seek=$((0x61910/2+20*3)) conv=notrunc

## forth blocks 400..569 correspond to tracks 41..57.  Mark those as in use via the
## second BAM sector
dd if=/dev/zero of=vforth4.d81 bs=2 count=$((3*17)) \
   seek=$((0x61a10/2)) conv=notrunc

## same for  blocks 600..769  (tracks 61..77)
dd if=/dev/zero of=vforth4.d81 bs=2 count=$((3*17)) \
   seek=$((0x61a10/2+20*3)) conv=notrunc

## Now copy our CBM program files into the sectors marked unused in the BAM
cbmconvert -D8 vforth4.d81 -n ../cbmfiles/v4thblk-c65

## Now add the 4 vforth4*.d64 disk files with a stride of 200 blocks
for idx in 1 2 3 4; do
    dd if=vforth4_${idx}.d64 bs=1024 count=170 of=vforth4.d81 \
       seek=$(((idx-1)*200)) conv=notrunc
done

## Blank the binary .PRG block parts of vforth4_1.d64
set +x
(while true; do echo -n "                "; done) | (
    dd bs=1024 count=48 of=vforth4.d81 seek=37 conv=notrunc iflag=fullblock
    dd bs=1024 count=48 of=vforth4.d81 seek=122 conv=notrunc iflag=fullblock
)
