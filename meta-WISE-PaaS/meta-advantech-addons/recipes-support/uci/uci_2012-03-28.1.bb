SUMMARY = "UCI is the successor of the nvram based configuration \
found in the White Russian series of OpenWrt."
DESCRIPTION = "\
The abbreviation UCI stands for Unified Configuration \
Interface and is intended to centralize the whole \
configuration of your project. Configuring should be easy, \
more straight forward."
HOMEPAGE = "http://wiki.openwrt.org/doc/uci"
SECTION = "console/utils"
LICENSE = "GPLv2 & LGPLv2.1+"
LIC_FILES_CHKSUM = "file://cli.c;beginline=3;endline=12;md5=61ac10aebfcddf1cf7371220687237d3 \
                    file://delta.c;beginline=3;endline=12;md5=c7e4171d506df594d5b9d080e356308d \
                    file://sh/uci.sh;beginline=2;endline=3;md5=e46ee36d30bc35775d45e04b783dd11f \
                    file://ucimap.c;beginline=3;endline=12;md5=125da5ab3833a1b42e517efefa61d75a"

SRC_URI += "http://mirror2.openwrt.org/sources/${BPN}-${PV}.tar.gz \
            file://uci-extended-to-apply-service.patch \
            file://uci.sh \
            file://confrouter \
            file://ucisa.conf"

SRC_URI[md5sum] = "0ee76d8f79cf99f5539fd090a4e65646"
SRC_URI[sha256sum] = "6fc7e41ebd6a7836998bd06ee29fc654cb45bb629f686817f6ebd3b46b21a061"

PR = "r2"
inherit cmake 

EXTRA_OECMAKE="-DCMAKE_SKIP_RPATH:BOOL=YES \
                -DBUILD_LUA=OFF"

B = "${S}"

do_install() {
    install -d -m 0755 ${D}/${base_sbindir}
    install -d -m 0755 ${D}/${libdir}
    install -d -m 0755 ${D}/${includedir}
    install -d -m 0755 ${D}/${base_libdir}/config
    install -d -m 0755 ${D}/lib/config
    install -d -m 0755 ${D}/${sysconfdir}/uci-defaults
    install -d -m 0755 ${D}/${sysconfdir}/ucisa

    install -m 0755 ${S}/uci ${D}/${base_sbindir}
    install -m 0755 ${S}/libuci.so ${D}/${base_libdir}
    install -m 0644 ${S}/uci*.h ${D}/${includedir}
    install -m 0755 ${S}/libuci.a ${D}/${libdir}
    install -m 0755 ${S}/libucimap.a ${D}/${libdir}
    install -m 0755 ${WORKDIR}/uci.sh ${D}/${base_libdir}/config
    install -m 0755 ${WORKDIR}/uci.sh ${D}/lib/config
    install -m 0755 ${WORKDIR}/confrouter ${D}/${sysconfdir}/ucisa
    install -m 0644 ${WORKDIR}/ucisa.conf ${D}/${sysconfdir}/ucisa
}

FILES_${PN}="${base_sbindir}/uci \
${base_libdir}/libuci.so \
${base_libdir}/config/uci.sh \
${sysconfdir}/ucisa/* \
${sysconfdir}/uci-defaults \
/lib/config/*"

FILES_${PN}-dev="${includedir}/*"

FILES_${PN}-staticdev="${libdir}/*.a"
