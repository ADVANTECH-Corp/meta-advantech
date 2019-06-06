ADDON_FILES_DIR:="${THISDIR}/files"

do_install () {
    cp -a ${ADDON_FILES_DIR}/${SC_FIRMWARE_NAME} ${S}
    install -d ${D}/boot
    install -m 0644 ${S}/${SC_FIRMWARE_NAME} ${D}/boot/
}
