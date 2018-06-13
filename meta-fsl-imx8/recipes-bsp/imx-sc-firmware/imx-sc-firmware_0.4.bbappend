ADDON_FILES_DIR:="${THISDIR}/files"

do_install () {
    install -d ${D}/boot
    install -m 0644 ${ADDON_FILES_DIR}/${SC_FIRMWARE_NAME} ${D}/boot/
}
