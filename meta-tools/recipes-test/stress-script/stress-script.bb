SUMMARY = "A stress shell script that Linaro provides for basic test"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://stress.sh"

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/stress.sh ${D}/tools/stress.sh
}

FILES_${PN} = "/tools"
