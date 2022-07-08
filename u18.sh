#!/bin/bash

echo "U-18"
echo "============================================"

# TCP Wrapper
echo "# TCP Wrapper"

if [ `find /etc -mindepth 1 -maxdepth 1 -name hosts.deny 2> /dev/null | wc -l` -gt 0 ]; then

first=(`cat /etc/hosts.deny | grep -v '#' | grep -i all | awk -F : '{print $1}'`)
second=(`cat /etc/hosts.deny | grep -v '#' | grep -i all | awk -F : '{print $2}'`)
num=`cat /etc/hosts.deny | grep -v '#' | grep -i all | wc -l`

for ((i=0; i<=num; i++))
do

if [ $i -eq $num ]; then
echo "Vul : TCP Wrapper - It's not a white list"
break
fi

if [[ ${first[$i]} == *ALL* ]] || [[ ${first[$i]} == *all* ]]; then
if [[ ${second[$i]} == *ALL* ]] || [[ ${second[$i]} == *all* ]]; then
echo "Good : TCP Wrapper - It's a white list"
break
fi
fi

done

else
echo "Vul : TCP Wrapper - /etc/hosts.deny file is not exist"
fi

echo "--------------------------------------------"

# IPtables
echo "# IPtables"

function file {
iptables -L | grep -n 'Chain INPUT' > start
iptables -L | grep -nB 2 'Chain FORWARD' > end
}

file
start=`cat start | awk -F : '{print $1}'`
end=`cat end | head -1 | awk -F - '{print $1}'`
sum=$(($end - $start))

chk=("DROP" "all" "" "anywhere" "anywhere")

num=`iptables -L | grep -A $sum 'Chain INPUT' | grep -i drop | grep -i all | grep -i anywhere | wc -l`

if [ $num -gt 0 ]; then

for ((j=1; j<=num; j++))	# DROP, all, anywhere의 정책이 여러 개일 것은 감안하여 한 줄 씩 확인
do

field=(`iptables -L | grep -A $sum 'Chain INPUT' | grep -i drop | grep -i all | grep -i anywhere | awk -v count=$j 'NR == count {print $0}'`)

for ((k=0; k<=${#field[@]}; k++))
do

if [ $k -eq 2 ]; then
continue
fi

if [ $k -eq ${#field[@]} ]; then
echo "Good : IPtables - It's a white list"
break
fi

if [ ${field[$k]} == ${chk[$k]} ]; then
:
else
if [ $j -eq $num ]; then
echo "Vul : IPtables - It's not a white list"
fi
break
fi

done

done

else
echo "Vul : IPtables - It's not a white list"
fi

echo "============================================"