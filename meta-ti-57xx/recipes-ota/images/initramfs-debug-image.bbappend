
modify_fstab() {
        echo "${CACHE_PARTITION}      /cache               ext3       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

