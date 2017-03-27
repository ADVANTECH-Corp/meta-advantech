DESCRIPTION = "Multi-producer-multi-consumer signal dispatching mechanism Support for Python"
SECTION = "devel/python"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://license.txt;md5=09dffabd4d29ee02f66b0b7f808d57c2"
SRCNAME = "PyDispatcher"
PR = "r0"

SRC_URI = "https://pypi.python.org/packages/source/P/${SRCNAME}/${SRCNAME}-${PV}.tar.gz"
S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit setuptools

SRC_URI[md5sum] = "d31581da170810315fc2539e967ad8cf"
SRC_URI[sha256sum] = "735b1f7cba2123fbb60530c178c54b43f774b88cefa2689a8b6dcc476f2ba03f"
