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
IMAGE_INSTALL_append = " inetutils inetutils-telnet inetutils-telnetd "
IMAGE_INSTALL_append = " gimp libevent sudo "

# X resource database manager
IMAGE_INSTALL_append = " xrdb "

# Native Compiler
IMAGE_INSTALL_append = " packagegroup-sdk-target "

# ADB service
IMAGE_INSTALL_append = " android-tools "

# Kernel Modules
IMAGE_INSTALL_append = " gobinet gobiserial "

# Bluetooth power adjustment
IMAGE_INSTALL_append = " wcnss-bt-pout-config "

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
