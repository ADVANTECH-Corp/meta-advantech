DESCRIPTION = "stress-ng will stress test a computer system in various selectable ways. It \
was designed to exercise various physical subsystems of a computer as well as the various \
operating system kernel interfaces."
HOMEPAGE = "http://kernel.ubuntu.com/~cking/stress-ng/"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "https://github.com/ColinIanKing/stress-ng/archive/V${PV}.tar.gz"

SRC_URI[md5sum] = "9c97161fb4382afe99fa33f59b148816"
SRC_URI[sha256sum] = "80cf7eb4316b4c0449e432300d07ab9780c4dc145846038edc34e59bb4404782"

CFLAGS += "-Wall -Wextra -DVERSION='"$(VERSION)"' -O2"

do_install() {
	oe_runmake DESTDIR=${D} install
}

DEPENDS = "libaio"
RDEPENDS_${PN} = "zlib"
