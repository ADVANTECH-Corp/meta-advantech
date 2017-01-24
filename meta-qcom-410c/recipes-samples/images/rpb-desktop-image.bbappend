# Remove Network Manager
IMAGE_INSTALL_remove = " networkmanager networkmanager-nmtui "

# Scripts
IMAGE_INSTALL_append = " stress-script thermal-script audio-script mac-script "
IMAGE_INSTALL_append = " boottimes-script emi-script "

# Tool for kernel parameters
IMAGE_INSTALL_append = " abootimg "

# Tools for function verification
IMAGE_INSTALL_append = " stress stress-ng devmem2 fbv i2c-tools ethtool evtest "
IMAGE_INSTALL_append = " minicom st boottimes alsa-utils fbida iperf memtester ppp "
IMAGE_INSTALL_append = " netkit-ftp glmark2 "

# Misc
# - X resource database manager
IMAGE_INSTALL_append = " xrdb "

# Native Compiler
IMAGE_INSTALL_append = " packagegroup-sdk-target "

# SUSI 4.0
IMAGE_INSTALL_append = " susi4 "
