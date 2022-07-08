#!/bin/bash

echo "U-23"
echo "============================================"

service=("echo" "discard" "daytime" "chargen")

for ((i=0; i<${#service[@]}; i++))
do

echo -e "Service : ${service[$i]}\n"

if [ `ps -ef | grep -iw ${service[$i]} | grep -v grep | wc -l` -gt 0 ]; then
echo "'${service[$i]}' service is not running"

# /etc/inetd.conf
echo "# /etc/inetd.conf"

if [ `find /etc -mindepth 1 -maxdepth 1 -name inetd.conf 2> /dev/null | wc -l` -gt 0 ]; then

if [ `cat /etc/inetd.conf | grep -i ${service[$i]} | grep -v '#' | wc -l` -gt 0 ]; then
echo "Vul : /etc/inetd.conf enables ${service[$i]}"
else
echo "Good : /etc/inetd.conf disabled ${service[$i]}"
fi

else
echo "File '/etc/inetd.conf' does not exist"
fi

echo "--------------------------------------------"

# /etc/xinetd.d
echo "# /etc/xinetd.d"

if [ `find /etc -mindepth 1 -maxdepth 1 -name xinetd.d 2> /dev/null | wc -l` -gt 0 ]; then

if [ `find /etc/xinetd.d -mindepth 1 -maxdepth 1 -name ${service[$i]}-dgram | wc -l` -eq 1 ]; then
if [ `cat /etc/xinetd.d/${service[$i]}-dgram | grep -i disable | grep -i yes | wc -l` -gt 0 ]; then
echo "Good : /etc/xinetd.d/${service[$i]}-dgram"
else
echo "Vul : /etc/xinetd.d/${service[$i]}-dgram"
fi
else
echo "File '/etc/xinetd.d/${service[$i]}-dgram' does not exist"
fi

if [ `find /etc/xinetd.d -mindepth 1 -maxdepth 1 -name ${service[$i]}-stream | wc -l` -eq 1 ]; then
if [ `cat /etc/xinetd.d/${service[$i]}-stream | grep -i disable | grep -i yes | wc -l` -gt 0 ]; then
echo "Good : /etc/xinetd.d/${service[$i]}-stream"
else
echo "Vul : /etc/xinetd.d/${service[$i]}-stream"
fi
else
echo "File '/etc/xinetd.d/${service[$i]}-stream' does not exist"
fi

else
echo "File '/etc/xinetd.d' does not exist"
fi

else
echo "Vul : '${service[$i]}' service is running"
fi

echo "============================================"
done