#!/bin/bash

if [ ! -f /cache/result.sh ] ; then
    exit 1;
fi

OTA_RESULT=`/cache/result.sh`
echo "OTA Result: ${OTA_RESULT}"

if [ "OK" == ${OTA_RESULT} ] ; then
    exit 0;
else
    exit 1;
fi
