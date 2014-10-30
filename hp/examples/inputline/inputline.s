!NO CODE
!RPL
::
  $ "Your name:"     (prompt)
  NULL$              (initial edit line)
  #ZERO#ONE          (cursor at end, insert mode)
  ONEONE             (prog mode, alpha enabled)
  NULL{}             (no menu)
  ONE                (menu row)
  FALSE              (CANCEL clears)
  ZERO               (returns string)
  InputLine
  NOT?SEMI           (exit if FALSE)
  $ "Your name is "
  SWAP&$             (concatenate string & name)
  CLEARLCD           (clear display)
  DISPROW1           (display string on 1st line)
  SetDAsTemp         (freeze display)
;
@