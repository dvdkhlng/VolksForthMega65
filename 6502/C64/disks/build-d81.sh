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

## output the blocks in the d64 files, skipping the 3-sector hole at sector
## $165 (created by (S#>S+T to skip over BAM and directory)
function d64blocks() {
    dd bs=256 count=$((0x165)) iflag=fullblock
    dd bs=256 count=3 of=/dev/null iflag=fullblock
    dd bs=256 count=$((683 - 0x165 - 3)) iflag=fullblock
}

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

## For 1581 disks we implement a 4-sector hole at the start of track
## 40 to skip over BAM, directory etc.  See (s#>s+t (for 1541 disks
## VolksForth adds a 3-sector hole to skip the BAM).  This introduces a
## 1-block offset for everything coming thereafter!

## forth blocks 400..569 correspond to tracks 41..58 with a 4-sector
## offset, due to the hole. Mark those as in use via the second BAM sector
dd if=/dev/zero of=vforth4.d81 bs=2 count=$((3*18)) \
   seek=$((0x61a10/2)) conv=notrunc

## same for  blocks 600..769  (tracks 61..78)
dd if=/dev/zero of=vforth4.d81 bs=2 count=$((3*18)) \
   seek=$((0x61a10/2+20*3)) conv=notrunc

## Now copy our CBM program files into the sectors marked unused in the BAM
cbmconvert -D8 vforth4.d81 -n ../cbmfiles/v4thblk-c65

## Now add the 4 vforth4*.d64 disk files with a stride of 200 blocks
for idx in 1 2 3 4; do
    d64blocks < vforth4_${idx}.d64 |
	dd bs=1024 count=170 of=vforth4.d81 iflag=fullblock \
	   seek=$(((idx-1)*200 + (idx>2? 1 : 0))) conv=notrunc
done

## Blank the binary .PRG block parts of vforth4_1.d64
set +x
(while true; do echo -n "                "; done) | (
    dd bs=1024 count=48 of=vforth4.d81 seek=37 conv=notrunc iflag=fullblock
    dd bs=1024 count=48 of=vforth4.d81 seek=122 conv=notrunc iflag=fullblock
)
