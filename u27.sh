#!/bin/bash

rpc=('rpc.cmsd' 'rpc.ttdbserverd' 'sadmind' 'rusersd' 'walld' 'sprayd' 'rstatd' 'rpc.nisd' 'rexd' 'rpc.pcnfsd' 'rpc.statd' 'rpc.ypupdated' 'rpc.rquotad' 'kcms_server' 'cachefsd')

# inetd.conf

echo "/etc/inetd.conf"
if [ `find /etc -name inetd.conf | wc -l` -ne 0 ]; then
for ((i=0; i<${#rpc[@]}; i++))
do
if [ `cat /etc/inetd.conf | grep -v '#' | grep ${rpc[$i]} | wc -l` -ne 0 ]; then
echo "Vul : ${rpc[$i]}"
else
echo "Good : ${rpc[$i]}"
fi
done
else
echo "File '/etc/inetd.conf' does not exist"
fi

# xinetd.d
echo "/etc/xinetd.d"
if [ `find /etc -name xinetd.d | wc -l` -ne 0 ]; then
for ((i=0; i<${#rpc[@]}; i++))
do
if [ `find /etc/xinetd.d -name ${rpc[$i]} | wc -l` -ne 0 ]; then
if [ `cat /etc/xinetd.d/${rpc[$i]} | grep -i disable | grep -i yes | wc -l` -ne 0 ]; then
echo "Good : /etc/xinetd.d/${rpc[$i]} disabled"
else
echo "Vul : /etc/xinetd.d/${rpc[$i]} enabled"
fi
else
echo "File '/etc/xinetd.d/${rpc[$i]}' does not exist"
fi
done
else
echo "Directory '/etc/xinetd.d' does not exist"
fi