FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Get kernel source from Advantech GitHub
LINUX_LINARO_QCOM_GIT = "git://github.com/ADVANTECH-Corp/linux-linaro-qcomlt.git;protocol=https"
SRCREV = "d8fa532d22d4520aeea5bd898fa01c694ae8bdbf"

# Enable basic functions
SRC_URI += "file://basic_functions.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/basic_functions.cfg"

# Enable MAC VLAN
SRC_URI += "file://macvlan.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/macvlan.cfg"

# Enable Quectel LTE module
SRC_URI += "file://quectel.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/quectel.cfg"

# Enable Telit 3G module
SRC_URI += "file://telit.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/telit.cfg"

# Enable RNDIS
SRC_URI += "file://usbtethering.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/usbtethering.cfg"

# Enable Sierra AirPrime MC7304
SRC_URI += "file://sierra.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/sierra.cfg"

# Enable USB-4702/4704 ADC driver
SRC_URI += "file://usb-4704.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/usb-4704.cfg"

# Enable FunctionFS for ADB daemon
SRC_URI += "file://adbd.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/adbd.cfg"

# Enable RTL8188EE WIFI Module (USB interface)
SRC_URI += "file://rtl8188ee.cfg"
KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/rtl8188ee.cfg"
LOCALVERSION = "-4760LIV1130"
