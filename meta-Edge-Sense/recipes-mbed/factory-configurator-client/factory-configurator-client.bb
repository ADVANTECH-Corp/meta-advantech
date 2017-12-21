SUMMARY = "ARM mbed factory configurator client"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://factory-configurator-client-example.elf"

do_install() {
    install -d ${D}/${bindir}
    install -m 755 ${WORKDIR}/factory-configurator-client-example.elf ${D}/${bindir}
}

FILES_${PN} = "${bindir}"
