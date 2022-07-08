#!/bin/bash

echo "U-15"
echo "============================================"

if [ `find / -type f -perm -2 2> /dev/null | wc -l` -gt 0 ]; then
echo "Vul : More than 0 'world writable' files"
else
echo "Good : 'world writable' file not found"
fi

echo "============================================"