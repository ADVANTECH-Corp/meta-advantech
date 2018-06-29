SUMMARY = "ARM mbed edge"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://edge-core-dev \
           file://edge-core \
           file://lorapt-example \
           file://pt-example \
           file://pt-example_1520 \
           file://mec \
           file://mec.service"

inherit systemd update-rc.d

SYSTEMD_SERVICE_${PN} = "mec.service"
INITSCRIPT_NAME = "mec"
INITSCRIPT_PARAMS = "start 99 3 5 . stop 77 0 1 2 6 ."

do_install() {
    # Developer mode
    mkdir -p ${D}/tools
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/edge-core-dev ${D}/tools/

    # Standard version
    install -d ${D}/${bindir}
    install -m 755 ${WORKDIR}/edge-core ${D}/${bindir}
    install -m 755 ${WORKDIR}/lorapt-example ${D}/${bindir}
    install -m 755 ${WORKDIR}/pt-example ${D}/${bindir}
    install -m 755 ${WORKDIR}/pt-example_1520 ${D}/${bindir}

    # SysV
    if ${@bb.utils.contains('DISTRO_FEATURES','sysvinit','true','false',d)}; then
        install -d ${D}${sysconfdir}/init.d
        install -m 0755 ${WORKDIR}/mec ${D}${sysconfdir}/init.d/mec
    fi

    # Systemd
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system
        install -m 0644 ${WORKDIR}/mec.service ${D}${systemd_unitdir}/system
    fi
}

RDEPENDS_${PN} += "libevent jansson mosquitto"

FILES_${PN} += "${bindir} /tools"
