#!/bin/bash

automount=`ps -ef | grep automount | grep -v grep | wc -l`
autofs=`ps -ef | grep autofs | grep -v grep | wc -l`

if [ $automount -ne 0 ] || [ $autofs -ne 0 ]; then
        echo "Vul : 'automountd' service is running"
fi