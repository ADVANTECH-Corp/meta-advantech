ROOTFS_POSTPROCESS_COMMAND += "install_ota ;"
ROOTFS_POSTPROCESS_COMMAND += "install_rclocal ;"
ROOTFS_POSTPROCESS_COMMAND += "update_profile ;"

MULTILIBS = ""

ADDON_FILES_DIR:="${THISDIR}/files-spi"

install_ota() {
    mkdir -p ${IMAGE_ROOTFS}/usr/local/bin
    install -m 0755 ${ADDON_FILES_DIR}/adv-ota.sh ${IMAGE_ROOTFS}/usr/local/bin
}

install_rclocal() {
    sed -i "/l5/ a X5:5:wait:/etc/init.d/rc.local" ${IMAGE_ROOTFS}/etc/inittab
    install -m 0755 ${ADDON_FILES_DIR}/rc.local ${IMAGE_ROOTFS}/etc/init.d
    ln -s init.d/rc.local ${IMAGE_ROOTFS}/etc/rc.local
}

update_profile() {
cat >> ${IMAGE_ROOTFS}/etc/profile << EOF
alias ls='/bin/ls --color=auto'
alias ll='ls -l'
alias la='ls -al'
alias l=ll
EOF
}
