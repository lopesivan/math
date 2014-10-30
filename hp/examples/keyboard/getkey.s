::
  WaitForKey        (normal WaitForKey)
  CODE              (get extended keycode)
    GOSBVL =SAVPTR
    D0=    047DF
    A=DAT0 A
    D0=A
    A=0    A
    A=DAT0 1
    A=A-1  P
    A=A+A  A
    CD0EX
    C=C+A  A
    CD0EX
    D0=D0+ 2
    A=DAT0 B
    GOVLNG =PUSH#ALOOP
  ENDCODE
  ROTDROPSWAP  (replace keycode with extended value)
;
@
