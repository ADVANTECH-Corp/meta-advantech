FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://modify_interfaces.patch"
S = "${WORKDIR}"