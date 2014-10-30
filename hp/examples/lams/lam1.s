!NO CODE
!RPL
::
  %2 %3
  {
    LAM first
    LAM sec
  }
  BIND        (first contains 2, and sec 3)
  LAM first   (recall contents from first - 2)
  LAM sec     (recall contents from sec - 3)
  DUP
  ' LAM first
  STO         (store new contents in first)
  %+          (results 5)
  ' LAM sec
  STO         (store sum in sec)
  ABND        (delete variables from memory)
;
@