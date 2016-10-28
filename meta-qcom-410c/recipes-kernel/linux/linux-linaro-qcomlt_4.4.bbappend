FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Enable MAC VLAN
SRC_URI += "file://macvlan.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/macvlan.cfg"

# Add EDID binaries in kernel package
FILES_kernel = "/usr/lib/firmware/edid"