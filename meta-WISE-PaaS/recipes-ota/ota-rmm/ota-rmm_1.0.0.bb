# Copyright (C) 2015 2016 Advantech

DESCRIPTION = "Advantech RMM"
SECTION = "libs"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/BSD;md5=3775480a712fc46a69647678acb234cb"
PR = "r0"

SRC_URI_quark = "file://otaagent-Poky_1.7.2-quark-3.0.9.14.run.tar.gz"
SRC_URI_quark[md5sum] = "53a169e86cf9aafa769ecf72117148a3"

S = "${WORKDIR}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
INSANE_SKIP_${PN} += "dev-so libdir"

DEPENDS = "avahi openssl libxext curl libxml2 libx11 jpeg libxrandr zlib \
           sqlite3 libxtst libxinerama libxdamage libxfixes mosquitto \
           libmodbus"
RDEPENDS_${PN} += "bash"

inherit autotools pkgconfig

do_install() {
	sh ${S}/otaagent-*.run --noexec --target rmm
	install -d ${D}/usr/local
	install -d ${D}/etc/init.d
	install -m 755 ${S}/build/rmm/OTA-Agent/services/otaagent ${D}/etc/init.d
	install -m 755 ${S}/build/rmm/OTA-Agent/services/otawatchdog ${D}/etc/init.d
    for R in 2 3 4 5; do
        mkdir -p ${D}/etc/rc${R}.d/
        ln -sf ../init.d/otaagent ${D}/etc/rc${R}.d/S99otaagent
        ln -sf ../init.d/otawatchdog ${D}/etc/rc${R}.d/S99otawatchdog
	done
    for R in 0 1 6; do
        mkdir -p ${D}/etc/rc${R}.d/
        ln -sf ../init.d/otaagent ${D}/etc/rc${R}.d/K20otaagent
        ln -sf ../init.d/otawatchdog ${D}/etc/rc${R}.d/K20otawatchdog
	done
	cp -axr ${S}/build/rmm/OTA-Agent ${D}/usr/local
	sed -i "s/127.0.0.1/wise-ota.eastasia.cloudapp.azure.com/g" ${D}/usr/local/OTA-Agent/agent_config.xml
}


FILES_SOLIBSDEV = ""

# Avoid do_rootfs error "Can't install rmm: no package provides xxx.so"
RPROVIDES_${PN} = "libsueClient.so libsueClientCore.so libfileTransfer.so libminiUnzip.so libsaClient.so libsaConfig.so libsaGatherInfo.so libsaGeneralHandler.so libmqttHelper.so"

# List the files for Package
FILES_${PN} = "/usr/local/OTA-Agent /etc"

