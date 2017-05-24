# Copyright (C) 2015 2016 Advantech

DESCRIPTION = "Advantech RMM"
SECTION = "libs"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD;md5=3775480a712fc46a69647678acb234cb"
PR = "r0"

SRC_URI_mx6 = "file://rmmagent-Poky-1.5.3-armv7l-3.2.13.6821.run.tar.gz"
SRC_URI_mx6[md5sum] = "686440396e9cae8bc95ad28d57f39f36"

SRC_URI_dragonboard-410c = "file://rmmagent-inaro-aarch64-3.2.18.7253.run.tar.gz"
SRC_URI_dragonboard-410c[md5sum] = "b049ccdf0169d1b13f29b5ae8e6f5991"

SRC_URI_quark = "file://rmmagent-iot-devkit-i586-3.2.18.7276.run.tar.gz"
SRC_URI_quark[md5sum] = "cb88f969b06a4ed8fd79362fd00f2af1"

S = "${WORKDIR}"

DEPENDS = "avahi openssl libxext curl libxml2 libx11 jpeg libxrandr zlib \
           sqlite3 libxtst libxinerama libxdamage libxfixes mosquitto \
           libmodbus"

inherit autotools pkgconfig

do_install() {
	mkdir -p ${D}/tools
	install -m 0775 ${S}/Wrapped/* ${D}/tools
}

# List the files for Package
FILES_${PN} += "/tools"


