DESCRIPTION = "Package groups for Advantech WISE-PaaS"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
   ${PN} \
   ${PN}-base \
   "

RDEPENDS_${PN} = "\
   ${PN}-base \
   "

SUMMARY_${PN}-base = "Yocto native packages"
RDEPENDS_${PN}-base = "\
   nodejs nodejs-npm zsh git git-perltools \
   sqlite3 lua uci libbsd \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   mosquitto-clients libmosquitto1 libmosquittopp1 packagegroup-sdk-target "

SUMMARY_${PN}-addon = "Advantech proprietary packages"
RDEPENDS_${PN}-addon = "\
   rmm susi4 susi-iot "

