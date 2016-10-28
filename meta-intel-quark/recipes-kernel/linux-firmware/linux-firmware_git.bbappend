PACKAGES =+ "${PN}-rtl8188ee"

LICENSE_${PN}-rtl8188ee = "Firmware-rtlwifi"
FILES_${PN}-rtl8188ee = " \
  /lib/firmware/rtlwifi/rtl8188efw.bin \
"
RDEPENDS_${PN}-rtl8188ee += "${PN}-rtl-license"
