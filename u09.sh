#!/bin/bash

echo "U-09"
echo "============================================"

username=`ls -l /etc/hosts | awk '{print $3}'`
if [[ $username == root ]]; then

perm=`stat /etc/hosts | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
if [ $perm -le 600 ]; then

group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ]; then
if [ $other -eq 0 ]; then
echo "Good : owner, permission"
else
echo "Vul : /etc/hosts permission"
fi
else
echo "Vul : /etc/hosts permission"
fi
else
echo "Vul : /etc/hosts permission"
fi

else
echo "Vul : /etc/hosts owner is not root"
fi

echo "============================================"