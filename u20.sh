#!/bin/bash

echo "U-20"
echo "============================================"

function file {
cat $proftpd | grep -n '<Anonymous ' > start
cat $proftpd | grep -n '</Anonymous>' > end
}

if [ `cat /etc/passwd | grep -w ftp | wc -l` -eq 1 ]; then	# ftp 계정이 존재하므로 보안 조치 필요

if [ `find /etc -mindepth 1 -maxdepth 1 -name vsftpd.conf -type f 2> /dev/null | wc -l` -gt 0 ]; then	# vsftpd.conf 파일이 존재하는지

vsftpd=`find /etc -mindepth 1 -maxdepth 1 -name vsftpd.conf -type f 2> /dev/null`	# vsftpd=/etc/vsftpd.conf
if [ `cat $vsftpd | grep -v '#' | grep -i anonymous_enable | grep -i no | wc -l` -eq 1 ]; then
echo "Good : $vsftpd disabled anonymous ftp"	# vsftpd, proftpd 둘 다 있으면 vsftpd 설정 따라감
else
echo "Vul : $vsftpd enables anonymous ftp"
fi

else
if [ `find /etc -name proftpd.conf 2> /dev/null | wc -l` -eq 1 ]; then	# proftpd.conf 파일이 존재하는지

proftpd=`find /etc -name proftpd.conf 2> /dev/null`
file
start=`cat start | awk -F : '{print $1}'`
end=`cat end | awk -F : '{print $1}'`
sum=$(($end - $start))
User=`cat $proftpd | grep -A $sum '<Anonymous ' | grep -v '#' | grep -w 'User' | wc -l`	# 0보다 크면 X, 0이면 양호
UserAlias=`cat $proftpd | grep -A $sum '<Anonymous ' | grep -v '#' | grep -w 'UserAlias' | wc -l`	# 0보다 크면 X, 0이면 양호

if [ $User -gt 0 ] && [ $UserAlias -gt 0 ]; then	# proftpd 설치해서 실험해본 결과 User가 주석 처리되어 있으면 UserAlias가 주석 처리 안 되어 있어도 익명 FTP 실행 안 되지만 취약점 분석 평가서에 두 개 모두 주석 처리하라고 되어 있으므로 둘 다 확인
echo "Vul : $proftpd enables anonymous ftp"	# 주석 X
else
echo "Good : $proftpd disabled anonymous ftp"
fi

else
echo "Vul : $proftpd does not exist."
fi
fi

else
echo "Good : No 'ftp' account"
fi

echo "============================================"