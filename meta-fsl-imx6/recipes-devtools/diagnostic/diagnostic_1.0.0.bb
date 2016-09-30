SUMMARY = "Factory test programs for IMX BSP"
SECTION = "base"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "svn://172.20.2.44/svn/essrisc/iMX6/Linux/tools_source;module=diagnostic;protocol=https"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/diagnostic"

inherit autotools pkgconfig

EXTRA_OECONF = "--host arm-poky-linux-gnueabi --prefix / CPPFLAGS=-I${SYSROOT_DESTDIR}/usr/include LDFLAGS=-L${SYSROOT_DESTDIR}/usr/lib"

# We overwrite do_configure() to avoid perform autoreconf again
do_configure() {
    oe_runconf
}

# Because /tools is a customized folder, we need to
# install the folder into sysroot by ourselves.
SYSROOT_PREPROCESS_FUNCS += "diag_sysroot_preprocess"

diag_sysroot_preprocess() {
    install -d ${SYSROOT_DESTDIR}/tools
    install -m 644 ${D}/tools/*.* ${SYSROOT_DESTDIR}/tools/
    install -m 755 ${D}/tools/diag_all ${SYSROOT_DESTDIR}/tools/
    install -m 755 ${D}/tools/dqa_test ${SYSROOT_DESTDIR}/tools/
}

# List the files for Package
FILES_${PN} += "/tools"
CONFFILES_${PN} += "/tools/*.ini"
FILES_${PN}-dbg += "/tools/.debug"

# Build-time dependencies
DEPENDS = "susi dustdiaglib"

# Run-time dependencies
RDEPENDS_${PN} = "fbv stress"

COMPATIBLE_MACHINE = "(mx6)"
