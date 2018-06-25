IMAGE_INSTALL += " ota-script "
IMAGE_INSTALL += " ota-rmm "

OTA_CONFIGS_DIR:="${THISDIR}/files"
CACHE_PARTITION = "/dev/disk/by-label/cache"

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext3       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

modify_do_update() {
	sed -i '54,64d' ${IMAGE_ROOTFS}/tools/do_update.sh
}

copy_env_config() {
	install -m 0755 ${OTA_CONFIGS_DIR}/env_config.ini ${IMAGE_ROOTFS}/usr/local/OTA-Agent
}

add_ota_start() {
	install -m 0755 ${OTA_CONFIGS_DIR}/ota-start.service ${IMAGE_ROOTFS}/etc/systemd/system/multi-user.target.wants
	install -m 0755 ${OTA_CONFIGS_DIR}/ota-start.sh ${IMAGE_ROOTFS}/usr/sbin
}

ROOTFS_POSTPROCESS_COMMAND_append = "  modify_fstab; modify_do_update; copy_env_config; add_ota_start;"
