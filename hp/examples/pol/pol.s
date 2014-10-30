!NO CODE
!RPL
::
* Defines names for used keys. Makes things easier and
* more readable
  DEFINE kpNoShift    BINT1
  DEFINE kpLeftShift  BINT2
  DEFINE kcUpArrow    BINT10
  DEFINE kcLeftArrow  BINT14
  DEFINE kcDownArrow  BINT15
  DEFINE kcRightArrow BINT16
  DEFINE kcLeftShift  BINT37
  DEFINE kcOn         BINT47

* Requires no arguments
  CK0NOLASTWD

* Prepare display
  RECLAIMDISP    (clear and resize display)
  ClrDA1IsStat   (temporarily disable clock)

* Smiling face grob. The below must be in one line only.
  GROB 7C 310003100008F000060300810C0040001040001020002024012010004010004010004010004011044021042026032048F010400010810C0006030008F000
  FIFTYSIX      (initial x coordinate for box)
  EIGHTEEN      (initial y coordinate for box)
  FALSE         (initial exit condition)
  {
    LAM MrSmile
    LAM x
    LAM y
    LAM exit?
  } BIND        (binds local variables)

* The following composite is the display update object.
* It clears the screen and draws the smiling face grob.
' ::
    CLEARVDISP       (clear display)
    LAM MrSmile      (recall smiling face grob)
    HARDBUFF         (recall current display)
    LAM x LAM y      (smile coordinates)
    GROB!            (REPL)
    DispMenu.1       (display menu)
  ;

* The following composite is the key action handler.
  ' ::
    kpNoShift #=casedrop ::
      DUP#<7 casedrpfls  (enable softkeys)
      kcUpArrow ?CaseKeyDef
        ::
          LAM y DUP
          BINT1 #<ITE
            :: DROP ERRBEEP ;
           :: #1- ' LAM y STO ;
        ;
      kcDownArrow ?CaseKeyDef
        ::
          LAM y DUP
          BINT36 #>ITE
            :: DROP ERRBEEP ;
           :: #1+ ' LAM y STO ;
        ;
      kcLeftArrow ?CaseKeyDef
        ::
          LAM x DUP
          BINT1 #<ITE
            :: DROP ERRBEEP ;
           :: #1- ' LAM x STO ;
        ;
      kcRightArrow ?CaseKeyDef
        ::
          LAM x DUP
          BINT111 #>ITE
            :: DROP ERRBEEP ;
           :: #1+ ' LAM x STO ;
        ;
      kcOn ?CaseKeyDef
        :: TRUE ' LAM exit? STO ;
      kcLeftShift #=casedrpfls
      DROP 'DoBadKeyT
    ;
    kpLeftShift #=casedrop ::
      DUP#<7 casedrpfls  (enable softkeys)
      kcUpArrow ?CaseKeyDef
        ::
          LAM y DUP
          BINT10 #<ITE
            :: DROPZERO ERRBEEP ;
           :: BINT10 #- ;
          ' LAM y STO
        ;
      kcDownArrow ?CaseKeyDef
        ::
          LAM y DUP
          BINT27 #>ITE
            :: DROP BINT27 ERRBEEP ;
           #10+
          ' LAM y STO
        ;
      kcLeftArrow ?CaseKeyDef
        ::
          LAM x DUP
          BINT10 #<ITE
            :: DROPZERO ERRBEEP ;
           :: BINT10 #- ;
          ' LAM x STO
        ;
      kcRightArrow ?CaseKeyDef
        ::
          LAM x DUP
          BINT102 #>ITE
          :: DROP BINT112 ERRBEEP ;
           #10+
          ' LAM x STO
        ;
      kcLeftShift #=casedrpfls
      DROP 'DoBadKeyT
    ;
    2DROP 'DoBadKeyT
  ;

* Key definitions
  TrueTrue

* Menu specification
  { { "Up" {
             ::
               LAM y DUP
               BINT1 #<ITE
                 :: DROP ERRBEEP ;
                :: #1- ' LAM y STO ;
             ;
             ::
               LAM y DUP
               BINT10 #<ITE
                 :: DROPZERO ERRBEEP ;
                :: BINT10 #- ;
               ' LAM y STO
             ;
           }
    }
    { "Down" { ::
                 LAM y DUP
                 BINT36 #>ITE
                   :: DROP ERRBEEP ;
                  :: #1+ ' LAM y STO ;
               ;
               ::
                 LAM y DUP
                 BINT37 #>ITE
                   :: DROP BINT37 ERRBEEP ;
                  #10+
                ' LAM y STO
               ;
             }
    }
    { "Left" { ::
                 LAM x DUP
                 BINT1 #<ITE
                   :: DROP ERRBEEP ;
                  :: #1- ' LAM x STO ;
               ;
               ::
                 LAM x DUP
                 BINT10 #<ITE
                   :: DROPZERO ERRBEEP ;
                  :: BINT10 #- ;
                 ' LAM x STO
               ;
             }
    }
    { "Right" { ::
                  LAM x DUP
                  BINT111 #>ITE
                    :: DROP ERRBEEP ;
                   :: #1+ ' LAM x STO ;
                ;
                ::
                  LAM x DUP
                  BINT102 #>ITE
                    :: DROP BINT112 ERRBEEP ;
                   #10+
                  ' LAM x STO
                ;
              }
    }
    NullMenuKey
    { "Quit" :: TRUE ' LAM exit? STO ; }
  }
  ONEFALSE     (first menu row, no suspended envs)
  ' LAM exit?  (exit condition)
  'ERRJMP      (error handler)
  ParOuterLoop (run the par outer loop)
  RECLAIMDISP  (resize and clear display)
  ClrDAsOK     (redraw display)
;
@