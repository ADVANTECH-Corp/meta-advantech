# Copyright (C) 2017-2018 NXP

SUMMARY = "OPTEE Client libs"
HOMEPAGE = "http://www.optee.org/"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=69663ab153298557a59c67a60a743e5b"

inherit pythonnative systemd

SRCBRANCH = "imx_4.9.88_2.0.0_ga"
OPTEE_CLIENT_SRC ?= "git://source.codeaurora.org/external/imx/imx-optee-client.git;protocol=https"
SRC_URI = "${OPTEE_CLIENT_SRC};branch=${SRCBRANCH}"
SRCREV = "09b69afa5e9e74aac39e383d74f14b4d61c90476"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI_append = " file://tee-supplicant.service"

S = "${WORKDIR}/git"
SYSTEMD_SERVICE_${PN} = "tee-supplicant.service"

do_compile () {
    if [ ${DEFAULTTUNE} = "aarch64" ]; then
        oe_runmake -C ${S} ARCH=arm64
    else
        oe_runmake -C ${S} ARCH=arm
    fi
}

do_install () {
	oe_runmake install

	install -D -p -m0644 ${S}/out/export/lib/libteec.so.1.0 ${D}${libdir}/libteec.so.1.0
	ln -sf libteec.so.1.0 ${D}${libdir}/libteec.so
	ln -sf libteec.so.1.0 ${D}${libdir}/libteec.so.1

	install -D -p -m0755 ${S}/out/export/bin/tee-supplicant ${D}${bindir}/tee-supplicant

	cp -a ${S}/out/export/include ${D}/usr/

	sed -i -e s:/etc:${sysconfdir}:g -e s:/usr/bin:${bindir}:g ${WORKDIR}/tee-supplicant.service
	install -D -p -m0644 ${WORKDIR}/tee-supplicant.service ${D}${systemd_system_unitdir}/tee-supplicant.service
}

PACKAGES += "tee-supplicant"
FILES_${PN} += "${libdir}/* ${includedir}/*"
FILES_tee-supplicant += "${bindir}/tee-supplicant"

INSANE_SKIP_${PN} = "ldflags dev-elf"
INSANE_SKIP_${PN}-dev = "ldflags dev-elf"
INSANE_SKIP_tee-supplicant = "ldflags"
