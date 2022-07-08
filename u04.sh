#!/bin/bash

echo "U-04"
echo "============================================"
id=(`cat /etc/passwd | awk -F : '{print $1}'`)
pw=(`cat /etc/passwd | awk -F : '{print $2}'`)
num=`cat /etc/passwd | wc -l`
for ((i=0; i<$num; i++))
do
if [ ${pw[$i]} == x ]; then
:
else
echo "Vul : Check user '${id[$i]}'"
fi
done
echo "============================================"