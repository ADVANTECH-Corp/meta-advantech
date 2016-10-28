FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/ADVANTECH-Corp/linux-quark;protocol=git;branch=linux-3.14.28"

SRC_URI += "file://quark_3.14.cfg"
SRC_URI += "file://quark-standard_3.14.scc"
SRC_URI_append_quark_iot-devkit = " file://kernel-perf-tool.scc"
SRC_URI += "${@base_contains('PACKAGECONFIG','quark-tpm','file://tpm.cfg','',d)}"

SRC_URI += "file://${DISTRO}.cfg"
SRC_URI += "file://${BOARD}.cfg"
# LINUX_VERSION_EXTENSION = "-yocto-standard"
LINUX_VERSION_EXTENSION = "-advantech_quark_512M_2.011_svn171"
