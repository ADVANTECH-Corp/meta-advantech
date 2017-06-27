# Copyright (C) 2015 2016 Advantech

DESCRIPTION = "Advantech RMM"
SECTION = "libs"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD;md5=3775480a712fc46a69647678acb234cb"
PR = "r0"

SRC_URI_mx6 = "file://rmm.run.tar.gz"
SRC_URI_mx6[md5sum] = "649d6ccf6fcc0c0ea12c3439e4015b22"

S = "${WORKDIR}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
INSANE_SKIP_${PN} += "dev-so libdir"

DEPENDS = "avahi openssl libxext curl libxml2 libx11 jpeg libxrandr zlib \
           sqlite3 libxtst libxinerama libxdamage libxfixes mosquitto \
           libmodbus"

inherit autotools pkgconfig

do_install() {
	sh ${S}/otaagent-Poky\ \(Yocto\ Project\ Reference\ Distro\)\ 4.1.15\ armv7l-3.0.6.247.run --noexec --target rmm
	install -d ${D}/usr/local
	install -d ${D}/etc/init.d
	cp -axr ${S}/build/rmm/saagent ${D}/etc/init.d
	cp -axr ${S}/build/rmm/AgentService ${D}/usr/local
	sed -i "s/127.0.0.1/wise-ota.eastasia.cloudapp.azure.com/g" ${D}/usr/local/AgentService/agent_config.xml
}


FILES_SOLIBSDEV = ""

# Avoid do_rootfs error "Can't install rmm: no package provides xxx.so"
RPROVIDES_${PN} = "libsueClient.so libsueClientCore.so libfileTransfer.so libminiUnzip.so libSAClient.so libSAConfig.so libSAGatherInfo.so libSAGeneralHandler.so libmqtthelper.so"

# List the files for Package
FILES_${PN} = "/usr/local/AgentService /etc"

