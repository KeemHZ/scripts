#!/bin/bash

echo "U-08"
echo "============================================"

username=`ls -l /etc/shadow | awk '{print $3}'`
if [[ $username == root ]]; then

perm=`stat /etc/shadow | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'` 
if [ $perm -le 400 ]; then
owner=`echo ${perm:0:1}`
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $owner -eq 0 ] || [ $owner -eq 1 ] || [ $owner -eq 4 ]; then
if [ $group -eq 0 ]; then
if [ $other -eq 0 ]; then
echo "Good : owner, permission"
else
echo "Vul : /etc/shadow permission"
fi
else
echo "Vul : /etc/shadow permission"
fi
else
echo "Vul : /etc/shadow permission"
fi
else
echo "Vul : /etc/shadow permission"
fi

else
echo "Vul : /etc/shadow owner is not root"
fi

echo "============================================"