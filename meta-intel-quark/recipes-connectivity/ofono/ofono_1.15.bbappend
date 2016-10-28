DEPENDS  = "dbus glib-2.0 udev mobile-broadband-provider-info ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth','bluez5', '', d)}"
