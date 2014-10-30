!NO CODE
!RPL
::
  CK1NOLASTWD   (check if there is an argument)
  CK&DISPATCH1  (check if it is a real number)
  BINT1 ::      (if it is)
    %2 %^       (square the radius)
    %PI         (put PI in the stack)
    %*          (and multiply)
  ;
;
@