DESCRIPTION = "Package groups for Advantech WISE-PaaS"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
   ${PN} \
   ${PN}-base \
   ${PN}-addon \
   "

RDEPENDS_${PN} = "\
   ${PN}-base \
   ${PN}-addon \
   "

RDEPENDS_${PN}-base = "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target "

RDEPENDS_${PN}-addon = "\
   rmm susi4 susi-iot "