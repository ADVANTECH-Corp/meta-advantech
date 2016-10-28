do_install_append() {
        install -d ${D}${sysconfdir}/bluetooth/
        if [ -f ${S}/profiles/audio/audio.conf ]; then
            install -m 0644 ${S}/profiles/audio/audio.conf ${D}/${sysconfdir}/bluetooth/
        fi
        if [ -f ${S}/profiles/network/network.conf ]; then
            install -m 0644 ${S}/profiles/network/network.conf ${D}/${sysconfdir}/bluetooth/
        fi
        if [ -f ${S}/profiles/input/input.conf ]; then
            install -m 0644 ${S}/profiles/input/input.conf ${D}/${sysconfdir}/bluetooth/
        fi
        if [ -f ${S}/tools/obexctl ]; then
            install -m 0755 ${S}/tools/obexctl ${D}${bindir}
        fi 
        if [ -f ${S}/tools/obex-server-tool ]; then
            install -m 0755 ${S}/tools/obex-server-tool ${D}${bindir}
        fi 
        if [ -f ${S}/tools/obex-client-tool ]; then
            install -m 0755 ${S}/tools/obex-client-tool ${D}${bindir}
        fi 
        if [ -f ${S}/attrib/gatttool ]; then
            install -m 0755 ${S}/attrib/gatttool ${D}${bindir}
        fi 
        # at_console doesn't really work with the current state of OE, so punch some more holes so people can actually use BT
        install -m 0644 ${WORKDIR}/bluetooth.conf ${D}/${sysconfdir}/dbus-1/system.d/
}

