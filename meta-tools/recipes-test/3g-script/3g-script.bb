SUMMARY = "A shell script for 3G data connection"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://telit3g.sh \
	   file://ewm-c106.sh \
	   file://3glink \
	   file://3g.chat"

do_install() {
    # Telit
    install -d ${D}/tools
    install -d ${D}/tools/ppp
    install -m 755 ${WORKDIR}/telit3g.sh ${D}/tools/ppp/

    # EWM-C106
    install -m 755 ${WORKDIR}/ewm-c106.sh ${D}/tools/ppp/
    install -d ${D}/etc/ppp/peers
    install -m 644 ${WORKDIR}/3glink ${D}/etc/ppp/peers/
    install -d ${D}/etc/chatscripts
    install -m 644 ${WORKDIR}/3g.chat ${D}/etc/chatscripts/
}

FILES_${PN} = "/tools/ppp"
FILES_${PN} += "/etc/ppp/peers"
FILES_${PN} += "/etc/chatscripts"
