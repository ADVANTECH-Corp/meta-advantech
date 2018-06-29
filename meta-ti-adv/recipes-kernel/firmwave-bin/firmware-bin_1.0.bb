# Copyright (C) 2017 Advantech
DESCRIPTION = "Advantech Firmware"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://EWM-W170H01E.tgz"
SRC_URI[md5sum] = "f72305e1634a2412747af82300eae3ad"

# Overwrite WiFi calibration file
PACKAGES =+ "${PN}-ewm"
FILES_${PN} += "/lib/firmware/*"

do_install() {
    install -d ${D}/lib/firmware/
    install -d ${D}/lib/firmware/wlan
    cp -r ${WORKDIR}/firmware_bin/* ${D}/lib/firmware/
}

