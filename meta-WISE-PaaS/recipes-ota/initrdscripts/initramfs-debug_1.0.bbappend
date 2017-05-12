do_install() {
        # Mount /cache
        sed -i "30a mkdir /cache" ${WORKDIR}/init-debug.sh
        sed -i "31a udevd -d" ${WORKDIR}/init-debug.sh
        sed -i "32a udevadm trigger --action=add --subsystem-match=block" ${WORKDIR}/init-debug.sh
        sed -i "33a udevadm settle" ${WORKDIR}/init-debug.sh

        # Execute OTA update
        sed -i "34a boot_times" ${WORKDIR}/init-debug.sh
        sed -i "35a /tools/adv-ota.sh 2>&1 | tee /cache/recovery/log" ${WORKDIR}/init-debug.sh

        install -m 0755 ${WORKDIR}/init-debug.sh ${D}/init
}
