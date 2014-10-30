!NO CODE
!RPL
::
  101 ONE_DO
    INDEX@ UNCOERCE
  LOOP
  100 P{}N                      (Make list with 1-100)
  DUP
  NULL{}                        (Empty list to collect)
  { LAM mylist LAM res } BIND   (Save a copy of the list)
  INNERCOMP                     (Explode for FPTR 2 72)
  "REALS"                       (Title)
  0                             (Initial position)
  '
  ::                            (The key handler)
    4 OVER#=case
    ::
      DROP DUP#1= 3PICK 23 #=
      ANDcase                   (SQRT key pressed)
      ::
        2DROP                   (DROP the keycodes)
        '
        ::
          LAM mylist
          2GETLAM 3GETLAM
          #+ #1+
          NTHCOMPDROP           (Get current value)
          %SQRT DO>STR          (Compute SQRT)
          FlashWarning          (Display)
        ;
        TrueTrue                (Yes, we handle this key)
      ;
      FALSE                     (Other keys not handled)
    ;
    5 OVER#=case                (Provide a menu)
    ::
      DROP
      ' ::
        NoExitAction            (Do not save as LastMenu)
        { { "->{}"              ("Add to list" menu key)
            :: TakeOver
               LAM res          (Get current list)
               2GETLAM          (Get element as string)
               3GETLAM #+
               GetElemBotVStack
               >TCOMP           (Add to list)
               ' LAM res STO    (STO current list)
            ; }
          { "?"                 ("Help" menu entry)
            :: TakeOver
               FPTR 2 88        (Save current screen)
               DOCLLCD          (Clear screen)
               ZEROZERO         (Next is the help text)
"->{}   ADD
?      HELP
SQRT   DISP ROOT"
               $>GROBCR
               XYGROBDISP       (Display help text)
               WaitForKey       (Wait for any key)
               2DROP
               FPTR 2 89        (Restore the screen)
            ;
          }
          { ::                  (Button to show)
               TakeOver           ("even" or "odd")
               LAM mylist       (The list)
               2GETLAM
               3GETLAM #+ #1+   (Get current element)
               NTHCOMPDROP
               DUP              (Test if even)
               %2 %/
               %FLOOR
               %2 %* %= ITE
               "even" "odd"     (Return correct label)
            ;
            NOP                 (No action when pressed)
          }
          NullMenuKey           (4th key is empty)
          { "CANCL"             (Default CANCL action)
            FPTR 2 77 }
          { "OK"                (Default OK action)
            FPTR 2 76 }
        }
      ;
      TRUE                      (Yes, we provide a menu)
    ;
    6 OVER#=case                (Enforce menu update)
    :: DROP FalseFalse
       24 PUTLAM ;
    DROPFALSE                   (Other messages)
  ;                               (are not handled)
  FPTR 2 72                     (Run the CHOOSE engine)
  ITE
    ::
      DROP                      (DROP current value)
      LAM res                   (Return list)
      TRUE                      (Push TRUE)
    ;
   FALSE                        (CANCL: return FALSE)
  ABND                          (Free local variables)
;
@