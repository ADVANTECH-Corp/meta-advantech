#!/bin/bash

if [ -f /cache/result.sh ] ; then
    # Return OTA result
    OTA_RESULT=`/cache/result.sh`
    echo "OTA Result: ${OTA_RESULT}"

    if [ "OK" == ${OTA_RESULT} ] ; then
        exit 0;
    else
        exit 1;
    fi
else
    # Get current version
    if [ ! -f /cache/header.bin ] ; then
        /usr/sbin/arm_write_header.sh
    fi
    exit 0;
fi
