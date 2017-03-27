# PACKAGE_EXCLUDE += "bluez4"
DISTRO_FEATURES_append = " bluez5"
PREFERRED_PROVIDER_bluez-hcidump = "bluez5"
PNBLACKLIST[bluez-hcidump] = "superseded by bluez5"
PNBLACKLIST[gst-plugin-bluetooth] = "dropped from bluez5"
PNBLACKLIST[bluez4] = "superseded by bluez5"


IMAGE_INSTALL += "iperf memtester "
IMAGE_INSTALL += "linux-firmware-ar3k "
IMAGE_INSTALL += "linux-firmware-rtl8188ee "
# IMAGE_INSTALL += "bluez5 bluez5-obex bluez5-testtools "
IMAGE_INSTALL += "bluez5-obex bluez5-testtools "
IMAGE_INSTALL += "expect "

ROOTFS_POSTPROCESS_COMMAND += "disable_network_namepolicy ;"
ROOTFS_POSTPROCESS_COMMAND += "install_rclocal ;"
ROOTFS_POSTPROCESS_COMMAND += "install_utils ;"
# ROOTFS_POSTPROCESS_COMMAND += "install_unblock ;"
ROOTFS_POSTPROCESS_COMMAND += "install_connman_config ;"
ROOTFS_POSTPROCESS_COMMAND += "update_profile ;"

MULTILIBS = ""

ADDON_FILES_DIR:="${THISDIR}/files"

disable_network_namepolicy() {
  sed -i "s/NamePolicy=.*/# NamePolicy=/" ${IMAGE_ROOTFS}/lib/systemd/network/99-default.link
}

install_rclocal() {
    install -m 0755 ${ADDON_FILES_DIR}/rc.local ${IMAGE_ROOTFS}/etc
}

install_utils() {
    install -m 0755 ${ADDON_FILES_DIR}/wifi_connect.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_pair.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_send.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_obexd_start.sh ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/bt_obexd_stop.sh ${IMAGE_ROOTFS}/usr/local/bin
}

install_unblock() {
    install -d ${IMAGE_ROOTFS}/etc/systemd/system
    install -m 0644 ${ADDON_FILES_DIR}/rfkill-unblock.service ${IMAGE_ROOTFS}/etc/systemd/system
    ln -sf ../rfkill-unblock.service ${IMAGE_ROOTFS}/etc/systemd/system/multi-user.target.wants/rfkill-unblock.service
}

install_connman_config() {
    install -d ${IMAGE_ROOTFS}/etc/connman
    install -d ${IMAGE_ROOTFS}/var/lib/connman
    install -m 0644 ${ADDON_FILES_DIR}/main.conf ${IMAGE_ROOTFS}/etc/connman
    install -m 0644 ${ADDON_FILES_DIR}/settings  ${IMAGE_ROOTFS}/var/lib/connman
}

update_profile() {
sed -i "s/# \"\\\e\[1~\"/\"\\\e\[1~\"/" ${IMAGE_ROOTFS}/etc/inputrc
sed -i "s/# \"\\\e\[4~\"/\"\\\e\[4~\"/" ${IMAGE_ROOTFS}/etc/inputrc
sed -i "s/# \"\\\e\[3~\"/\"\\\e\[3~\"/" ${IMAGE_ROOTFS}/etc/inputrc
sed -i "s/# \"\\\e\[5~\"\: history/\"\\\e\[A\": history/" ${IMAGE_ROOTFS}/etc/inputrc
sed -i "s/# \"\\\e\[6~\"\: history/\"\\\e\[B\": history/" ${IMAGE_ROOTFS}/etc/inputrc

cat >> ${IMAGE_ROOTFS}/etc/profile << EOF
alias ls='/bin/ls --color=auto'
alias ll='ls -l'
alias la='ls -al'
alias l=ll
EOF
}

#Install for building RMM
TOOLCHAIN_TARGET_TASK += "\
   curl curl-dev \
   mosquitto mosquitto-dev \
   c-ares \
   "
