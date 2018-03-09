
ADDON_MK_EMMC_DIR:="${THISDIR}/files/mk_emmc"

TARGET_IMAGES = "arago-base-tisdk-image tisdk-rootfs-image initramfs-debug-image"

tisdk_image_build_add_initramfs () {
    cp ${DEPLOY_DIR_IMAGE}/initramfs-debug-image-${MACHINE}.cpio.gz ${IMAGE_ROOTFS}/filesystem/
}

tisdk_add_mkemmc_script() {
        install -m 0755 ${ADDON_MK_EMMC_DIR}/mk-eMMC-boot.sh ${IMAGE_ROOTFS}/bin  

        if [ "${MACHINE}" == "am335xrsb4220a1" ] || [ "${MACHINE}" == "am335xrom3310a1" ]; then
                sed -i "262a  sysctl vm.min_free_kbytes=16384" ${IMAGE_ROOTFS}/bin/mk-eMMC-boot.sh
        fi 
}

tisdk_image_build_append () {
    for u in ${DEPLOY_DIR_IMAGE}/u-boot*-${MACHINE}.gph
    do
        if [ -e $u ]
        then
            cp $u ${prebuilt_dir}/
        fi
    done

    for s in ${DEPLOY_DIR_IMAGE}/skern-*.bin
    do
        if [ -e $s ]
        then
            cp $s ${prebuilt_dir}/
        fi
    done

    for fw in ${DEPLOY_DIR_IMAGE}/*fw-initrd.cpio.gz
    do
        if [ -e $fw ]
        then
            cp $fw ${prebuilt_dir}/
        fi
    done

    if [ -e "${IMAGE_ROOTFS}/board-support/extra-drivers/ti-sgx-ddk-km-1.14.3699939/eurasia_km/eurasiacon/binary2_omap_linux_release" ]
    then
        rm -rf ${IMAGE_ROOTFS}/board-support/extra-drivers/ti-sgx-ddk-km-1.14.3699939/eurasia_km/eurasiacon/binary2_omap_linux_release
    fi

}

ROOTFS_POSTPROCESS_COMMAND_append = "tisdk_image_build_add_initramfs;tisdk_add_mkemmc_script; "

