FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://lircd_conf.patch \
           file://lircrc.patch \
           file://configure.patch"
FILES_${PN} += "/configs"

