#!/bin/bash
set -e

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
    else
        OTA_RESULT="N/A"
    fi
    echo "${OTA_RESULT}"
    exit 0;
fi

# OTA Update Setup
FILE_PATH="$1"

if [ -e $FILE_PATH ] ; then
    echo "Write recovery command ..."
    mkdir -p /cache/recovery/
    echo "--update_package=${FILE_PATH}" > /cache/recovery/command

    echo "Create disk label mapping ..."
    [ -e /cache/recovery/mapping ] && rm /cache/recovery/mapping

    if [ -e /dev/disk/by-partlabel ] ; then
        DISK_DIR="/dev/disk/by-partlabel"
    elif [ -e /dev/disk/by-label ] ; then
        DISK_DIR="/dev/disk/by-label"
    else
        echo "Error: cannot find /dev/disk/by-partlabel or /dev/disk/by-label" && exit 1;
    fi
    cd $DISK_DIR

    DISK_LIST=`ls`
    for DISK_LABEL in $DISK_LIST ; do
        DISK_DEV=`readlink -f $DISK_LABEL`
        echo "${DISK_LABEL}:${DISK_DEV}" >> /cache/recovery/mapping
    done

    echo "Write BCB ..."
    echo -ne "\x62\x6f\x6f\x74\x2d\x72\x65\x63\x6f\x76\x65\x72\x79\x00" > /cache/boot-recovery
    dd if=/cache/boot-recovery of=${DISK_DIR}/misc

    echo "Setup OK. Reboot to recovery image!"
    reboot
else
    echo "Error: $FILE_PATH does not exist!"
    exit 1;
fi
