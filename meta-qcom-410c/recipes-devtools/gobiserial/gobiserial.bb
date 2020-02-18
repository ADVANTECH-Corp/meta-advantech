RY = "Driver for GOBISERIAL 2.30"
HOMEPAGE = "http://www.sierra.com"
PR = "r1"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
LICENSE = "GPLv2"

inherit module deploy

SRC_URI = "file://gobiserial.tgz"
SRCPV = "S2.31N2.50"
PV = "${SRCPV}"

S = "${WORKDIR}/gobiserial/"

EXTRA_OEMAKE += "KDIR='${STAGING_KERNEL_DIR}' OUTPUTDIR='${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers/usb/serial/'"
MAKE_TARGETS = "all"
MODULES_INSTALL_TARGET = "install"

# Generate modules tarball file
addtask do_deploy before do_packagedata after do_populate_sysroot

MODULE_IMAGE_BASE_NAME ?= "modules-${PN}-${PKGV}-${PKGR}-${MACHINE}-${DATETIME}"
MODULE_IMAGE_BASE_NAME[vardepsexclude] = "DATETIME"
MODULE_TARBALL_BASE_NAME ?= "${MODULE_IMAGE_BASE_NAME}.tgz"
MODULE_TARBALL_SYMLINK_NAME ?= "modules-${PN}-${MACHINE}.tgz"

do_deploy() {
    tar -cvzf ${DEPLOYDIR}/${MODULE_TARBALL_BASE_NAME} -C ${D} lib
    ln -sf ${MODULE_TARBALL_BASE_NAME} ${DEPLOYDIR}/${MODULE_TARBALL_SYMLINK_NAME}
}
