SUMMARY = "The default built-in resolution-EDID binaries in Linux kernel"
HOMEPAGE = "https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/EDID/HOWTO.txt"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = " \
          file://1024x768.bin \
          file://1280x1024.bin \
          file://1600x1200.bin \
          file://1680x1050.bin \
          file://1920x1080.bin \
          file://800x600.bin \
          "

do_install() {
    install -d ${D}${libdir}/firmware/edid
    install -m 644 ${WORKDIR}/1024x768.bin ${D}${libdir}/firmware/edid/1024x768.bin
    install -m 644 ${WORKDIR}/1280x1024.bin ${D}${libdir}/firmware/edid/1280x1024.bin
    install -m 644 ${WORKDIR}/1600x1200.bin ${D}${libdir}/firmware/edid/1600x1200.bin
    install -m 644 ${WORKDIR}/1680x1050.bin ${D}${libdir}/firmware/edid/1680x1050.bin
    install -m 644 ${WORKDIR}/1920x1080.bin ${D}${libdir}/firmware/edid/1920x1080.bin
    install -m 644 ${WORKDIR}/800x600.bin ${D}${libdir}/firmware/edid/800x600.bin
}

FILES_${PN} = "/usr/lib/firmware/edid"
