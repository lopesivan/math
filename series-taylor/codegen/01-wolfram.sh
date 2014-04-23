#!/bin/bash
MathKernel -noprompt -run < <( cat $0| sed -e '1,4d' ) | sed '1d'
exit 0
### code start Here ... ###
Expand[(1+x+y)^2]
FortranForm[%]
Sqrt[(x+y+z-7)*(x+y+z+7)^6]
Expand[%]
FortranForm[%]
CForm[%]
