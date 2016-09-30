FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://modify_usbmount.patch"
S = "${WORKDIR}"

