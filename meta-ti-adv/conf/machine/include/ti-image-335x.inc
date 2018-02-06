

IMAGE_INSTALL += "\
    linux-firmware-bcm43241b4 "

IMAGE_INSTALL += "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target "

IMAGE_INSTALL += "\
    ota-rmm ota-script rmm susi4 susi-iot "
#   ota-rmm rmm susi4 susi-iot  ota-script "

IMAGE_INSTALL += "\
   ppp"

IMAGE_INSTALL += "\
   libcap-ng libcap"


IMAGE_INSTALL += "\
   autoconf autoconf-archive"

IMAGE_INSTALL += "\
   packagegroup-tools-bluetooth"

IMAGE_INSTALL += "\
   openobex obexd"

