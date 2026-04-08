#! /bin/bash

set -euxo pipefail
cd "$(dirname "$0")"

## output the blocks in the d64 files, skipping the 3-sector hole at sector
## $165 (created by (S#>S+T to skip over BAM and directory)
function d64blocks() {
    dd bs=256 count=$((0x165)) iflag=fullblock
    dd bs=256 count=3 of=/dev/null iflag=fullblock
    dd bs=256 count=$((683 - 0x165 - 3)) iflag=fullblock
}

cp vforth4bl.d81 vforth4.d81

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
cbmconvert -D8 vforth4.d81 -n ../cbmfiles/v4thblk-c65n
