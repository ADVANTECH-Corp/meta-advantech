IMAGE_INSTALL += " ota-script "

#RMM & SUSI_4.0
IMAGE_INSTALL += "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target python-paho-mqtt libxmu  "

IMAGE_INSTALL += "\
   ota-rmm susi4 susi-iot "

OTA_CONFIGS_DIR:="${THISDIR}/files"
CACHE_PARTITION = "/dev/disk/by-label/cache"

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext4       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

copy_env_config() {
	install -m 0755 ${OTA_CONFIGS_DIR}/env_config.ini ${IMAGE_ROOTFS}/usr/local/OTA-Agent
}
ROOTFS_POSTPROCESS_COMMAND += "modify_fstab; copy_env_config"

