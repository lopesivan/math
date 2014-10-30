!NO CODE
!RPL
::
  %2 %3
  { NULLLAM NULLLAM }
  BIND
  2GETLAM     (recalls 2)
  1GETLAM     (recalls 3)
  DUP
  2PUTLAM
  %+
  1PUTLAM
  ABND
;
@