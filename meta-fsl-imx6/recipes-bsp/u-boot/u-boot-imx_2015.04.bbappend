FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
UBOOT_SRC = "git://github.com/ADVANTECH-Corp/uboot-imx.git;protocol=git"
SRCREV = "${AUTOREV}"


PARALLEL_MAKE = ""
UBOOT_MAKE_TARGET += "all"
SPL_BINARY = "SPL"

do_deploy_append() {
    install -d ${DEPLOYDIR}
    install ${S}/${config}/u-boot_crc.bin.crc ${DEPLOYDIR}/u-boot_crc.bin.crc
    install ${S}/${config}/u-boot_crc.bin ${DEPLOYDIR}/u-boot_crc.bin
}
