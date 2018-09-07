IMAGE_INSTALL_append_mx6 = " packagegroup-wise-paas "

# Install for building RMM
TOOLCHAIN_TARGET_TASK += "\
   curl curl-dev \
   mosquitto mosquitto-dev \
   c-ares \
   "
