# Node-RED
IMAGE_INSTALL_append = " nodejs nodejs-npm node-red zsh "

# Mbed
IMAGE_INSTALL_append = " factory-configurator-client mbed-edge "
IMAGE_INSTALL_append = " libevent libevent-dev libc6-dev "

# Install for building Mbed-edge
TOOLCHAIN_TARGET_TASK += "\
   libevent libevent-dev \
   jansson \
   libc6-dev\
   "
