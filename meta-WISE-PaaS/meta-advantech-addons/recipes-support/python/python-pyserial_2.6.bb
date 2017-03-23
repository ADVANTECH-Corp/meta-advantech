DESCRIPTION = "Serial Port Support for Python"
SECTION = "devel/python"
LICENSE = "PSF"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=d88c706961680d5d232a4ae0879b1714"
SRCNAME = "pyserial"
PR = "ml4"

SRC_URI = "https://pypi.python.org/packages/source/p/${SRCNAME}/${SRCNAME}-${PV}.tar.gz"
S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit distutils

# FIXME might stop packaging serialwin32 and serialjava files

RDEPENDS_${PN} = "\
    python-fcntl \
    python-io \
    python-stringold \
"

SRC_URI[md5sum] = "cde799970b7c1ce1f7d6e9ceebe64c98"
SRC_URI[sha256sum] = "049dbcda0cd475d3be903e721d60889ee2cc4ec3b62892a81ecef144196413ed"
