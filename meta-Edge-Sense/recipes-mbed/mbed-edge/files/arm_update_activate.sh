#!/bin/bash

FIRMWARE_FILE="firmware_0.bin"
HEADER_FILE="header_0.bin"
PACKAGE_PATH="/cache"
CACHE_ROOT="/cache"

if [ -f "${PACKAGE_PATH}/${FIRMWARE_FILE}" ] ; then

    echo -e "Do update ..."

    unzip -o ${PACKAGE_PATH}/${FIRMWARE_FILE} -d ${CACHE_ROOT}
    rm ${PACKAGE_PATH}/${FIRMWARE_FILE} ${PACKAGE_PATH}/${HEADER_FILE}

    chmod 775 ${CACHE_ROOT}/install.sh ${CACHE_ROOT}/result.sh
    ${CACHE_ROOT}/install.sh
else

    echo -e "${FIRMWARE_FILE} not found"
    exit 1;
fi

exit 0;
