#!/bin/bash

echo "U-22"
echo "============================================"

# /usr/bin/crontab
echo "# /usr/bin/crontab"

if [ `find /usr/bin -mindepth 1 -maxdepth 1 -name crontab 2> /dev/null | wc -l` -gt 0 ]; then

perm=`stat /usr/bin/crontab | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print $1}' | awk '{print substr($1,3,3)}'`
if [ $perm -le 750 ]; then
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ] || [ $group -eq 1 ] || [ $group -eq 4 ] || [ $group -eq 5 ]; then
if [ $other -eq 0 ]; then
echo "Good : /usr/bin/crontab permission"
else
echo "Vul : /usr/bin/crontab permission"
fi
else
echo "Vul : /usr/bin/crontab permission"
fi
else
echo "Vul : /usr/bin/crontab permission"
fi

else
echo "Check the location of the crontab command"
fi

echo "--------------------------------------------"

# cron files
echo "# cron files"

if [ `find /etc -mindepth 1 -maxdepth 1 -name cron* 2> /dev/null | wc -l` -gt 0 ]; then

file=(`ls -d /etc/cron* | awk '{print}'`)

else
echo "Check the location of the '/etc/cron*' file"
fi

if  [ `find /var/spool -mindepth 1 -maxdepth 1 -name cron 2> /dev/null | wc -l` -eq 1 ]; then

file+=("/var/spool/cron")
if  [ `find /var/spool/cron -mindepth 1 -maxdepth 1 -name crontabs 2> /dev/null | wc -l` -eq 1 ]; then

file+=("/var/spool/cron/crontabs")

else
echo "Check the location of the '/var/spool/cron/crontabs' file"
fi

else
echo "Check the location of the '/var/spool/cron' file"
fi

for ((i=0; i<${#file[@]}; i++))
do

if [ `ls -ld ${file[$i]} | awk '{print $3}'` == root ]; then

perm=`stat ${file[$i]} | grep Access | grep Uid | awk '{print $2}' | awk -F / '{print substr($1,3,3)}'`
if [ $perm -le 640 ]; then
group=`echo ${perm:1:1}`
other=`echo ${perm:2:1}`
if [ $group -eq 0 ] || [ $group -eq 1 ] || [ $group -eq 4 ]; then
if [ $other -eq 0 ]; then
echo "Good : ${file[$i]} - owner, permission"
else
echo "Vul : ${file[$i]} permission"
fi
else
echo "Vul : ${file[$i]} permission"
fi
else
echo "Vul : ${file[$i]} permission"
fi

else
echo "Vul : ${file[$i]} owner is not root"
fi

done

echo "============================================"