FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_4.1.15_2.0.0_ga_7421"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "9d668254ca11915a51cd3f4da333ac2a20595455"

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
