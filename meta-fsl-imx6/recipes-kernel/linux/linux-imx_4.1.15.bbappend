FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
KERNEL_SRC = "git://github.com/ADVANTECH-Corp/linux-2.6-imx.git;protocol=git"
SRCREV = "${AUTOREV}"

# Skip getting GIT revision for local version
SCMVERSION = "n"


