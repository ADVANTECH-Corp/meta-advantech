SUMMARY = "Advantech key_event for i.MX6 platform"
SECTION = "base"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "https://github.com/ADVANTECH-Corp/RISC_tools_source/raw/master/${BPN}-${PV}.tar.gz"
SRC_URI[md5sum] = "9fb6954bed858e9f005d131f66d7b24f"
SRC_URI[sha256sum] = "fe6d12e98b15b2ca2b81c7a63b05cd87e2091692d6c5f435dda41badb04c542d"

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
