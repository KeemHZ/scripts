#!/bin/bash

echo "U-19"
echo "============================================"

# /etc/inetd.conf
echo "# /etc/inetd.conf"

if [ `find /etc -mindepth 1 -maxdepth 1 -name inetd.conf 2> /dev/null | wc -l` -gt 0 ]; then
if [ `cat /etc/inetd.conf | grep -v '#' | grep finger | wc -l` -gt 0 ]; then
echo "Vul : /etc/inetd.conf - 'finger' service is not annotated"	# 주석 처리 X
else
echo "Good : /etc/inetd.conf - Disable 'finger' service"	# 주석 처리 O or finger 서비스가 아예 없거나
fi
else
echo "File '/etc/inetd.conf' does not exist"
fi

echo "--------------------------------------------"

# /etc/xinetd.d
echo "# /etc/xinetd.d"

if [ `find /etc -mindepth 1 -maxdepth 1 -name xinetd.d 2> /dev/null | wc -l` -gt 0 ]; then
if [ `find /etc/xinetd.d -mindepth 1 -maxdepth 1 -name finger 2> /dev/null | wc -l` -gt 0 ]; then
if [ `cat /etc/xinetd.d/finger | grep -i disable | grep -i yes | wc -l` -gt 0 ]; then
echo "Good : /etc/xinetd.d/finger - Disable 'finger' service"
else
echo "Vul : /etc/xinetd.d/finger - Enable 'finger' service"
fi
else
echo "File '/etc/xinetd.d/finger' does not exist"
fi
else
echo "File '/etc/xinetd.d' does not exist"
fi

echo "============================================"