#!/bin/bash

echo "U-11"
echo "============================================"

if [ `find /etc -mindepth 1 -maxdepth 1 -name syslog.conf 2> /dev/null | wc -l` -eq 1 ]; then

username=`ls -l /etc/syslog.conf | awk '{print $3}'`
if [[ $username == root ]] || [[ $username == sys ]] || [[ $username == bin ]]; then

perm=`stat /etc/syslog.conf | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
if [ $perm -le 640 ]; then
group=`echo ${perm:1:1}` # 0,1,4
other=`echo ${perm:2:1}`
if [ $group -eq 0 ] || [ $group -eq 1 ] || [ $group -eq 4 ]; then
if [ $other -eq 0 ]; then
echo "Good : owner, permission"
else
echo "Vul : /etc/syslog.conf permission"
fi
else
echo "Vul : /etc/syslog.conf permission"
fi
else
echo "Vul : /etc/syslog.conf permission"
fi

else
echo "Vul : /etc/syslog.conf owner is not root or sys or bin"
fi

else
echo "/etc/syslog.conf File does not exist"
fi

echo "============================================"