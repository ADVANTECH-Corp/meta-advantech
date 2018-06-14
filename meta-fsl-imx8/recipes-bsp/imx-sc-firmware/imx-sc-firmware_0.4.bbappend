ADDON_FILES_DIR:="${THISDIR}/files"

do_install () {
    install -d ${D}/boot
    install -m 0644 ${ADDON_FILES_DIR}/${SC_FIRMWARE_NAME} ${D}/boot/
}

do_deploy () {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${ADDON_FILES_DIR}/${SC_FIRMWARE_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}/
    cd ${DEPLOYDIR}/${BOOT_TOOLS}/
    rm -f ${symlink_name}
    ln -sf ${SC_FIRMWARE_NAME} ${symlink_name}
    cd -
}
