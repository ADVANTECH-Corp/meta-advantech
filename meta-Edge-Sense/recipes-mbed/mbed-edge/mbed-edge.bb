SUMMARY = "ARM mbed edge"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://edge-core-dev \
           file://edge-core \
           file://lorapt-example \
           file://pt-example \
           file://pt-example_1520 "

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
}

FILES_${PN} = "${bindir} /tools"
