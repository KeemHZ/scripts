#!/bin/bash

echo "U-07"
echo "============================================"

username=`ls -l /etc/passwd | awk '{print $3}'`
if [[ $username == root ]]; then

perm=`stat /etc/passwd | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'` 
if [ $perm -le 644 ]; then
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ] || [ $group -eq 1 ] || [ $group -eq 4 ]; then
if [ $other -eq 0 ] || [ $other -eq 1 ] || [ $other -eq 4 ]; then
echo "Good : owner, permission"
else
echo "Vul : /etc/passwd permission"
fi
else
echo "Vul : /etc/passwd permission"
fi
else
echo "Vul : /etc/passwd permission"
fi

else
echo "Vul : /etc/passwd owner is not root"
fi

echo "============================================"