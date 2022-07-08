#!/bin/bash

echo "U-16"
echo "============================================"

if [ `find /dev -type f 2> /dev/null | wc -l` -gt 0 ]; then
device=(`find /dev -type f 2> /dev/null | awk -F / '{print $3}'`)
num=`find /dev -type f 2> /dev/null | wc -l`
for ((i=0; i<$num; i++))
do
if [ `ls -l /dev/${device[$i]} | awk '{print NF}'` -gt 9 ]; then
echo "Good : /dev/${device[$i]} with major, minor number"
else
echo "Vul : /dev/${device[$i]} without major, minor number"
fi
done
else
echo "Good : File not found in directory '/dev'"
fi

echo "============================================"