FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Add testmode for LAN7500 PHY
SRC_URI += "file://smsc75xx_net_testmode.patch"

# Enable MAC VLAN
SRC_URI += "file://macvlan.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/macvlan.cfg"

# Add EDID binaries in kernel package
FILES_kernel = "/usr/lib/firmware/edid"
