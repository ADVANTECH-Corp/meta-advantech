DESCRIPTION = "A Node-RED node that allows you to send messages and register devices with Azure IoT Hub"
HOMEPAGE = "https://www.npmjs.com/package/node-red-contrib-azure-iot-hub"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2ee41112a44fe7014dce33e26468ba93"

SRC_URI = "git://github.com/lcarli/NodeRedIoTHub.git;branch=master"
SRCREV = "89aee4b0d9c418a022a85fb3713481659d1cefa5"

S = "${WORKDIR}/git"

# Fix "no package provides /usr/local/bin/node-bench" issue
SRC_URI += "file://node-bench"

do_install_append() {
    install -d ${D}/usr/local/bin
    install -m 755 ${WORKDIR}/node-bench ${D}/usr/local/bin
}

FILES_${PN} = "/usr/local/bin"


inherit npm-install-global

do_configure() {
	:
}

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

RDEPENDS_${PN} += " node-red"
