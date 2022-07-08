# /etc/rc*.d/* | grep nfs -> 위치 맞는지 확인해야 됨
# /etc/exports : NFS 서버 공유 목록 관리 -> 모든 공유 제거



#!/bin/bash

echo "U-24"
echo "============================================"

if [ `ps -ef | egrep -iw "nfsd|statd|lockd" | grep -v grep | wc -l` -gt 0 ]; then
echo "Vul : NFS service is running"

else
echo "NFS service is not running"

if [ `cat /etc/exports | grep -v '#' | wc -l` -gt 0 ]; then
echo "Vul : /etc/exports - Server is being shared"

else
if [ `ls /etc/rc*.d/* | grep nfs | wc -l` -gt 0 ]; then
echo "/etc/exports - Server is not being shared"
echo "/etc/rc*.d/* - Check the name of the script name"

else
echo "Good : No shared server and script name change completed"
fi

fi

fi

echo "============================================"