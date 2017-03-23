SUMMARY     = "Lua is a powerful, light-weight programming language designed for extending applications"
DESCRIPTION = "Lua is implemented in pure ANSI C, and compiles unmodified in all known platforms that have an ANSI C compiler"

LICENSE = "MIT"
PR = "r0"
DEPENDS = "readline"
inherit autotools-brokensep

SRC_URI = "http://www.lua.org/ftp/${PN}-${PV}.tar.gz"
SRC_URI[md5sum] = "efbb645e897eae37cad4344ce8b0a614"
SRC_URI[sha256sum] = "3fd67de3f5ed133bf312906082fa524545c6b9e1b952e8215ffbd27113f49f00"

LIC_FILES_CHKSUM = "file://doc/readme.html;md5=6ea43b5287c2c4d9d0988806a3e0f809"

EXTRA_OEMAKE = 'CC="${CC}" \
    LDFLAGS="${LDFLAGS}" \
    EXTRA="${CFLAGS}"'

do_compile () {
        oe_runmake linux
}

do_install () {
	oe_runmake \
	        'INSTALL_TOP=${D}${prefix}' \
                'INSTALL_BIN=${D}${bindir}' \
                'INSTALL_INC=${D}${includedir}/' \
                'INSTALL_MAN=${D}${mandir}/man1' \
                'INSTALL_SHARE=${D}${datadir}/lua' \
                install

}

