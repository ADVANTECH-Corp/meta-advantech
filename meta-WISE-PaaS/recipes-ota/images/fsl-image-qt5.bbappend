IMAGE_INSTALL += " ota-script "
IMAGE_INSTALL += " ota-rmm "
IMAGE_INSTALL += " python-paho-mqtt libxmu "

OTA_CONFIGS_DIR:="${THISDIR}/files"
CACHE_PARTITION = "/dev/disk/by-label/cache"

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext4       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

copy_env_config() {
	install -m 0755 ${OTA_CONFIGS_DIR}/env_config.ini ${IMAGE_ROOTFS}/usr/local/OTA-Agent
}
ROOTFS_POSTPROCESS_COMMAND += "modify_fstab; copy_env_config"

