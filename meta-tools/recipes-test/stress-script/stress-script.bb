SUMMARY = "A stress shell script that Linaro provides for basic test"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://stress.sh \
	   file://power-test.service"

inherit systemd

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/stress.sh ${D}/tools/stress.sh

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/power-test.service ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN} = "power-test.service"
SYSTEMD_AUTO_ENABLE_${PN} = "disable"

FILES_${PN} = "/tools"
