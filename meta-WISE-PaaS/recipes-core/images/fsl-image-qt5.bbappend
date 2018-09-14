DESCRIPTION = "FSL QT5 image with Advantech EdgeSense feature"

IMAGE_INSTALL_append_mx6 = " packagegroup-wise-paas "

# Install for building RMM
TOOLCHAIN_TARGET_TASK_mx6 += "\
   curl curl-dev \
   mosquitto mosquitto-dev \
   c-ares \
   "
