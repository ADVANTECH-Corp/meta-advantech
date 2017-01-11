SUMMARY = "Advantech key_event for i.MX6 platform"
SECTION = "base"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "https://github.com/ADVANTECH-Corp/RISC_tools_source/raw/master/${BPN}-${PV}.tar.gz"
SRC_URI[md5sum] = "06557da72fada30a066ee6fd68ce2451"
SRC_URI[sha256sum] = "da5b801b5234b814d53d096454161b1a47a6b4910e97696cff2a57362f3cbd18"


S = "${WORKDIR}/key_event"

inherit autotools pkgconfig

EXTRA_OECONF = "--host arm-poky-linux-gnueabi"

# We overwrite do_configure() to avoid perform autoreconf again
do_configure() {
    oe_runconf
}


# Because /tools is a customized folder, we need to
# install the folder into sysroot by ourselves.
SYSROOT_PREPROCESS_FUNCS += "diag_sysroot_preprocess"

diag_sysroot_preprocess() {
    install -d ${SYSROOT_DESTDIR}/usr
    install -d ${SYSROOT_DESTDIR}/usr/bin
    install -m 755 ${D}/usr/bin/key_event ${SYSROOT_DESTDIR}/usr/bin/
}

COMPATIBLE_MACHINE = "(mx6)"
