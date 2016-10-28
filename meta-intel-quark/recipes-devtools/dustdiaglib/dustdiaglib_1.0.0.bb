SUMMARY = "Advantech DustWSN Diagnostic API for Quark platform"
SECTION = "libs"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "svn://172.20.2.44/svn/essrisc/iMX6/Linux/tools_source;module=dust_diaglib;protocol=https"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/dust_diaglib"

inherit autotools pkgconfig

EXTRA_OECONF = "--host i586-poky-linux-uclibc --prefix /usr"

# We overwrite do_configure() to avoid perform autoreconf again
do_configure() {
    oe_runconf
}

# [Workaround] Skip package QA check for RPATH
INSANE_SKIP_${PN} = "rpaths"
