
do_install() {
        install -d  ${D}/lib/firmware/
        cp -r * ${D}/lib/firmware/

        # Avoid Makefile to be deployed
        rm ${D}/lib/firmware/Makefile

        # Remove unbuild firmware which needs cmake and bash
        rm ${D}/lib/firmware/carl9170fw -rf

        # Remove pointless bash script
        rm ${D}/lib/firmware/configure

        # Libertas sd8686
        ln -sf libertas/sd8686_v9.bin ${D}/lib/firmware/sd8686.bin
        ln -sf libertas/sd8686_v9_helper.bin ${D}/lib/firmware/sd8686_helper.bin

        # fixup wl12xx location, after 2.6.37 the kernel searches a different location for it
        ( cd ${D}/lib/firmware ; ln -sf ti-connectivity/* . )
	rm ${D}/lib/firmware/ti-connectivity/ -rf
}


PACKAGES =+ "${PN}-sd8897 \
            "

LICENSE_${PN}-sd8897 = "Firmware-Marvell"
FILES_${PN}-sd8897 = " \
  /lib/firmware/mrvl/sd8897_uapsta.bin \
"
RDEPENDS_${PN}-sd8897 += "${PN}-marvell-license"


