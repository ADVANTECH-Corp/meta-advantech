FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "7421A1LIV8590-pmic-fix"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=https;branch=${SRCBRANCH}"
SRCREV = "565a4303f995fe1a494cc254d9b64d74a12ae2c1"

# Skip getting GIT revision for local version
SCMVERSION = "n"

do_copy_defconfig () {
    cp ${S}/arch/arm/configs/imx_v7_adv_defconfig ${B}/.config
    cp ${S}/arch/arm/configs/imx_v7_adv_defconfig ${B}/../defconfig
}


