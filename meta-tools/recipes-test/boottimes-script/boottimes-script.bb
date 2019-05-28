SUMMARY = "Boot times counter service"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://boottimes.sh \
	   file://boottimes.service"

inherit systemd
RDEPENDS_${PN} += "bash"

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/boottimes.sh ${D}/tools/boottimes.sh

    #sysvinit
    if ${@bb.utils.contains('DISTRO_FEATURES','sysvinit','true','false',d)}; then
        install -d ${D}${sysconfdir}/init.d
        install -m 0755 ${WORKDIR}/power-test ${D}${sysconfdir}/init.d/power-test
    fi

    # systemd
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/boottimes.service ${D}${systemd_unitdir}/system
    fi
}

SYSTEMD_SERVICE_${PN} = "boottimes.service"

FILES_${PN} = "/tools ${sysconfdir}/init.d"
