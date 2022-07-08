#!/bin/bash

echo "U-10"
echo "============================================"
# /etc/inetd.conf
echo "# /etc/inetd.conf"

if [ `find /etc -mindepth 1 -maxdepth 1 -name inetd.conf 2> /dev/null | wc -l` -eq 1 ]; then

username=`ls -l /etc/inetd.conf | awk '{print $3}'`
if [[ $username == root ]]; then

perm=`stat /etc/inetd.conf | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
if [ $perm -le 600 ]; then
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ]; then
if [ $other -eq 0 ]; then
echo "Good : owner, permission"
else
echo "Vul : /etc/inetd.conf permission"
fi
else
echo "Vul : /etc/inetd.conf permission"
fi
else
echo "Vul : /etc/inetd.conf permission"
fi

else
echo "Vul : /etc/inetd.conf owner is not root"
fi

else
echo "'/etc/inetd.conf' file does not exist"
fi

echo "--------------------------------------------"

# /etc/xinetd.conf
echo "# /etc/xinetd.conf"

if [ `find /etc -mindepth 1 -maxdepth 1 -name xinetd.conf 2> /dev/null | wc -l` -eq 1 ]; then

username=`ls -l /etc/xinetd.conf | awk '{print $3}'`
if [[ $username == root ]]; then

perm=`stat /etc/xinetd.conf | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
if [ $perm -le 600 ]; then
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ]; then
if [ $other -eq 0 ]; then
echo "Good : owner, permission"
else
echo "Vul : /etc/xinetd.conf permission"
fi
else
echo "Vul : /etc/xinetd.conf permission"
fi
else
echo "Vul : /etc/xinetd.conf permission"
fi

else
echo "Vul : /etc/xinetd.conf owner is not root"
fi

else
echo "'/etc/xinetd.conf' file does not exist"
fi

echo "============================================"