#!/bin/bash

echo "U-14"
echo "============================================"

user=(`ls /home | awk '{print}'`)
num=`ls /home | wc -l`
for ((i=0; i<$num; i++))
do
file=(`find /home/${user[$i]} -mindepth 1 -maxdepth 1 -type f | awk -F / '{print $4}'`)
fnum=`find /home/${user[$i]} -mindepth 1 -maxdepth 1 -type f | wc -l`
for ((j=0; j<$fnum; j++))
do
if [[ ${file[$j]} =~ ^\.+ ]]; then
owner=`ls -l /home/${user[$i]}/${file[$j]} | awk '{print $3}'`
if [ $owner == root ] || [ $owner == ${user[$i]} ]; then

perm=`ls -l /home/${user[$i]}/${file[$j]} | awk '{print $1}'`
if [[ ${perm:4:3} =~ w+ ]]; then
echo "Vul : Need to check group permissions of '/home/${user[$i]}/${file[$j]}'"
else
if [[ ${perm:7:3} =~ w+ ]]; then
echo "Vul : Need to check other permissions of '/home/${user[$i]}/${file[$j]}'"
else
echo "Good : /home/${user[$i]}/${file[$j]}(owner, permission)"
fi
fi
else
echo "Vul : Need to check owner of '/home/${user[$i]}/${file[$j]}'"
fi
fi
done
done

echo "============================================"