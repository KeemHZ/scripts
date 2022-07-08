#!/bin/bash

echo "U-17"
echo "============================================"

function check {
perm=`stat ${total[$k]} | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'` 
if [ $perm -le 600 ]; then
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ]; then
if [ $other -eq 0 ]; then
echo "${total[$k]} - permission is good"
if [ `cat ${total[$k]} | grep '+' | wc -l` -gt 0 ]; then
echo "Vul : '${total[$k]}' has + setting"
else
echo "Good : ${total[$k]}"
return 1
fi
else
echo "Vul : ${total[$k]} permission"
fi
else
echo "Vul : ${total[$k]} permission"
fi
else
echo "Vul : ${total[$k]} permission"
fi
}

if [ `ps -ef | egrep "rlogin|rsh|rexec" | grep -v grep | wc -l` -eq 0 ]; then # 실행 중이 아닌 경우
echo "Good : Service(rlogin|rsh|rexec) not running"

else	# 실행 중인 경우
echo "Service running"

user=(`ls /home | awk '{print}'`)
num=`ls /home | awk '{print}' | wc -l`

dir=("/etc")
file=("hosts.equiv")
total=("/etc/hosts.equiv")

for ((i=0; i<num; i++))
do
dir+=("/home/${user[$i]}")
file+=(".rhosts")
total+=("/home/${user[$i]}/.rhosts")
done

for ((k=0; k<$num+1; k++))
do

if [ `find ${dir[$k]} -mindepth 1 -maxdepth 1 -name '${file[$k]}' 2> /dev/null | wc -l` -gt 0 ]; then	# 파일 O

if [ ${dir[$k]} == /etc ]; then	# owner 체크

if [ `ls -l ${total[$k]} | awk '{print $3}'` == root ]; then
echo "${total[$k]} owner is root"
check
else
echo "Vul : Check the owner of the file '${total[$k]}'"
fi

else
for ((z=$k-1; z<num; z++))
do
owner=`ls -l /home/${user[$z]}/.rhosts | awk '{print $3}'`
if [ $owner == root ] || [ $owner == ${user[$z]} ]; then
echo "${total[$k]} owner is good(root or ${user[$z]})"
check
else
echo "Vul : Check the owner of the file '${total[$k]}'"
fi
done
fi

else
echo "${total[$k]} file is not exist"
fi

done

fi

echo "============================================"