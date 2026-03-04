
\ with build log:
' noop alias \log
\ without build log:
\ ' \ alias \log

\log include logtofile.fth

include vf-tc-prep.fth

\log logopen" v4thblk-c65.log"

include vf-trg-c65.fth

\ The actual volksForth sources

include vf-head-c65.fth
include vf-cbm-core.fth
include vf-sys-c64.fth
include vf-cbm-file.fth
include vf-cbm-bufs.fth
include vf-finalize.fth
\ put buffers, rstack, into free memory
\ area from $800-$2000
  2000 ' limit >body !  bb8 r0 !  be00 s0 !
include vf-memsetup.fth

include vf-pr-target.fth
.( target compile complete) cr
\log logclose

quit
