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

SUMMARY_${PN}-base = "Yocto native packages"
RDEPENDS_${PN}-base = "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target "

SUMMARY_${PN}-addon = "Advantech proprietary packages"
RDEPENDS_${PN}-addon = "\
   rmm susi4 susi-iot "

