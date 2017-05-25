YOCTO_VERSION = "Yocto 2.1 (krogoth)"

BASEFILESISSUEINSTALL = "do_install_basefilesissue_yocto"

do_install_basefilesissue_yocto () {
        if [ "${hostname}" ]; then
                echo ${hostname} > ${D}${sysconfdir}/hostname
        fi

        install -m 644 ${WORKDIR}/issue*  ${D}${sysconfdir}
        if [ -n "${DISTRO_NAME}" ]; then
                printf "${DISTRO_NAME} " >> ${D}${sysconfdir}/issue
                printf "${DISTRO_NAME} " >> ${D}${sysconfdir}/issue.net
                if [ -n "${DISTRO_VERSION}" ]; then
                        printf "${DISTRO_VERSION} " >> ${D}${sysconfdir}/issue
                        printf "${DISTRO_VERSION} " >> ${D}${sysconfdir}/issue.net
                fi
                # [Advantech] Add Yocto version for OTA client
                if [ -n "${YOCTO_VERSION}" ]; then
                        printf "${YOCTO_VERSION} " >> ${D}${sysconfdir}/issue
                        printf "${YOCTO_VERSION} " >> ${D}${sysconfdir}/issue.net
                fi
                printf "\\\n \\\l\n" >> ${D}${sysconfdir}/issue
                echo >> ${D}${sysconfdir}/issue
                echo "%h"    >> ${D}${sysconfdir}/issue.net
                echo >> ${D}${sysconfdir}/issue.net
        fi
}
