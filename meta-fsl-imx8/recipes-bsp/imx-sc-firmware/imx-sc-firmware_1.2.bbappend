ADDON_FILES_DIR:="${THISDIR}/files"

SC_FIRMWARE_NAME_imx8qmrom7720a1 = "mx8qm-rom7720-scfw-tcm.bin"
SC_FIRMWARE_NAME_imx8qxprom5620a1 = "mx8qx-rom5620-scfw-tcm.bin"

do_deploy_prepend () {
    cp -a ${ADDON_FILES_DIR}/${SC_FIRMWARE_NAME} ${S}
}
