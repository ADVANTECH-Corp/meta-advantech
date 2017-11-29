IMAGE_INSTALL += " ota-script "
IMAGE_INSTALL += " ota-rmm "
IMAGE_INSTALL += " fsl-rc-local e2fsprogs-resize2fs "
IMAGE_INSTALL += " python-paho-mqtt libxmu "

#RMM & SUSI_4.0
IMAGE_INSTALL += "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev "

IMAGE_INSTALL += "\
   rmm susi4 susi-iot "

ADDON_FILES_DIR:="${THISDIR}/files"
CACHE_PARTITION = "/dev/disk/by-label/cache"

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext4       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

replace_rc_local() {
	install -m 0755 ${ADDON_FILES_DIR}/rc.local ${IMAGE_ROOTFS}/etc
}

copy_env_config() {
	install -m 0755 ${ADDON_FILES_DIR}/env_config.ini ${IMAGE_ROOTFS}/usr/local/OTA-Agent
}
ROOTFS_POSTPROCESS_COMMAND += " replace_rc_local; modify_fstab; copy_env_config"

