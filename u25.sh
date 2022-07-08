# root_squash : 클라이언트에서 루트를 서버상에 nobody사용자로 매핑
# no_root_squash : 서버와 클라이언트 모두 같은 루트(root)를 사용 = 클라이언트에서의 root의 요청을 서버의 root로 매핑
# insecure : 인증되지 않은 접근도 가능



#!/bin/bash

echo "U-24"
echo "============================================"

check=("insecure" "no_root_squash")

for ((i=0; i<=${#check[@]}; i++))
do

if [ $i -eq ${#check[@]} ]; then
echo "Good : /etc/exports does not contain 'insecure', 'no_root_squash' syntax"
break
fi

if [ `cat /etc/exports | grep -v '#' | grep -i ${check[$i]} | wc -l` -gt 0 ]; then
echo "Vul : /etc/exports contains '${check[$i]}' syntax"
fi

done

echo "============================================"