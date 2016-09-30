PACKAGES =+ "${PN}-rtl8188ee \
	     ${PN}-sd8897 \
	     "

LICENSE_${PN}-rtl8188ee = "Firmware-rtlwifi"
FILES_${PN}-rtl8188ee = " \
  /lib/firmware/rtlwifi/rtl8188efw.bin \
"
RDEPENDS_${PN}-rtl8188ee += "${PN}-rtl-license"

LICENSE_${PN}-sd8897 = "Firmware-Marvell"
FILES_${PN}-sd8897 = " \
  /lib/firmware/mrvl/sd8897_uapsta.bin \
"
RDEPENDS_${PN}-sd8897 += "${PN}-marvell-license"

