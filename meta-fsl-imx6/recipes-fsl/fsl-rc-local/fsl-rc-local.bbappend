FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://autorun_keyevent_and_ec_uevent.patch \
	    file://add_file_for_lirc.patch \
	    file://add_boottimes.patch "
