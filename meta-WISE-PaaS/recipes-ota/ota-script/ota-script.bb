SUMMARY = "Shell scripts for OTA update"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://do_update.sh \
		 file://do_update_mbed.sh \
	   file://ota-package.sh"

TOOLS = "do_update"
TOOLS_class-native = "ota-package"
TOOLS_class-nativesdk = "ota-package"

do_install() {
    mkdir -p ${D}/tools
    install -d ${D}/tools

    if echo ${TOOLS} | grep -q "do_update" ; then
        install -m 755 ${WORKDIR}/do_update.sh ${D}/tools/
        install -m 755 ${WORKDIR}/do_update_mbed.sh ${D}/tools/
    fi
    if echo ${TOOLS} | grep -q "ota-package" ; then
        install -m 755 ${WORKDIR}/ota-package.sh ${D}/tools/
    fi
}

RDEPENDS_${PN} += "bash"
FILES_${PN} = "/tools"

BBCLASSEXTEND = "native nativesdk"
