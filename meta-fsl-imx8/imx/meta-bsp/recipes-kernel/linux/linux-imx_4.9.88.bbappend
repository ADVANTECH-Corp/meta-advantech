FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_4.9.88_2.0.0_ga"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=https"
SRC_URI = "${KERNEL_SRC};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"

