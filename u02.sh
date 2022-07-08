#!/bin/bash

echo "U-02"
echo "============================================"

function VN() {
name=(`cat /etc/pam.d/common-password | grep pam_pwquality.so | awk '{print}'`)
num=`cat /etc/pam.d/common-password | grep pam_pwquality.so | awk '{print NF}'`
}

function classcheck() {
for ((i=0; i<=$num; i++))
do
if [[ $i == $num ]]; then
echo "Vul : Password class is not set"
fi
if [[ ${name[$i]} == *minclass* ]]; then
class=$(($i + 1))
classvalue=`cat /etc/pam.d/common-password | grep pam_pwquality.so | awk -v field1="$class" '{print $field1}' | awk -F = '{print $2}'`
if [ $classvalue -ge 3 ]; then
echo "Good : Password checked complete(length, class)"
break
else
echo "Vul : Password class is less than 3"
break
fi
fi
done
}

function defscheck() {
if [ `find /etc -mindepth 1 -maxdepth 1 -name login.defs 2> /dev/null | wc -l` -eq 1 ]; then
if [ `cat /etc/login.defs | grep -v '#' | grep -i pass_min_len | wc -l` -gt 0 ]; then
if [ `cat /etc/login.defs | grep -v '#' | grep -i pass_min_len | awk '{print $2}'` -ge 8 ]; then
echo "/etc/login.defs - Password minimum length is 8 or more"
classcheck
else
echo "Vul : Password length less than 8"
fi
else
echo "Vul : /etc/login.defs - PASS_MIN_LEN Comment Processing"
fi
else
echo "Vul : /etc/login.defs File does not exist"
fi
}

if [ `find /etc/pam.d -mindepth 1 -maxdepth 1 -name common-password 2> /dev/null | wc -l` -eq 1 ]; then
VN
for ((j=0; j<=$num; j++))
do
if [[ $j == $num ]]; then
defscheck
fi
if [[ ${name[$j]} == *minlen* ]]; then
len=$(($j + 1))
lenvalue=`cat /etc/pam.d/common-password | grep pam_pwquality.so | awk -v field2="$len"  '{print $field2}' | awk -F = '{print $2}'`
if [ $lenvalue -ge 8 ]; then
echo "/etc/login.defs - Password minimum length is 8 or more"
classcheck
break
else
echo "Vul : Password length less than 8"
break
fi
fi
done
else
echo "Vul : /etc/pam.d/common-password File does not exist"
fi
echo "============================================"