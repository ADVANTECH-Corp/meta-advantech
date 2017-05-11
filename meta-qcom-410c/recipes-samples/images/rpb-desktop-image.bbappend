# Remove Network Manager
IMAGE_INSTALL_remove = " networkmanager networkmanager-nmtui "

# Scripts
IMAGE_INSTALL_append = " stress-script thermal-script audio-script mac-script "
IMAGE_INSTALL_append = " boottimes-script emi-script 3g-script quectel-script "

# Tool for kernel parameters
IMAGE_INSTALL_append = " abootimg "

# Tools for function verification
IMAGE_INSTALL_append = " stress stress-ng devmem2 fbv i2c-tools ethtool evtest "
IMAGE_INSTALL_append = " minicom st boottimes alsa-utils fbida iperf memtester ppp "
IMAGE_INSTALL_append = " netkit-ftp glmark2 ntpdate v4l-utils mtd-utils expect "
IMAGE_INSTALL_append = " packagegroup-tools-bluetooth "

# Misc
# - X resource database manager
IMAGE_INSTALL_append = " xrdb "

# Native Compiler
IMAGE_INSTALL_append = " packagegroup-sdk-target "

#RMM & SUSI_4.0
IMAGE_INSTALL_append = "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target "

IMAGE_INSTALL_append = "\
   susi4 "
#   rmm susi-iot "

#Install for building RMM
TOOLCHAIN_TARGET_TASK += "\
   curl curl-dev \
   mosquitto mosquitto-dev \
   c-ares \
   "

# Bluetooth OBEX test script
ADDON_FILES_DIR:="${THISDIR}/files"

install_utils() {
    mkdir -p ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_pair.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_send.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_obexd_start.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_obexd_stop.sh ${IMAGE_ROOTFS}/usr/local/bin
}

ROOTFS_POSTPROCESS_COMMAND += "install_utils;"
