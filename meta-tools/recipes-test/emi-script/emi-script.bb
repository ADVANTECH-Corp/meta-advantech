SUMMARY = "Shell scripts for EMI test"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://emi_run \
	   file://emi_rs232.sh \
	   file://dupchar.sh \
	   file://emi-test.service"

inherit systemd

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/emi_run ${D}/tools/emi_run
    install -m 755 ${WORKDIR}/emi_rs232.sh ${D}/tools/emi_rs232.sh
    install -m 755 ${WORKDIR}/dupchar.sh ${D}/tools/dupchar.sh

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/emi-test.service ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN} = "emi-test.service"
SYSTEMD_AUTO_ENABLE_${PN} = "disable"

FILES_${PN} = "/tools"
