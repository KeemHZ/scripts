#!/bin/bash

echo "U-21"
echo "============================================"

if [ `ps -ef | egrep "rlogin|rsh|rexec" | grep -v grep | wc -l` -eq 0 ]; then
echo -e "r-command service not running\n"

# /etc/inetd.conf
echo "# /etc/inetd.conf"

if [ `find /etc -mindepth 1 -maxdepth 1 -name inetd.conf 2> /dev/null | wc -l` -gt 0 ]; then

if [ `cat /etc/inetd.conf | egrep "rlogin|rsh|rexec" | grep -v '#' | wc -l` -gt 0 ]; then
echo "Vul : /etc/inetd.conf enables r-command service"
else
echo "Good : /etc/inetd.conf disabled r-command service"
fi

else
echo "File '/etc/inetd.conf' does not exist"
fi

echo "--------------------------------------------"

# /etc/xinetd.d
echo "# /etc/xinetd.d"

if [ `find /etc -mindepth 1 -maxdepth 1 -name xinetd.d 2> /dev/null | wc -l` -gt 0 ]; then

service=("rlogin" "rsh" "rexec")

for ((i=0; i<${#service[@]}; i++))
do

if [ `find /etc/xinetd.d -mindepth 1 -maxdepth 1 -name ${service[$i]} | wc -l` -eq 1 ]; then
if [ `cat /etc/xinetd.d/${service[$i]} | grep -i disable | grep -i yes | wc -l` -gt 0 ]; then
echo "Good : /etc/xinetd.d/${service[$i]}"
else
echo "Vul : /etc/xinetd.d/${service[$i]}"
fi
else
echo "File '/etc/xinetd.d/${service[$i]}' does not exist"
fi

done

else
echo "File '/etc/xinetd.d' does not exist"
fi

else
echo "Vul : r-command service running"
fi

echo "============================================"