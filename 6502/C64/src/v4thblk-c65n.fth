
\ with build log:
' noop alias \log
\ without build log:
\ ' \ alias \log

\log include logtofile.fth

include vf-tc-prep.fth

\log logopen" v4thblk-c65n.log"

include vf-trg-c65n.fth

\ The actual volksForth sources

include vf-head-c65n.fth
include vf-cbm-core.fth
include vf-sys-c65n.fth
include vf-sys-cbm.fth
\ todo
\ include vf-cbm-file.fth
\ include vf-cbm-bufs.fth
include vf-finalize.fth
\ put buffers, rstack, into free memory
\ area from $1600-$2000
  2000 ' limit >body !  19b8 r0 !  be00 s0 !
include vf-memsetup.fth

include vf-pr-target.fth
.( target compile complete) cr
\log logclose

quit
