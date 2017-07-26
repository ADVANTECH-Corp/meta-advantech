# Copyright (C) 2017 Advantech
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://WCNSS_qcom_wlan_nv.bin"

# Overwrite WiFi calibration file
do_install_append() {
    cp ${WORKDIR}/WCNSS_qcom_wlan_nv.bin ${D}/lib/firmware/wlan/prima/
}
