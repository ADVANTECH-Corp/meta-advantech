# Copyright (C) 2015 2016 Advantech

DESCRIPTION = "Advantech RMM"
SECTION = "libs"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD;md5=3775480a712fc46a69647678acb234cb"
PR = "r0"

SRC_URI_mx6 = "file://otaagent-Poky-4.1.15-armv7l-3.0.7.359.run.tar.gz"
SRC_URI_mx6[md5sum] = "649d6ccf6fcc0c0ea12c3439e4015b22"
SRC_URI_dragonboard-410c = "file://otaagent-Poky-2.1-aarch64-3.0.9.423.run.tar.gz"
SRC_URI_dragonboard-410c[md5sum] = "84c2924eb633f1cf64f058e0867863f1"

S = "${WORKDIR}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
FILES_SOLIBSDEV = ""
INSANE_SKIP_${PN} += "dev-so libdir file-rdeps"

DEPENDS = "avahi openssl libxext curl libxml2 libx11 jpeg libxrandr zlib \
           sqlite3 libxtst libxinerama libxdamage libxfixes mosquitto \
           libmodbus"

inherit autotools pkgconfig

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
	sh ${S}/otaagent-*.run --noexec --target rmm
	install -d ${D}/usr/local
	install -d ${D}/etc/init.d
	install -m 755 ${S}/build/rmm/OTA-Agent/services/otaagent ${D}/etc/init.d
	install -m 755 ${S}/build/rmm/OTA-Agent/services/otawatchdog ${D}/etc/init.d
	cp -axr ${S}/build/rmm/OTA-Agent ${D}/usr/local
	sed -i "s/127.0.0.1/wise-ota.eastasia.cloudapp.azure.com/g" ${D}/usr/local/OTA-Agent/agent_config.xml

	# rpm doesn't set the correct arch for symlinks.
	# For this reason we have to use hardlinks vs symlinks.
	cd ${D}/usr/local/OTA-Agent
	ln -f libfileTransfer.so.1.0.13.106 libfileTransfer.so
	ln -f libminiUnzip.so.1.0.13.106 libminiUnzip.so
	ln -f libmqtthelper.so.3.0.9.423 libmqtthelper.so
	ln -f libSAClient.so.3.0.9.423 libSAClient.so
	ln -f libSAConfig.so.3.0.9.423 libSAConfig.so
	ln -f libSAGatherInfo.so.3.0.9.423 libSAGatherInfo.so
	ln -f libSAGeneralHandler.so.3.0.9.423 libSAGeneralHandler.so
	ln -f libSAHandlerLoader.so.3.0.9.423 libSAHandlerLoader.so
	ln -f libSAManager.so.3.0.9.423 libSAManager.so
	ln -f libsueClientCore.so.1.0.13.106 libsueClientCore.so
	ln -f libsueClient.so.1.0.13.106 libsueClient.so
}

# List the files for Package
FILES_${PN} = "/usr/local/OTA-Agent /etc"

