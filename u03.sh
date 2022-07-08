#!/bin/bash

echo "U-03"
echo "============================================"
if [ `find /etc/pam.d -mindepth 1 -maxdepth 1 -name common-auth 2> /dev/null | wc -l` -eq 1 ]; then
name=(`cat /etc/pam.d/common-auth | grep pam_tally2.so | awk '{print}'`)
num=`cat /etc/pam.d/common-auth | grep pam_tally2.so | awk '{print NF}'`
if [ `cat /etc/pam.d/common-auth | grep pam_tally2.so | awk '{print}' | wc -l` -eq 0 ]; then	# num이 아무것도 없으면 아래 for 문에서 에러 발생함
echo "Vul : Password threshold is not set"
else
for ((i=0; i<=$num; i++))
do
if [ $i == $num ]; then
echo "Vul : Password threshold is not set"
fi
if [[ ${name[$i]} == *deny* ]]; then
deny=$(($i + 1))
value=`cat /etc/pam.d/common-auth | grep pam_tally2.so | awk -v field="$deny" '{print $field}' | awk -F = '{print $2}'`
if [ $value -le 10 ]; then
echo "Good : Password threshold setting completed"
break
else
echo "Vul : Password threshold greater than 10"
break
fi
fi
done
fi
else
echo "Vul : /etc/pam.d/common-auth File does not exist"
fi
echo "============================================"