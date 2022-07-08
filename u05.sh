#!/bin/bash

echo "U-05"
echo "============================================"
name=(`echo $PATH | awk -F : '{for(i=1;i<NF+1;i++) print $i}'`)
num=`echo $PATH | awk -F : '{print NF}'`
for ((i=0; i<$num-1; i++)) # 마지막은 '.'이 와도 상관 없어서 검사 안 함
do
        if [ ${name[$i]} == . ]; then
                echo "Vul : Check out \$PATH"
        fi
done
echo "============================================"