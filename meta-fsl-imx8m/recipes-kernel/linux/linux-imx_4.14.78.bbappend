FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_4.14.78_1.0.0_ga"
LOCALVERSION = "-${SRCBRANCH}"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=https;branch=${SRCBRANCH}"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"

do_copy_defconfig_mx8 () {
    cp ${S}/arch/arm64/configs/imx8mq_adv_defconfig ${B}/.config
    cp ${S}/arch/arm64/configs/imx8mq_adv_defconfig ${B}/../defconfig
}

