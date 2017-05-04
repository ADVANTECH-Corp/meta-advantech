IMAGE_INSTALL += " ota-script fsl-rc-local"

#RMM & SUSI_4.0
IMAGE_INSTALL += "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target python-paho-mqtt libxmu  "

IMAGE_INSTALL += "\
   ota-rmm susi4 susi-iot "

ADDON_FILES_DIR:="${THISDIR}/files"

update_issue() {
	sed -i "s/Freescale/Yocto/g" ${IMAGE_ROOTFS}/etc/issue
}

replace_rc_local() {
	install -m 0755 ${ADDON_FILES_DIR}/rc.local ${IMAGE_ROOTFS}/etc
}


ROOTFS_POSTPROCESS_COMMAND += " update_issue; replace_rc_local"

