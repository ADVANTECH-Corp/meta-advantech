#Advantech package
require fsl-image-adv.inc

ADDON_FILES_DIR:="${THISDIR}/files"

fbi_rootfs_postprocess() {
    crond_conf=${IMAGE_ROOTFS}/var/spool/cron/root
        echo '0 0-23/12 * * * /sbin/hwclock --hctosys' >> $crond_conf
}

install_utils() {
    mkdir -p ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_pair.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_send.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_obexd_start.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_obexd_stop.sh ${IMAGE_ROOTFS}/usr/local/bin
    mkdir -p ${IMAGE_ROOTFS}/lib/firmware/rtlwifi/rtl8821ae
    install -m 0755 ${ADDON_FILES_DIR}/wifi_ant_isolation.txt ${IMAGE_ROOTFS}/lib/firmware/rtlwifi/rtl8821ae
}

ROOTFS_POSTPROCESS_COMMAND += "fbi_rootfs_postprocess; install_utils;"
