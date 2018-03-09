# Arago TI SDK base image with test tools
# Suitable for initramfs

CACHE_PARTITION = "/dev/disk/by-label/cache"
ADDON_TEST_FILES_DIR:="${THISDIR}/files/tests"
ADDON_3G_PROVIDER_DIR:="${THISDIR}/files/peers"
ADDON_OTA_START:="${THISDIR}/files/ota"
ADDON_NB136_FW_DIR:="${THISDIR}/files/nb136"

add_nb136_files() {
        mkdir -p ${IMAGE_ROOTFS}/lib/firmware/brcm
        install -m 0755 ${ADDON_NB136_FW_DIR}/brcm_patchram_plus ${IMAGE_ROOTFS}/usr/sbin
        install -m 0644 ${ADDON_NB136_FW_DIR}/bcm43241b4.hcd ${IMAGE_ROOTFS}/lib/firmware/brcm
#        install -m 0644 ${ADDON_NB136_FW_DIR}/brcmfmac43241b4-sdio.bin ${IMAGE_ROOTFS}/lib/firmware/brcm
        install -m 0644 ${ADDON_NB136_FW_DIR}/brcmfmac43241b4-sdio.txt ${IMAGE_ROOTFS}/lib/firmware/brcm
}

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext3       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

modify_do_update() {
	sed -i '54,64d' ${IMAGE_ROOTFS}/tools/do_update.sh
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

copy_env_config() {
	install -m 0755 ${ADDON_OTA_START}/env_config.ini ${IMAGE_ROOTFS}/usr/local/OTA-Agent
}

add_ota_start() {
	install -m 0755 ${ADDON_OTA_START}/ota-start.service ${IMAGE_ROOTFS}/etc/systemd/system/multi-user.target.wants
	install -m 0755 ${ADDON_OTA_START}/ota-start.sh ${IMAGE_ROOTFS}/usr/sbin
}

weston_patch() {
        sed -i "42a sleep 2" ${IMAGE_ROOTFS}/etc/init.d/weston
}

ROOTFS_POSTPROCESS_COMMAND_append = "  modify_fstab; modify_do_update; copy_env_config; add_ota_start;"

ROOTFS_POSTPROCESS_COMMAND_append_omap-a15 = " add_nb136_files; add_test_tools; add_3G_provider; weston_patch;"


