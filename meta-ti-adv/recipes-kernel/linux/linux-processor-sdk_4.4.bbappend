BRANCH = "processor-sdk-linux-03.01.00"
SRC_URI = "git://github.com/ADVANTECH-Corp/linux-ti.git;protocol=https;branch=${BRANCH}"
SRCREV = "e554e1da231620ce2081e4b2f0f413f1af56775c"

do_configure() {
    # Always copy the defconfig file to .config to keep consistency
    # between the case where there is a real config and the in kernel
    # tree config

    #cp ${WORKDIR}/defconfig ${B}/.config
    if [ "${SOC_FAMILY}" = "omap-a15:dra7xx" ] ; then
        cp ${S}/arch/arm/configs/am57xx-adv_defconfig ${B}/.config
    elif [ "${SOC_FAMILY}" = "ti33x" ] ; then
        cp ${S}/arch/arm/configs/am335x-adv_defconfig ${B}/.config
    fi

    echo ${KERNEL_LOCALVERSION} > ${B}/.scmversion
    echo ${KERNEL_LOCALVERSION} > ${S}/.scmversion

    # Zero, when using "tisdk" configs, pass control to defconfig_builder
    config=`cat ${B}/.config | grep use-tisdk-config | cut -d= -f2`
    if [ -n "$config" ]
    then
        ${S}/ti_config_fragments/defconfig_builder.sh -w ${S} -t $config
        oe_runmake -C ${S} O=${B} "$config"_defconfig
    else
        # First, check if pointing to a combined config with config fragments
        config=`cat ${B}/.config | grep use-combined-config | cut -d= -f2`
        if [ -n "$config" ]
        then
            cp ${S}/$config ${B}/.config
        fi

        # Second, extract any config fragments listed in the defconfig
        config=`cat ${B}/.config | grep config-fragment | cut -d= -f2`
        if [ -n "$config" ]
        then
            configfrags=""
            for f in $config
            do
                # Check if the config fragment is available
                if [ ! -e "${S}/$f" ]
                then
                    echo "Could not find kernel config fragment $f"
                    exit 1
		else
                    # Sanitize config fragment files to be relative to sources
                    configfrags="$configfrags ${S}/$f"
                fi
            done
        fi

        # Third, check if pointing to a known in kernel defconfig
        config=`cat ${B}/.config | grep use-kernel-config | cut -d= -f2`
        if [ -n "$config" ]
        then
            oe_runmake -C ${S} O=${B} $config
        else
            yes '' | oe_runmake -C ${S} O=${B} oldconfig
        fi
    fi

    # Fourth, handle config fragments specified in the recipe
    # The assumption is that the config fragment will be specified with the absolute path.
    # E.g. ${WORKDIR}/config1.cfg or ${S}/config2.cfg
    if [ -n "${KERNEL_CONFIG_FRAGMENTS}" ]
    then
        for f in ${KERNEL_CONFIG_FRAGMENTS}
        do
            # Check if the config fragment is available
            if [ ! -e "$f" ]
            then
                echo "Could not find kernel config fragment $f"
                exit 1
            fi
        done
    fi

    # Now that all the fragments are located merge them
    if [ -n "${KERNEL_CONFIG_FRAGMENTS}" -o -n "$configfrags" ]
    then
        ( cd ${WORKDIR} && ${S}/scripts/kconfig/merge_config.sh -m -r -O ${B} ${B}/.config $configfrags ${KERNEL_CONFIG_FRAGMENTS} 1>&2 )
        yes '' | oe_runmake -C ${S} O=${B} oldconfig
    fi
}
