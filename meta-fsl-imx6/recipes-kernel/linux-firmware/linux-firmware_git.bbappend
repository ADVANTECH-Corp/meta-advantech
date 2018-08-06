PACKAGES =+ "${PN}-rtl8188ee \
	     ${PN}-sd8897 \
	     ${PN}-rtl8821ae \
	     "

LICENSE_${PN}-rtl8188ee = "Firmware-rtlwifi"
FILES_${PN}-rtl8188ee = " \
  /lib/firmware/rtlwifi/rtl8188efw.bin \
"
RDEPENDS_${PN}-rtl8188ee += "${PN}-rtl-license"

LICENSE_${PN}-sd8897 = "Firmware-Marvell"
FILES_${PN}-sd8897 = " \
  /lib/firmware/mrvl/sd8897_uapsta.bin \
  /lib/firmware/mrvl/pcie8897_uapsta.bin \
"
RDEPENDS_${PN}-sd8897 += "${PN}-marvell-license"

LICENSE_${PN}-rtl8821ae = "Firmware-rtlwifi"
FILES_${PN}-rtl8821ae = " \
  /lib/firmware/rtl_bt/rtl8821a_fw.bin \
"
RDEPENDS_${PN}-rtl8821ae += "${PN}-rtl-license"

