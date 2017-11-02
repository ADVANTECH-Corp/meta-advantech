IMAGE_INSTALL_append = " ota-script "
IMAGE_INSTALL_append = " ota-rmm "

OTA_CONFIGS_DIR:="${THISDIR}/files"
CACHE_PARTITION = "/dev/disk/by-partlabel/cache"

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext4       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

replace_rc_local() {
	install -m 0755 ${OTA_CONFIGS_DIR}/rc.local ${IMAGE_ROOTFS}/etc
}

copy_env_config() {
	install -m 0755 ${OTA_CONFIGS_DIR}/env_config.ini ${IMAGE_ROOTFS}/usr/local/OTA-Agent
}

ROOTFS_POSTPROCESS_COMMAND += "replace_rc_local; modify_fstab; copy_env_config;"
