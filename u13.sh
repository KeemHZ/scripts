#!/bin/bash

echo "U-13"
echo "============================================"

file=(`find / \( -perm -4000 -o -perm -2000 \) 2> /dev/null`)
chkfile=("/sbin/dump" "/sbin/restore" "/sbin/unix_chkpwd" "/usr/bin/at" "/usr/bin/lpq" "/usr/bin/lpq-lpd" "/usr/bin/lpr" "/usr/bin/lpr-lpd" "/usr/bin/lprm" "/usr/bin/lprm-lpd" "/usr/bin/newgrp" "/usr/sbin/lpc" "/usr/sbin/lpc-lpd" "/usr/sbin/traceroute")

for ((i=0; i<${#file[@]}; i++))
do
for ((j=0; j<${#chkfile[@]}; j++))
do
if [ ${file[$i]} == ${chkfile[$j]} ]; then
echo "Vul : ${chkfile[$j]}"
fi
done
done

echo "============================================"