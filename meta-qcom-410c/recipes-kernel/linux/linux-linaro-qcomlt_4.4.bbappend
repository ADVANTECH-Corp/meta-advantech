FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Enable basic functions
SRC_URI += "file://basic_functions.cfg \
	    file://0004_System_001_Add_to_build_proc_board_file_and_information.patch \
	    file://0024_Watchdog_001_Add_watchdog_driver_for_external_watchdog.patch"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/basic_functions.cfg"

# Add testmode for LAN7500 PHY
SRC_URI += "file://smsc75xx_net_testmode.patch"

# Enable MAC VLAN
SRC_URI += "file://macvlan.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/macvlan.cfg"

# Update DTS tree
SRC_URI += "file://Update-DTS-for-RSB-4760.patch"

# New kernel commit to fix up memory map
SRCREV = "67e3534daae74c52a92bb5822918059507afb655"
