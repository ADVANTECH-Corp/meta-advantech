PACKAGECONFIG[bluetooth] = "--enable-bluetooth, --disable-bluetooth, bluez5"

RDEPENDS_${PN} = "\
	dbus \
	${@bb.utils.contains('PACKAGECONFIG', 'bluetooth', 'bluez5', '', d)} \
	${@bb.utils.contains('PACKAGECONFIG', 'wifi','wpa-supplicant', '', d)} \
	${@bb.utils.contains('PACKAGECONFIG', '3g','ofono', '', d)} \
	xuser-account \
	"
