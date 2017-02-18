SUMMARY = "A shell script for 3G data connection"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://telit3g.sh"

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/telit3g.sh ${D}/tools/telit3g.sh
}

FILES_${PN} = "/tools"
