SUMMARY = "Open source MQTT v3.1/v3.1.1 implemention"
DESCRIPTION = "Mosquitto is an open source (BSD licensed) message broker that implements the MQ Telemetry Transport protocol version 3.1 and 3.1.1. MQTT provides a lightweight method of carrying out messaging using a publish/subscribe model. "
HOMEPAGE = "http://mosquitto.org/"
SECTION = "console/network"
DEPENDS = "openssl c-ares"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=89aa5ea5f32e4260d84c5d185ee3add4"

PR = "r0"

inherit autotools-brokensep update-rc.d

INHIBIT_PACKAGE_STRIP = "1"

CFLAGS += "-L${STAGING_LIBDIR}"

SRC_URI = "http://mosquitto.org/files/source/${BPN}-${PV}.tar.gz"
SRC_URI += "file://disable-memory-tracking.patch \
           file://reconfig-install-prefix-to-usr.patch \
           file://reconfig-install-option-to-unstrip.patch \
           file://mqtt \
           file://conf.d"

SRC_URI[md5sum] = "55094ad4dc7c7985377f43d4fc3d09da"
SRC_URI[sha256sum] = "16eb3dbef183827665feee9288362c7352cd016ba04ca0402a0ccf857d1c2ab2"

INITSCRIPT_NAME = "mqtt"

INITSCRIPT_PARAMS = "start 86 3 5 . stop 86 0 1 6 ."
#INITSCRIPT_PARAMS = ""

FILES_${PN} += "${libdir}/python2.7/*"

do_install_append() {
    install -d -m 0755 ${D}${sysconfdir}/init.d
	install -d -m 0755 ${D}${sysconfdir}/mosquitto/
    install -m 0755 ${WORKDIR}/mqtt ${D}${sysconfdir}/init.d/
    install -m 0755 ${WORKDIR}/conf.d ${D}${sysconfdir}/mosquitto/

    mv ${D}/usr/lib ${D}/usr/${baselib} || true
}

