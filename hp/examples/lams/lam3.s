!NO CODE
!RPL
::
  %2
  %1
  {
    LAM n2
    LAM n1
  }
  BIND
  1GETLAM   (Returns 1)
  2GETLAM   (Returns 2)

  %4
  %3
  {
    NULLLAM
    NULLLAM
  }
  BIND
  1GETLAM   (Returns 3)
  2GETLAM   (Returns 4)
  4GETLAM   (Returns 1)
  5GETLAM   (Returns 2)
  ABND
  ABND
;
@