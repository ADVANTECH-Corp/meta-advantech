FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SYSROOT_PREPROCESS_FUNCS += "inetutils_sysroot_preprocess"

inetutils_sysroot_preprocess() {
    install -m 0755 -d ${SYSROOT_DESTDIR}${base_bindir}
    install -m 0755 -d ${SYSROOT_DESTDIR}${base_sbindir}
    install -m 0755 -d ${SYSROOT_DESTDIR}${sbindir}
    install -m 0755 -d ${SYSROOT_DESTDIR}${sysconfdir}/xinetd.d
    cp -a ${D}/*  ${SYSROOT_DESTDIR}/
}