UMMARY = "Factory test programs for IMX BSP"
SECTION = "base"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "svn://172.20.2.44/svn/essrisc/iMX6/Linux/tools_source;module=diagnostic;protocol=https"
SRCREV = "${AUTOREV}"
S = "${WORKDIR}/diagnostic"

inherit autotools pkgconfig

do_compile() {
}

do_install() {
	mkdir -p ${D}/tools
	install -m 0775 ${S}/conf/*.ini ${D}/tools
	install -m 0775 ${S}/script/format_usb.sh ${D}/tools
	install -m 0775 ${S}/content/Advantech.avi ${D}/tools
	install -m 0775 ${S}/content/Advantech.wav ${D}/tools
	install -m 0775 ${S}/content/RISC_e.mp4 ${D}/tools
	install -m 0775 ${S}/content/videoplayback.mp4 ${D}/tools
#	install -m 0775 ${S}/binary/diag_all ${D}/tools
#	install -m 0775 ${S}/binary/dqa_test ${D}/tools
	cp -a ${S}/binary/binary.tgz ${D}/tools
}

# List the files for Package
FILES_${PN} += "/tools"

# [Workaround] Skip package QA check for debug-files
#INSANE_SKIP_${PN} = "debug-files"

# Build-time dependencies
#DEPENDS = "susi dustdiaglib"

# Run-time dependencies
#RDEPENDS_${PN} = "fbv stress"

COMPATIBLE_MACHINE = "(mx6)"
