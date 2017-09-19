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

execute () {
  [[ -f /tmp/DO_ECHO_NOT_EVAL ]] && {
    execute () { echo $@; }
  } || {
    execute () { eval $@; }
  }
  execute $@
}

# OTA Update Setup
FILE_PATH=$ROOTDIR/$1
GRUB_CONF="/media/realroot/boot/grub/grub.conf"

if [ -e $FILE_PATH ] ; then
    echo "Write recovery command ..."
    mkdir -p /cache/recovery/
    BOOT_DEFAULT=`grep "^default" $GRUB_CONF | cut -d' ' -f2`
	[[ -z ${BOOT_DEFAULT} ]] && { BOOT_DEFAULT=2; execute sed -i \"1 i default 2\" $GRUB_CONF; }
    BOOT_TIMEOUT=`grep "^timeout" $GRUB_CONF | cut -d' ' -f2`
	[[ -z ${BOOT_TIMEOUT} ]] && { BOOT_TIMEOUT=5; execute sed -i \"2 i timeout 5\" $GRUB_CONF; }
    echo "--update_package=${FILE_PATH}" > /cache/recovery/command
    echo "--boot_default=${BOOT_DEFAULT}" >> /cache/recovery/command
    echo "--boot_timeout=${BOOT_TIMEOUT}" >> /cache/recovery/command

    echo "Write BCB ..."
    echo -ne "\x62\x6f\x6f\x74\x2d\x72\x65\x63\x6f\x76\x65\x72\x79\x00" > /cache/boot-recovery

    execute sed -i \"s/default.*/default 0/\;s/timeout.*/timeout 0/\" $GRUB_CONF
    echo "Setup OK. Reboot to recovery image!"
    sync; sync
else
    echo "Error: $FILE_PATH does not exist!"
    exit 1;
fi
