CACHE_PARTITION = "/dev/disk/by-label/cache"

do_install_prepend() {

echo "${CACHE_PARTITION}      /cache               ext4       nosuid,nodev,nomblk_io_submit 0 0" >> ${WORKDIR}/fstab

}
