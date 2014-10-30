#!/usr/bin/env bash
#                      __ __       ___
#                     /\ \\ \    /'___`\
#                     \ \ \\ \  /\_\ /\ \
#                      \ \ \\ \_\/_/// /__
#                       \ \__ ,__\ // /_\ \
#                        \/_/\_\_//\______/
#                           \/_/  \/_____/
#                                         Algoritimos
#
#
#       Author: Ivan carlos da Silva Lopes
#         Mail: ivanlopes (at) 42algoritimos (dot) com (dot) br
#      License: gpl
#        Site: http://www.42algoritmos.com.br
#       Phone: +1 561 801 7985
#    Language: Shell Script
#        File: mount.sh
#        Date: Thu 23 Oct 2014 05:20:35 PM BRST
# Description:
#
# ----------------------------------------------------------------------------
PROGRAM=uff.hp50
# if exist file `_f' then remove.
_f=$PROGRAM
test -e $_f && rm $_f
##############################################################################
##############################################################################
##############################################################################

# ----------------------------------------------------------------------------
# Run!

######
# head
######

parts=(
head
root
uff
)

for part in ${parts[*]}; do
  test ! -e ${part}.hp && exit 1
  cat ${part}.hp >> $PROGRAM
done

######
# body
######

parts=(
input
sol
cir
calc
poly
statistica
edo
mec
)

for part in ${parts[*]}; do
  test ! -e ${part}.hp && exit 1
  cat ${part}.hp >> $PROGRAM
  cat sep.hp  >> $PROGRAM
done

######
# tail
######

parts=(
tail
)

for part in ${parts[*]}; do
  test ! -e ${part}.hp && exit 1
  cat ${part}.hp >> $PROGRAM
done

# ----------------------------------------------------------------------------
exit 0
