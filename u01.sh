#!/bin/bash

echo "U-01"
echo "============================================"

# Telnet
echo "# Telnet"
if [ `ps -ef | grep telnet | grep -v grep | wc -l` -gt 0 ]; then
echo "Telnet is running"
if [ `find /etc/pam.d -mindepth 1 -maxdepth 1 -name login 2> /dev/null | wc -l` -eq 1 ]; then
if [ `cat /etc/pam.d/login | grep -v '#' | grep auth | grep required | grep pam_securetty.so | wc -l` -gt 0 ]; then
echo "/etc/pam.d/login -> auth required pam_securetty.so"
if [ `cat /etc/securetty | grep '^pts' | wc -l` -eq 0 ]; then
echo "Good : Block remote access of 'root'"
else
echo "Vul : Delete 'pts/' from /etc/securetty file"
fi
else
echo "Vul : Enter 'auth required pam_security' in /etc/pam.d/login file.'"
fi
else
echo "Vul : /etc/pam.d/login file not found"
fi
else
echo "Good : Telnet is not running"
fi
echo "--------------------------------------------"
# SSH
echo "# SSH"
if [ `ps -ef | grep sshd | grep -v grep | wc -l` -gt 0 ]; then
echo "SSH is running"
if [ `find /etc/ssh -mindepth 1 -maxdepth 1 -name sshd_config 2> /dev/null | wc -l` -eq 1 ]; then
if [ `cat /etc/ssh/sshd_config | grep -v '#' | grep -i permitrootlogin | grep no | wc -l` -eq 1 ]; then
echo "Good : Do not allow root login"
else
echo "Vul : Permit root login"
fi
else
echo "Vul : /etc/ssh/sshd_config file not found"
fi
else
echo "Good : SSH is not running"
fi

echo "============================================"