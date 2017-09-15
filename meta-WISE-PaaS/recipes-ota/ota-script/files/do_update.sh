#!/bin/bash
set -e

ROOTDIR=`pwd`

usage()
{
    cat << EOF
Usage: `basename $0` [OPTIONS]

Setup for OTA update procedure and then reboot into recovery mode

 <file path>  OTA update packege file path
 result       Get result for OTA update
 help         Show help
EOF
    exit 1;
}

[ $# -lt 1 ] && usage

[ "help" == $1 ] && usage

# Get OTA Result
if [ "result" == $1 ] ; then
    if [ -e /cache/recovery/intent ] ; then
        OTA_RESULT=`cat /cache/recovery/intent`
	rm /cache/recovery/intent
    else
        OTA_RESULT="N/A"
    fi
    echo "${OTA_RESULT}"
    exit 0;
fi


if [ -e /dev/disk/by-partlabel ] ; then
    DISK_DIR="/dev/disk/by-partlabel"
elif [ -e /dev/disk/by-label ] ; then
    DISK_DIR="/dev/disk/by-label"
else
    echo "Err: cannot find /dev/disk/by-partlabel or /dev/disk/by-label"
    exit 0;
fi

# OTA Update Setup
FILE_PATH=$ROOTDIR/$1

if [ -e $FILE_PATH ] ; then
    echo "Write recovery command ..."
    mkdir -p /cache/recovery/
    echo "--update_package=${FILE_PATH}" > /cache/recovery/command

    echo "Remove ZIP package ..."
    FILE_BASE_NAME=`expr ${FILE_PATH} : '.*[/]\(.*-v[0-9].[0-9].[0-9].[0-9]-.*\)'`
    ZIP_FILE_NAME=`echo ${FILE_BASE_NAME} | cut -d '/' -f 1`
    ZIP_FILE_PATH=`find /cache/ -name ${ZIP_FILE_NAME}.zip`
    echo "rm ${ZIP_FILE_PATH}"
    rm ${ZIP_FILE_PATH}
    ZIP_2ND_FILE_PATH=${ZIP_FILE_PATH%.zip}
    ZIP_2ND_FILE_NAME=`grep -r PackageType ${ZIP_2ND_FILE_PATH}/PackageInfo.xml | cut -d '>' -f 2 | cut -d '<' -f 1`
    echo "rm ${ZIP_2ND_FILE_PATH}/${ZIP_2ND_FILE_NAME}.zip"
    rm ${ZIP_2ND_FILE_PATH}/${ZIP_2ND_FILE_NAME}.zip

    echo "Write BCB ..."
    echo -ne "\x62\x6f\x6f\x74\x2d\x72\x65\x63\x6f\x76\x65\x72\x79\x00" > /cache/boot-recovery
    dd if=/cache/boot-recovery of=${DISK_DIR}/misc

    echo "Setup OK. Reboot to recovery image!"
    sync; sync
else
    echo "Error: $FILE_PATH does not exist!"
    exit 1;
fi
