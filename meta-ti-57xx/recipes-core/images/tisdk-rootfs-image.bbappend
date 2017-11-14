
CACHE_PARTITION = "/dev/disk/by-label/cache"

ADDON_TEST_FILES_DIR:="${THISDIR}/files"

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

ROOTFS_POSTPROCESS_COMMAND += " modify_fstab; modify_do_update; add_test_tools"

