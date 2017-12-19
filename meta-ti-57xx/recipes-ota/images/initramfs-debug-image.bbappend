
ADDON_ADV_OTA_DIR:="${THISDIR}/files"

modify_fstab() {
        echo "${CACHE_PARTITION}      /cache               ext3       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

mv_init_to_sbin() {
        sed -i "30a export PATH" ${IMAGE_ROOTFS}/init
        mv ${IMAGE_ROOTFS}/init ${IMAGE_ROOTFS}/sbin
}

modify_adv_ota() {
	install -m 0755 ${ADDON_ADV_OTA_DIR}/adv-ota.sh ${IMAGE_ROOTFS}/tools
}



ROOTFS_POSTPROCESS_COMMAND += "; mv_init_to_sbin; modify_adv_ota; "

PACKAGE_INSTALL_remove = " android-tools "

PACKAGE_INSTALL += " e2fsprogs-mke2fs "


