FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_v2016.03_4.1.15_2.0.0_ga"
UBOOT_SRC = "git://github.com/ADVANTECH-Corp/uboot-imx6.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "1111f50de8b61f3760425039cc6bafacd05066eb"


PARALLEL_MAKE = ""
UBOOT_MAKE_TARGET += "all"
SPL_BINARY = "SPL"

do_deploy_append() {
    install -d ${DEPLOYDIR}
    install ${S}/${config}/u-boot_crc.bin.crc ${DEPLOYDIR}/u-boot_crc.bin.crc
    install ${S}/${config}/u-boot_crc.bin ${DEPLOYDIR}/u-boot_crc.bin
}
