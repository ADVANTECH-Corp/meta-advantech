
CACHE_PARTITION = "/dev/disk/by-label/cache"

ADDON_TEST_FILES_DIR:="${THISDIR}/files/tests"

ADDON_3G_PROVIDER_DIR:="${THISDIR}/files/peers"

ADDON_OTA_START:="${THISDIR}/files/ota"

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

ROOTFS_POSTPROCESS_COMMAND += " modify_fstab; modify_do_update; add_test_tools; add_3G_provider; copy_env_config; add_ota_start"

