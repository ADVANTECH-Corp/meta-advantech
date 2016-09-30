SUMMARY = "A shell script provides stress on CPU & WiFi for thermal measurement"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://thermal.sh"

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/thermal.sh ${D}/tools/thermal.sh
}

FILES_${PN} = "/tools"
