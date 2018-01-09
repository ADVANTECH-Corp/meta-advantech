SUMMARY = "ARM mbed cloud client"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://mbedCloudClientExample.elf \
           file://mbedCloudClientExample-dev.elf"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

do_install() {
    # Developer mode
    mkdir -p ${D}/tools
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/mbedCloudClientExample-dev.elf ${D}/tools/

    # Standard version
    install -d ${D}/${bindir}
    install -m 755 ${WORKDIR}/mbedCloudClientExample.elf ${D}/${bindir}
}

FILES_${PN} = "${bindir} /tools"
