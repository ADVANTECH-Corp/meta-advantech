# Copyright (C) 2015 2016 Advantech

DESCRIPTION = "Advantech RMM"
SECTION = "libs"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD;md5=3775480a712fc46a69647678acb234cb"
PR = "r0"

SRC_URI_mx6 = "file://rmmagent-Distro-4.1.15-2.0.0-armv7l-3.2.19.7639.run.tar.gz"
SRC_URI_mx6[md5sum] = "f4dc3b879742847fb6510ef5d2125086"

SRC_URI_dragonboard-410c = "file://rmmagent-inaro-aarch64-3.2.18.7253.run.tar.gz"
SRC_URI_dragonboard-410c[md5sum] = "b049ccdf0169d1b13f29b5ae8e6f5991"

S = "${WORKDIR}"

DEPENDS = "avahi openssl libxext curl libxml2 libx11 jpeg libxrandr zlib \
           sqlite3 libxtst libxinerama libxdamage libxfixes mosquitto \
           libmodbus"

inherit autotools pkgconfig

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
	mkdir -p ${D}/tools
	install -m 0775 ${S}/Wrapped/* ${D}/tools
}

# List the files for Package
FILES_${PN} += "/tools"


