#!/bin/bash

FIRMWARE_FILE="firmware_0.bin"
HEADER_FILE="header_0.bin"
ETC_PATH="/etc/mcc_config"
CACHE_ROOT="/cache"

if [ -f "${ETC_PATH}/${FIRMWARE_FILE}" ] ; then

echo -e "Do update."

unzip -o ${ETC_PATH}/${FIRMWARE_FILE} -d ${CACHE_ROOT}
rm ${ETC_PATH}/${FIRMWARE_FILE} ${ETC_PATH}/${HEADER_FILE}

chmod 775 ${CACHE_ROOT}/install.sh ${CACHE_ROOT}/result.sh
${CACHE_ROOT}/install.sh

rm ${CACHE_ROOT}/install.sh

else

echo -e "Not found firmware bin"
exit 1;

fi

exit 0;
