SUMMARY = "Advantech rs-485 test tool for i.MX6 platform"
SECTION = "base"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "svn://172.20.2.44/svn/essrisc/iMX6/Linux/tools_source;module=st;protocol=https"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/st"

inherit autotools pkgconfig

EXTRA_OECONF = "--prefix=/usr"
EXTRA_OECONF_append = " --host APPEND"
EXTRA_OECONF_append_arm = " --host _arm"
EXTRA_OECONF_append_imx = " --host _imx"
EXTRA_OECONF_append_iMX = " --host _iMX"
EXTRA_OECONF_append_mx = " --host _mx"
EXTRA_OECONF_append_quark = " --host _quark"
EXTRA_OECONF_append_x86 = " --host _x86"

# We overwrite do_configure() to avoid perform autoreconf again
do_configure() {
    oe_runconf
}



COMPATIBLE_MACHINE = "(mx6|quark)"
