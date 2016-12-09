# Copyright (C) 2015 Advantech

DESCRIPTION = "Advantech SUSI4.0"
LICENSE = "Proprietary"
SECTION = "libs"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"

SRC_URI_rsb-4760 = "file://Susi4_qualcomm_dragon_yocto_Release__2016-12-09.tar.gz"
SRC_URI_rsb-4760[md5sum] = "eb3f1f9d3b800892dbe4cffe48edfe4f"
SRC_URI_epc-r4761 = "file://Susi4_qualcomm_dragon_yocto_Release__2016-12-09.tar.gz"
SRC_URI_epc-r4761[md5sum] = "eb3f1f9d3b800892dbe4cffe48edfe4f"
SRC_NAME = "SUSI4.0.14214"

S = "${WORKDIR}/${SRC_NAME}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

DEPENDS = "zlib pciutils"

do_install() {
	install -d ${D}/usr/lib/Advantech/Susi/ini
	cp -axr ${S}/Driver/ini/*.ini ${D}/usr/lib/Advantech/Susi/ini
	cp -axr ${S}/Driver/lib*.* ${D}/usr/lib/
}

# List the files for Package
FILES_${PN} += "/usr/lib"

# Put all SO files in main rpm package
FILES_SOLIBSDEV = ""
INSANE_SKIP_${PN} += "dev-so"

# Set alias of susi4 to libsusi-4.00 which is identical to the package name
RPROVIDES_${PN} = "libsusi-4.00"
