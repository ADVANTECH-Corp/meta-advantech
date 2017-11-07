# Copyright (C) 2015 Advantech

DESCRIPTION = "Advantech SUSI IoT"
LICENSE = "Proprietary"
SECTION = "libs"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"

SRC_URI_mx6 = "file://SusiIoT_Release_14160.tar.gz"
SRC_URI_mx6[md5sum] = "df6b5124295e3673701fea90bea431fe"

SRC_URI_dragonboard-410c = "file://SusiIoT_qualcomm_dragon_yocto_Release_14555_2017-07-25.tar.gz"
SRC_URI_dragonboard-410c[md5sum] = "76301989722e4799107a2d492cb04ecf"

SRC_URI_dra7xx = "file://SusiIoT_Release_14532.tar.gz"
SRC_URI_dra7xx[md5sum] = "ac05ba74e4acd54d5e64f6796a963d62"

S = "${WORKDIR}/release"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

do_install() {
	install -d ${D}/usr/lib/Advantech/iot/modules
	cp -axr ${S}/library/*.so* ${D}/usr/lib/
	cp -axr ${S}/library/modules/libSUSIDrv.so ${D}/usr/lib/Advantech/iot/modules/
}

# List the files for Package
FILES_${PN} += "/usr/lib"

FILES_SOLIBSDEV = ""
INSANE_SKIP_${PN} += "dev-so host-user-contaminated libdir"
