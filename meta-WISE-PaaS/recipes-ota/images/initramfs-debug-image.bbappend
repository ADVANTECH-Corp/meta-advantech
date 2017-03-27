DEPNEDS += "${PREFERRED_PROVIDER_virtual/kernel}"

BOOTIMG_PAGE_SIZE ?= "2048"

# [i.MX6]
DEPENDS_mx6 += "android-tools-native"
mk_recovery_img_mx6() {

    mkbootimg --kernel ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} \
              --ramdisk ${DEPLOY_DIR_IMAGE}/${PN}-${MACHINE}.cpio.gz \
              --output ${DEPLOY_DIR_IMAGE}/recovery-${MACHINE}.img \
              --second ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-${KERNEL_DEVICETREE} \
              --pagesize ${BOOTIMG_PAGE_SIZE} \
              --base 0x14000000 \
              --cmdline ""

    ln -sf recovery-${MACHINE}.img ${DEPLOY_DIR_IMAGE}/recovery.img
}

IMAGE_POSTPROCESS_COMMAND_mx6 += " mk_recovery_img_mx6 ; "

# [Qcom APQ8016]
DEPENDS_dragonboard-410c += "skales-native"

mk_recovery_img_qcom() {

    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${STAGING_LIBDIR_NATIVE}"
    dtbTool -o ${DEPLOY_DIR_IMAGE}/dt-Image-${MACHINE}.img -s ${BOOTIMG_PAGE_SIZE} ${DEPLOY_DIR_IMAGE}
    mkbootimg_dtarg="--dt ${DEPLOY_DIR_IMAGE}/dt-Image-${MACHINE}.img"
    ln -sf dt-Image-${MACHINE}.img ${DEPLOY_DIR_IMAGE}/dt-Image.img

    mkbootimg --kernel ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} \
              --ramdisk ${DEPLOY_DIR_IMAGE}/${PN}-${MACHINE}.cpio.gz \
              --output ${DEPLOY_DIR_IMAGE}/recovery-${MACHINE}.img \
              $mkbootimg_dtarg \
              --pagesize ${BOOTIMG_PAGE_SIZE} \
              --base 0 \
              --cmdline ""

    ln -sf recovery-${MACHINE}.img ${DEPLOY_DIR_IMAGE}/recovery.img
}

IMAGE_POSTPROCESS_COMMAND_dragonboard-410c += " mk_recovery_img_qcom ; "

# Utilities
PACKAGE_INSTALL += " android-tools base-files boottimes util-linux "
