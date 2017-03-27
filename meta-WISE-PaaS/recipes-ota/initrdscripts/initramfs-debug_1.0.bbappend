do_install() {
        # Mount /cache
        sed -i "30a mkdir /cache" ${WORKDIR}/init-debug.sh
        sed -i "31a mount /cache" ${WORKDIR}/init-debug.sh

        # Execute OTA update
        sed -i "32a boot_times" ${WORKDIR}/init-debug.sh

        install -m 0755 ${WORKDIR}/init-debug.sh ${D}/init
}
