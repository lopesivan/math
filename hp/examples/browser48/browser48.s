!NO CODE
!RPL
::
  NULL{}                      (start with empty list)
  ' LAM EQS
  1 DOBIND

  ' ::                        (the ::Appl parameter)
    60 #=casedrop TrueTrue    (use full screen)
    62 #=casedrop ::          (number of elements)
      LAM EQS LENCOMP
      DUP#0=IT
        #1+
      TRUE
    ;
    82 #=casedrop ::          (return nth element as str)
      LAM EQS SWAP
      NTHELCOMP
      ITE
        ::                    (convert to string)
          setStdWid
          FPTR2 ^FSTR7
        ;
       "No equations"
      TRUE
    ;
    83 #=casedrop ::          (the menu)
      {
        { "Add"
          ::
            PushVStack&Clear  (save stack)
            DoNewEqw
            DEPTH
            #0<> IT           (add eqaution)
              ::
                LAM EQS SWAP
                >TCOMP
                ' LAM EQS
                STO
                ROMPTR B3 3E  (re-read # elements)
              ;
            PopMetaVStackDROP
          ;
        }
        { "Del"
          ::
            LAM EQS
            INNERDUP
            #0=case DROP      (quit if empty)
            PushVStack&Keep   (save stack contents)
            reversym
            DROP
            18GETLAM
            ROLL
            DROP
            18GETLAM #1-
            UNROLL
            DEPTH
            {}N
            ' LAM EQS STO
            PopMetaVStackDROP (restore stack)
            ROMPTR B3 3E      (re-read # elements)
            18GETLAM          (change selected element)
            12GETLAM          (if necessary)
            #MIN
            18PUTLAM
            FALSE ROMPTR B3 19
          ;
        }
        { "Edit"
          ::
            LAM EQS           (get element)
            18GETLAM
            NTHELCOMP
            NOT?SEMI          (quit if empty)
            FPTR2 ^EQW3Edit   (edit)
            NOT?SEMI          (quit if not changed)
            18GETLAM
            LAM EQS
            PUTLIST           (replace)
            ' LAM EQS STO
          ;
        }
        NullMenuKey
        { "CANCL" FPTR2 ^DoCKeyCancel }
        { "OK" FPTR2 ^DoCKeyOK }
      }
      TRUE
    ;
    DROPFALSE
  ;

  "Pseudo-Plot"               (title)
  ' NULL::                    (converter)
  NULL{}                      (no items - msgs are used)
  BINT1                       (initially selected elt)

  ROMPTR2 ~Choose             (run browser)

  ABND
;
@