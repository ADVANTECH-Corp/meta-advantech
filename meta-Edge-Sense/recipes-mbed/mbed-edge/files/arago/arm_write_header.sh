#!/bin/bash

HEADER_BIN="header.bin"
KERNEL_FOLDER="/boot"
KCM_FOLDER="/cache"

## Functions
ARM_UC_INTERNAL_HEADER_MAGIC_V2="5a51b3d4"
ARM_UC_INTERNAL_HEADER_VERSION_V2="00000002"

function CharToHex()
{
    CONTENT=$1
    OFFSET=$2
    LENGTH=`expr $3 \* 2`
    INDEX="0"

    while [ ${INDEX} != ${LENGTH} ]
    do
        HEX_CONTENT=`printf '\\\x%s' ${CONTENT:${INDEX}:2}`
        TMP_OFFSET=`expr ${OFFSET} + ${INDEX} / 2`
        #echo "${HEX_CONTENT}, ${TMP_OFFSET}"
        INDEX=`expr ${INDEX} + 2`

        echo -ne ${HEX_CONTENT} | sudo dd of=${HEADER_BIN} bs=1 count=1 seek=${TMP_OFFSET} conv=notrunc status=none
    done
}

## Query information about zImage
cd ${KERNEL_FOLDER}
ZIMGE_FILE=`readlink zImage`

if [ x${ZIMGE_FILE} == x ]; then
    ZIMGE_FILE="zImage"
fi
#echo "ZIMGE_FILE = ${ZIMGE_FILE}"

EPOCH_TIME=`stat -c %Y ${ZIMGE_FILE}`
#echo "EPOCH_TIME = ${EPOCH_TIME}"
EPOCH_TIME_HEX=`printf '%016x\n' ${EPOCH_TIME}`

IMAGE_SIZE=`du -b ${ZIMGE_FILE} | cut -d $'\t' -f 1`
#echo "IMAGE_SIZE = ${IMAGE_SIZE}"
IMAGE_SIZE_HEX=`printf '%016x\n' ${IMAGE_SIZE}`

HASH_SHA256=`sha256sum ${ZIMGE_FILE} | cut -d ' ' -f 1`
#echo "HASH_SHA256 = ${HASH_SHA256}"

## Prepare empty header.bin
cd ${KCM_FOLDER}
sudo dd if=/dev/zero of=${HEADER_BIN} bs=1 count=108 status=none

## Write data into binary
CharToHex ${ARM_UC_INTERNAL_HEADER_MAGIC_V2} 0 4
CharToHex ${ARM_UC_INTERNAL_HEADER_VERSION_V2} 4 4
CharToHex ${EPOCH_TIME_HEX} 8 8
CharToHex ${IMAGE_SIZE_HEX} 16 8
CharToHex ${HASH_SHA256} 24 32

## CRC
CRC32=`crc32 ${HEADER_BIN}`
#echo "CRC32 = ${CRC32}"
CharToHex ${CRC32} 108 4

#echo "Create ${HEADER_BIN} done!"

