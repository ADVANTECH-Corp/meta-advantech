#!/bin/bash

if [ ! -f /cache/result.sh ] ; then
	exit 1;
fi

OTA_RESULT=`/cache/result.sh`

if [ "OK" == ${OTA_RESULT} ] ; then
    echo "${OTA_RESULT}"
    rm -rf /cache/boot-recovery /cache/recovery   
else
    echo "${OTA_RESULT}"
    exit 1;
fi

exit 0;
