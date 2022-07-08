#!/bin/bash

echo "U-06"
echo "============================================"
if [ `find / \( -nouser -or -nogroup \) 2> /dev/null | wc -l` -gt 0 ]; then
echo "Vul : There is a file or directory whose owner is unknown"
else
echo "Good"
fi
echo "============================================"