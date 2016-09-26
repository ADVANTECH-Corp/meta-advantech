DESCRIPTION = "stress-ng will stress test a computer system in various selectable ways. It \
was designed to exercise various physical subsystems of a computer as well as the various \
operating system kernel interfaces."
HOMEPAGE = "http://kernel.ubuntu.com/~cking/stress-ng/"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "http://kernel.ubuntu.com/~cking/tarballs/${BPN}/${BP}.tar.gz"

SRC_URI[md5sum] = "eb31a148f14a8b92c6067e575a57ae3b"
SRC_URI[sha256sum] = "0e1d7733b35f594f7461dedbf836bd4966d0611da4cd4e85cde4804d2a425e6d"

CFLAGS += "-Wall -Wextra -DVERSION='"$(VERSION)"' -O2"

do_install() {
	oe_runmake DESTDIR=${D} install
}
