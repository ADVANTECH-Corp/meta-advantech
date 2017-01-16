DESCRIPTION = "Package groups for Advantech iGW solution"
LICENSE = "MIT"

inherit packagegroup

PACKAGES = "\
   ${PN} \
   ${PN}-base \
   ${PN}-dustlink \
   ${PN}-webmin \
   ${PN}-nodered \
   ${PN}-wsn \
   ${PN}-iotivity \
   ${PN}-addon \
   ${PN}-docker \
   "

RDEPENDS_${PN} = "\
   ${PN}-base \
   ${PN}-dustlink \
   ${PN}-nodered \
   ${PN}-wsn \
   ${PN}-iotivity \
   ${PN}-addon \
   ${PN}-docker \
   "

RDEPENDS_${PN}-base = "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target "

RDEPENDS_${PN}-java = "\
   openjdk-7-jre "

RDEPENDS_${PN}-dustlink = "\
   minicom dustlink boost boost-dev serialmux "

#RDEPENDS_${PN}-webmin = "\
#   tzdata tzdata-asia tzdata-americas tzdata-europe ntpdate \
#   perl-module-utf8 libxml-parser-perl libxml-simple-perl perl-module-io-handle perl-module-unicore libjson-perl \
#   webmin webmin-module-system-status webmin-module-net webmin-module-time webmin-module-webmincron webmin-module-proc webmin-module-acl webmin-module-webmin webmin-module-mount webmin-module-init webmin-module-wise webmin-module-factorydefault webmin-module-fwupdate webmin-module-wisecloud webmin-module-netdiag "

RDEPENDS_${PN}-nodered = "\
   zsh nodejs nodejs-npm node-red "

RRECOMMENDS_${PN}-nodered = "\
   node-red-contrib-freeboard "

RDEPENDS_${PN}-wsn = "\
   ${PN}-nodered \
   wsn wsn-dev nodered-wsn "

RDEPENDS_${PN}-alljoyn = "\
   alljoyn alljoyn-dev alljoyn-services alljoyn-services-dev \
   nodered-alljoyn susi-service "

RDEPENDS_${PN}-iotivity = "\
   iotivity-resource-samples iotivity-service-samples iotivity-dev "

RDEPENDS_${PN}-addon = "\
   rmm nodered-susi susi4 susi-iot "

RDEPENDS_${PN}-lxc = "\
   glibc-utils xz debootstrap gnupg tar \
   lxc lxc-setup lxc-networking \
   lxc-baseimage "

RDEPENDS_${PN}-docker = "\
   e2fsprogs-tune2fs docker "

