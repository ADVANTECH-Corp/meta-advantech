
CACHE_PARTITION = "/dev/disk/by-label/cache"

modify_fstab() {
	echo "${CACHE_PARTITION}      /cache               ext3       nosuid,nodev,nomblk_io_submit 0 0" >> ${IMAGE_ROOTFS}/etc/fstab
}

ROOTFS_POSTPROCESS_COMMAND += " modify_fstab"

