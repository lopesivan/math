*** Constants used in Input Forms

** ^IfMain messages
DEFINE IfMsgKeyPress         ZERO
DEFINE IfMsgLooseFocus       ONE
DEFINE IfMsgLoseFocus        IfMsgLooseFocus
DEFINE IfMsgNewField         TWO
DEFINE IfMsgGetFocus         THREE
DEFINE IfMsgGetFieldValue    FOUR
DEFINE IfMsgSetFieldValue    FIVE
DEFINE IfMsgGetFieldGrob     SIX
DEFINE IfMsgSetFirstField    SEVEN
DEFINE IfMsgFieldReset       TEN
DEFINE IfMsgGetMenu          ELEVEN
DEFINE IfMsgGet3KeysMenu     TWELVE
DEFINE IfMsgCancel           THIRTEEN
DEFINE IfMsgCancelKey        FOURTEEN
DEFINE IfMsgOK               FIFTEEN
DEFINE IfMsgOKKey            SIXTEEN
DEFINE IfMsgChoose           SEVENTEEN
DEFINE IfMsgType             EIGHTEEN
DEFINE IfMsgCalc             NINETEEN
DEFINE IfMsgNewCommandLine   TWENTY
DEFINE IfMsgOldCommandLine   TWENTYONE
DEFINE IfMsgCommandLineValid TWENTYTWO
DEFINE IfMsgDecompEdit       TWENTYTHREE
DEFINE IfMsgNextChoose       TWENTYFOUR
DEFINE IfMsgEdit             TWENTYFIVE


** Field types
DEFINE IfFieldTypeText       ONE
DEFINE IfFieldTypeChoose     TWELVE
DEFINE IfFieldTypeCheck      THIRTYTWO
DEFINE IfFieldTypeChooseEdit TWO


** Object types
DEFINE IfObReal  ZERO
DEFINE IfObCmp   ONE
DEFINE IfObStr   TWO
DEFINE IfObArray THREE
DEFINE IfObList  FIVE
DEFINE IfObId    SIX
DEFINE IfObLocal SEVEN
DEFINE IfObPrg   EIGHT
DEFINE IfObAlg   NINE
DEFINE IfObHxs   TEN
DEFINE IfObUnit  THIRTEEN
DEFINE IfObInt   zint


** LAMs used in the filer
* Contains the current field handler
DEFINE Ifl'FieldHandler LAM 'FieldHandler

* Contains the IF handler
DEFINE Ifl'IfHandler LAM 'IfHandler

* The internal graphic format (See DisplayInternalData Function for more informations
DEFINE Ifl'StringData LAM 'StringData

* Store 8 object by field: FieldHandler, Field type, allowed Objects, Decompile Object, Choose field data, Choose field decomp, Reset Value, current Value
DEFINE Ifl'ListData LAM 'ListData

* Shall we quit?
DEFINE Ifl'Quit LAM 'Quit

* Store the number of the current field
DEFINE Ifl'CurrentField LAM 'CurrentField

* Store the last stack depth
DEFINE Ifl'Depth LAM 'Depth

* Store the menu as defined by the user
DEFINE Ifl'Menu LAM 'IfMenu

* Was a Command line active last time?
DEFINE Ifl'CommandLine LAM 'CmdLine
