# Arago TI SDK base image with test tools
# Suitable for initramfs

ADDON_TEST_FILES_DIR:="${THISDIR}/files/tests"
ADDON_3G_PROVIDER_DIR:="${THISDIR}/files/peers"
ADDON_NB136_FW_DIR:="${THISDIR}/files/nb136"

add_nb136_files() {
        mkdir -p ${IMAGE_ROOTFS}/lib/firmware/brcm
        install -m 0755 ${ADDON_NB136_FW_DIR}/brcm_patchram_plus ${IMAGE_ROOTFS}/usr/sbin
        install -m 0644 ${ADDON_NB136_FW_DIR}/bcm43241b4.hcd ${IMAGE_ROOTFS}/lib/firmware/brcm
#        install -m 0644 ${ADDON_NB136_FW_DIR}/brcmfmac43241b4-sdio.bin ${IMAGE_ROOTFS}/lib/firmware/brcm
        install -m 0644 ${ADDON_NB136_FW_DIR}/brcmfmac43241b4-sdio.txt ${IMAGE_ROOTFS}/lib/firmware/brcm
}

add_test_tools() {
        mkdir -p ${IMAGE_ROOTFS}/unit_tests
        install -m 0644 ${ADDON_TEST_FILES_DIR}/libbluetooth.so.2 ${IMAGE_ROOTFS}/lib
        install -m 0755 ${ADDON_TEST_FILES_DIR}/obexpushd ${IMAGE_ROOTFS}/usr/sbin
        install -m 0755 ${ADDON_TEST_FILES_DIR}/ussp-push ${IMAGE_ROOTFS}/usr/sbin
        install -m 0755 ${ADDON_TEST_FILES_DIR}/Loop_uart232 ${IMAGE_ROOTFS}/unit_tests
}

add_3G_provider() {
        install -m 0744 ${ADDON_3G_PROVIDER_DIR}/* ${IMAGE_ROOTFS}/etc/ppp/peers
}

ROOTFS_POSTPROCESS_COMMAND_append_omap-a15 = " add_nb136_files; add_test_tools; add_3G_provider; "
