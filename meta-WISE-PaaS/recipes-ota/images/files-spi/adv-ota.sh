#!/bin/sh

usage()
{
  cat << EOF
Usage: `basename $0`

A shell script for OTA update procedure in recovery image

  -h    Show this help

EOF
  exit 1;
}

while getopts "h" o; do
  case "${o}" in
  h)
    usage ;;
  esac
done

SD_ROOT="/media/mmcblk0p1"
CACHE_ROOT="${SD_ROOT}/cache"
COMMAND_FILE="$CACHE_ROOT/recovery/command"
INTENT_FILE="$CACHE_ROOT/recovery/intent"
LAST_INSTALL_FILE="$CACHE_ROOT/recovery/last_install"
UPDATE_FLAG_FILE="$CACHE_ROOT/boot-recovery"
UPDATE_FLAG="boot-recovery"

[[ -f $UPDATE_FLAG_FILE ]] && [[ "`cat $UPDATE_FLAG_FILE`" == $UPDATE_FLAG ]] || exit 0
echo "OTA update detected"

UPDATE_DIR="ota-update"
UPDATE_SCRIPT="updater-script"

GRUB_CONF="${SD_ROOT}/boot/grub/grub.conf"
#[[ -L /cache ]] || ln -sf ${SD_ROOT}/cache /cache

PACKAGE_FILE=
U_BOOTLOADER=
U_KERNEL=
U_ROOTFS=
U_RAMFS=
OTA_CMD=
OTA_CMD_LIST=
BOOT_DEFAULT=
BOOT_TIMEOUT=

# ===========
#  Functions
# ===========

msg() { echo $1; [ "$2" != "" ] && exit $2; }

execute () {
  [[ -f /tmp/DO_ECHO_NOT_EVAL ]] && {
    execute () { echo "#" $@; }
  } || {
    execute () { eval $@; }
  }
  execute $@
}

cleanBCB()
{
  msg "Cleaning BCB ..."
  execute rm -f $UPDATE_FLAG_FILE
  sync
  msg "BCB is clear!"
}

exitRecovery()
{
  RETURN_LOG="$1"
  NOT_CLEAN="$2"
  cd $CACHE_ROOT

  [[ -f /tmp/KEEP_CACHE_DIR ]] || {
    rm -f $PACKAGE_FILE
    rm -rf $UPDATE_DIR
  }

  echo "$RETURN_LOG" > $INTENT_FILE
  msg "$RETURN_LOG"

  [ -z $NOT_CLEAN ] || exit 1

  cleanBCB
  msg "${GRUB_CONF##*/} : \"default $BOOT_DEFAULT\" \"timeout $BOOT_TIMEOUT\""
  execute sed -i \"s/default.*/default $BOOT_DEFAULT/\;s/timeout.*/timeout $BOOT_TIMEOUT/\" $GRUB_CONF
  msg "Going to reboot ..."
  sync; sync
  execute reboot && exit 1
}

update()
{
  msg "Update ${OTA_CMD} ..."
  [[ -f /tmp/SKIP_${OTA_CMD} ]] && return
  execute rm -f ${SD_ROOT}/$1
  execute mv ${CACHE_ROOT}/${UPDATE_DIR}/$1 ${SD_ROOT}/
}

# ===========
#    Main
# ===========
# [1] Read recovery commands
msg "Read recovery commands ..."
[ ! -e ${COMMAND_FILE} ] && msg "Warning: Cannot find ${COMMAND_FILE}" 0
while read line; do
  NAME=${line%%=*}
  CMD=${NAME:2}
  VALUE=${line#*=}
  case $CMD in
  "update_package") PACKAGE_FILE=${SD_ROOT}/$VALUE ;;
  "boot_default") BOOT_DEFAULT=$VALUE ;;
  "boot_timeout") BOOT_TIMEOUT=$VALUE ;;
  *) msg "Err: Command: ${CMD} is not supported!" ;;
  esac
done < ${COMMAND_FILE}

# [2] Check OTA package
if [ ! -e ${PACKAGE_FILE} ] ; then
    exitRecovery "Err: ${PACKAGE_FILE} does not exist!"
fi

msg "Unzip $PACKAGE_FILE ..."
[[ -f /tmp/SKIP_PACKAGE_UNZIP ]] || unzip -o  $PACKAGE_FILE -d $CACHE_ROOT
# cd ${CACHE_ROOT}/${UPDATE_DIR}
[[ -e ${CACHE_ROOT}/${UPDATE_DIR}/${UPDATE_SCRIPT} ]] || exitRecovery "Err: no ${UPDATE_SCRIPT} in ${PACKAGE_FILE}"

IFS=,
while read line; do
  set - $line
  CMD=${1/update-}
#  CMD=${CMD^^}
  IMAGE=$2
  MD5SUM=$3
  [[ -f ${CACHE_ROOT}/${UPDATE_DIR}/$IMAGE ]] || exitRecovery "Err: ${IMAGE} listed in ${UPDATE_SCRIPT} does not exist!"
  [[ -f /tmp/SKIP_MD5 || -f /tmp/SKIP_MD5_$IMAGE ]] || {
    echo "$MD5SUM  ${CACHE_ROOT}/${UPDATE_DIR}/$IMAGE" | md5sum -c || exitRecovery "Err: MD5 of ${IMAGE} does not match!"
  }
  OTA_CMD_LIST="$OTA_CMD_LIST $CMD"
  eval U_$CMD=$IMAGE
done < ${CACHE_ROOT}/${UPDATE_DIR}/${UPDATE_SCRIPT}
unset IFS

# [3] Update images
msg "Parse $UPDATE_SCRIPT in $PACKAGE_FILE ..."
for OTA_CMD in $OTA_CMD_LIST; do
  eval "update \$U_${OTA_CMD}"
done

# [4] Finish recovery
echo $PACKAGE_FILE > $LAST_INSTALL_FILE
exitRecovery "OK"
