DTB_FILTER_am57xxrom7510a1 = "${DTB_FILTER_am57xx-evm}"

TARGET_IMAGES = "arago-base-tisdk-image tisdk-rootfs-image initramfs-debug-image"

tisdk_image_build () {
    mkdir -p ${IMAGE_ROOTFS}/filesystem

    # Copy the TARGET_IMAGES to the sdk image before packaging
    for image in ${TARGET_IMAGES}
    do
        for type in ${TARGET_IMAGE_TYPES}
        do
            if [ -e ${DEPLOY_DIR_IMAGE}/${image}-${MACHINE}.${type} ]
            then
                cp ${DEPLOY_DIR_IMAGE}/${image}-${MACHINE}.${type} ${IMAGE_ROOTFS}/filesystem/
            fi
        done
    done
    
    cp ${DEPLOY_DIR_IMAGE}/initramfs-debug-image-${MACHINE}.cpio.gz ${IMAGE_ROOTFS}/filesystem/

    # Copy the pre-built images for kernel and boot loaders
    prebuilt_dir="${IMAGE_ROOTFS}/board-support/prebuilt-images"
    if [ ! -e "${prebuilt_dir}" ]
    then
        mkdir -p ${prebuilt_dir}
    fi

    # Copy the U-Boot image if it exists
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.img ]
    then
        cp ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.img ${prebuilt_dir}/
    elif [ -e ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.bin ]
    then
        cp ${DEPLOY_DIR_IMAGE}/u-boot-${MACHINE}.bin ${prebuilt_dir}/
    else
        echo "Could not find the u-boot image"
        return 1
    fi

    # Copy the Kernel image if it exists
    if [ -e ${DEPLOY_DIR_IMAGE}/[uz]Image-${MACHINE}.bin ]
    then
        cp ${DEPLOY_DIR_IMAGE}/[uz]Image-${MACHINE}.bin ${prebuilt_dir}/
    else
        echo "Could not find the Kernel image"
        return 1
    fi

    # Copy the DTB files if they exist.
    # NOTE: For simplicity remove the uImage- prefix on the dtb files.  Get
    # just the symlink files for a cleaner name.  Use the DTB_FILTER variable
    # to allow finding the dtb files for only that MACHINE type
    # NOTE: The DTB_FILTER variable is interpreted as a regex which means
    #       that for cases where the DTB files to be selected do not have
    #       a common naming you can use something line filter1\|filter2 which
    #       will be interpreted as an "or" and allow matching both expressions.
    #       The \| is important for delimiting these values.
    if [ "${DTB_FILTER}" != "unknown" ]
    then
        for f in `find ${DEPLOY_DIR_IMAGE} -type l -regex ".*\(${DTB_FILTER}\).*\.dtb"`
        do
            dtb_file=`basename $f | sed s/.Image-//`
            cp $f ${prebuilt_dir}/${dtb_file}
        done
    fi

    if [ "${DEPLOY_SPL_NAME}" != "" ]
    then
        # Copy the SPL image if it exists
        if [ -e ${DEPLOY_DIR_IMAGE}/${DEPLOY_SPL_NAME} ]
        then
            cp ${DEPLOY_DIR_IMAGE}/${DEPLOY_SPL_NAME} ${prebuilt_dir}/
        else
            echo "Could not find the SPL image"
            return 1
        fi
    fi

    if [ "${DEPLOY_SPL_UART_NAME}" != "" ]
    then
        # Copy the SPL/UART image if it exists
        if [ -e ${DEPLOY_DIR_IMAGE}/${DEPLOY_SPL_UART_NAME} ]
        then
            cp ${DEPLOY_DIR_IMAGE}/${DEPLOY_SPL_UART_NAME} ${prebuilt_dir}/
        fi
    fi

    # Copy TI SCI firmware if it exists
    if [ "${DEPLOY_TISCI_FW_NAME}" != "" ]
    then
        if [ -e ${DEPLOY_DIR_IMAGE}/${DEPLOY_TISCI_FW_NAME} ]
        then
            cp ${DEPLOY_DIR_IMAGE}/${DEPLOY_TISCI_FW_NAME} ${prebuilt_dir}/
        fi
    fi

    # Copy skern/boot-monitor image if it exists
    if [ "${DEPLOY_K2_SKERN_NAME}" != "" ]
    then
        if [ -e ${DEPLOY_DIR_IMAGE}/${DEPLOY_K2_SKERN_NAME} ]
        then
            cp ${DEPLOY_DIR_IMAGE}/${DEPLOY_K2_SKERN_NAME} ${prebuilt_dir}/
        fi
    fi

    # Copy Keystone FW initramfs image if it exists
    if [ "${DEPLOY_K2_FW_INITRD_NAME}" != "" ]
    then
        if [ -e ${DEPLOY_DIR_IMAGE}/${DEPLOY_K2_FW_INITRD_NAME} ]
        then
            cp ${DEPLOY_DIR_IMAGE}/${DEPLOY_K2_FW_INITRD_NAME} ${prebuilt_dir}/
        fi
    fi

    # Add the EXTRA_TISDK_FILES contents if they exist
    # Make sure EXTRA_TISDK_FILES is not empty so we don't accidentaly
    # copy the root directory.
    # Use -L to copy the actual contents of symlinks instead of just
    # the links themselves
    if [ "${EXTRA_TISDK_FILES}" != "" ]
    then
        if [ -d "${EXTRA_TISDK_FILES}" ]
        then
            cp -rLf ${EXTRA_TISDK_FILES}/* ${IMAGE_ROOTFS}/
        fi
    fi

    # Copy the licenses directory in the $DEPLOY_DIR to capture all
    # the licenses that were used in the build.
    if [ -d ${DEPLOY_DIR}/licenses ]
    then
        if [ ! -d ${IMAGE_ROOTFS}/docs ]
        then
            mkdir -p ${IMAGE_ROOTFS}/docs
        fi
        cp -rf ${DEPLOY_DIR}/licenses ${IMAGE_ROOTFS}/docs/
    fi

    # Create the TI software manifest
    generate_sw_manifest

    # Delete installed toolchain sdk since we need the toolchain sdk installer
    # not the extracted version
    rm -rf ${IMAGE_ROOTFS}/${TISDK_TOOLCHAIN_PATH}

    # Copy over the toolchain sdk installer an give it a simple name which
    # matches the traditional name within the SDK.
    cp ${DEPLOY_DIR}/sdk/${SDK_NAME}-${ARMPKGARCH}-${TARGET_OS}${TOOLCHAIN_SUFFIX}.sh ${IMAGE_ROOTFS}/linux-devkit.sh

    # Copy the opkg.conf used by the image to allow for future updates
    cp ${WORKDIR}/opkg.conf ${IMAGE_ROOTFS}/etc/
}


