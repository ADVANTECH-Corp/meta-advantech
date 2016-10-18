FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCBRANCH = "imx_4.1.15_1.0.0_ga"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-imx6.git;protocol=git;branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"

# Skip getting GIT revision for local version
SCMVERSION = "n"


