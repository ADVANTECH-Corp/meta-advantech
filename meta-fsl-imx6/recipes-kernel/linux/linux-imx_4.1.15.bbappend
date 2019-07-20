FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_4.1.15_2.0.0_ga"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "2dc4a32514ad402e521d8fdb5a79fac94376c95a"

# Skip getting GIT revision for local version
SCMVERSION = "n"

do_copy_defconfig_mx6 () {
    cp ${S}/arch/arm/configs/imx_v7_adv_defconfig ${B}/.config
    cp ${S}/arch/arm/configs/imx_v7_adv_defconfig ${B}/../defconfig
}

do_copy_defconfig_mx7 () {
    cp ${S}/arch/arm/configs/imx_v7_adv_imx7_defconfig ${B}/.config
    cp ${S}/arch/arm/configs/imx_v7_adv_imx7_defconfig ${B}/../defconfig
}
