FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://saagent \
	    file://sawatchdog \
"

do_install_append_mx6() {
	install -m 0755    ${WORKDIR}/saagent		${D}${sysconfdir}/init.d/saagent
	install -m 0755    ${WORKDIR}/sawatchdog	${D}${sysconfdir}/init.d/sawatchdog
	update-rc.d -r ${D} saagent start 99 2 3 4 5 .
	update-rc.d -r ${D} sawatchdog start 99 2 3 4 5 .
}

