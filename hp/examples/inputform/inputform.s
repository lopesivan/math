!NO CODE
!RPL
::
* Label definitons
  "Port:"   1   10
  "Type:"   70  10
  "Name:"   1   19
  "Fmt:"    1   28
  "Xlat:"   49  28
  "Chk:"    104 28
  "Baud:"   1   37
  "Parity:" 49  37
  "OvrW"    111 37

* Field definitions
  'DROPFALSE               (Message handler)
  26 9 24 8                (Position & size)
  BINT12                   (Field type: choose)
  MINUSONE                 (Types, does not apply here)
  BINT0                    (No decompilation)
  "Choose transfer port"   (Help text)
  { "Wire" }               (Possible options)
  BINT0                    (ChooseDecompile - ignored)
  "Wire" DUP               (Initial & reset values)

  'DROPFALSE
  92 9 36 8
  BINT12
  MINUSONE
  BINT0
  "Choose type of transfer"
  { "Kermit" "XModem" }
  BINT0
  "Kermit" DUP

  'DROPFALSE               (Message handler)
  25 18 103 8              (Position & size)
  BINT1                    (Field type: text field)
  { BINT5 BINT6 }          (Allows ids and lists)
  BINT2                    (Decompile with stack appearance)
  "Enter names of vars to transfer"    (Help text)
  MINUSONE                 (ChooseDate - n/a)
  MINUSONE                 (ChooseDecompile - ignored)
  MINUSONE DUP             (Initially empty)

  'DROPFALSE
  20 27 18 8
  BINT12
  MINUSONE
  BINT0
  "Choose transfer format"
  { "Bin" "ASC" }
  BINT0
  "Bin" DUP

  'DROPFALSE
  74 27 24 8
  BINT12
  MINUSONE
  BINT0
  "Choose character translations"
  { "None" "Newl" "\8D159" "\8D255" }
  BINT0
  "\8D255" DUP

  'DROPFALSE
  122 27 7 8
  BINT12
  MINUSONE
  BINT0
  "Choose checksum type"
  { "1" "2" "3" }
  BINT0
  "3" DUP

  'DROPFALSE
  20 36 24 8
  BINT12
  MINUSONE
  BINT0
  "Choose baud rate"
  { "1200" "2400" "4800" "9600" "15300" }
  BINT0
  "9600" DUP

  'DROPFALSE
  74 36 24 8
  BINT12
  MINUSONE
  BINT0
  "Choose parity"
  { "None" "Odd" "Even" "Mark" "Spc" }
  BINT0
  "None" DUP

  'DROPFALSE
  104 36 ZEROZERO
  BINT32
  MINUSONE
  DUP
  "Overwrite existing variables?"
  MINUSONE
  DUP
  TrueTrue

  9 9                      (Number of labels & fields)
  ' ::                     (InputForm message handler)
    BINT7 OVER#=case ::    (Sets initially focused field)
      DROP
      TWO
      TRUE
    ;
    BINT12 OVER#=case ::   (Configures menu softkeys)
      DROP
      { { "RECV" DoBadKey }
        { "KGET" DoBadKey }
        { "SEND" DoBadKey }
      }
      TRUE
    ;
    DROPFALSE
  ;
  "TRANSFER"               (Title)

  FPTR2 ^IfMain            (Run it)
;
@