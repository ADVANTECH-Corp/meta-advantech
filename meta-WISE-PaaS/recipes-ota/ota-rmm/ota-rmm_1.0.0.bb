# Copyright (C) 2015 2016 Advantech

DESCRIPTION = "Advantech RMM"
SECTION = "libs"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD;md5=3775480a712fc46a69647678acb234cb"
PR = "r0"

SRC_URI_mx6 = "file://otaagent-Poky_2.1.1-imx6-3.0.9.14.run.tar.gz"
SRC_URI_mx6[md5sum] = "7b0676a854827b8718ede2ab79e960bc"
SRC_URI_dragonboard-410c = "file://otaagent-Poky_2.1.3-apq8016-3.0.9.14.run.tar.gz"
SRC_URI_dragonboard-410c[md5sum] = "f503028499967c6020cd2f9521b5a2d2"
SRC_URI_arago = "file://otaagent-TI_yocto_2016.08-2.0.0-am57xx-3.0.9.13.run.tar.gz"
SRC_URI_arago[md5sum] = "5e9eb7b38d0012912b60bc2f8520098b"

S = "${WORKDIR}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
INSANE_SKIP_${PN} += "dev-so libdir"

DEPENDS = "avahi openssl libxext curl libxml2 libx11 jpeg libxrandr zlib \
           sqlite3 libxtst libxinerama libxdamage libxfixes mosquitto \
           libmodbus"
RDEPENDS_${PN} = "bash"

inherit autotools pkgconfig

do_install() {
	sh ${S}/otaagent-*.run --noexec --target rmm
	install -d ${D}/usr/local
	install -d ${D}/etc/init.d
	install -m 755 ${S}/build/rmm/OTA-Agent/services/otaagent ${D}/etc/init.d
	install -m 755 ${S}/build/rmm/OTA-Agent/services/otawatchdog ${D}/etc/init.d
	cp -axr ${S}/build/rmm/OTA-Agent ${D}/usr/local
	sed -i "s/127.0.0.1/wise-ota.eastasia.cloudapp.azure.com/g" ${D}/usr/local/OTA-Agent/agent_config.xml
}


FILES_SOLIBSDEV = ""

# Avoid do_rootfs error "Can't install rmm: no package provides xxx.so"
RPROVIDES_${PN} = "libsueClient.so libsueClientCore.so libfileTransfer.so libminiUnzip.so libsaClient.so libsaConfig.so libsaGatherInfo.so libsaGeneralHandler.so libmqttHelper.so"

# List the files for Package
FILES_${PN} = "/usr/local/OTA-Agent /etc"

