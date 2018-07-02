# Node-RED
IMAGE_INSTALL_append = " nodejs nodejs-npm node-red zsh "
IMAGE_INSTALL_append = " node-red-contrib-azure-iot-hub "

# Mbed
IMAGE_INSTALL_append = " factory-configurator-client mbed-edge "

# Install for building Mbed-edge
TOOLCHAIN_TARGET_TASK += "\
   libevent-dev \
   jansson-dev \
   libc6-dev\
   "
