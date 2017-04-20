# Copyright (C) 2017 Advantech
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_dragonboard-410c += "file://wired-dhcp.network"

do_install_append_dragonboard-410c() {
        install -d ${D}${sysconfdir}/systemd/network/
        install -m 0644 ${WORKDIR}/wired-dhcp.network ${D}${sysconfdir}/systemd/network/wired-dhcp.network
}

FILES_${PN} += " ${sysconfdir}/systemd/network"
