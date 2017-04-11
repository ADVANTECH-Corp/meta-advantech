IMAGE_INSTALL += " ota-script "

#RMM & SUSI_4.0
IMAGE_INSTALL += "\
   sqlite3 lua uci \
   curl curl-dev libxml2 libxml2-dev openssl openssl-dev lsb \
   mosquitto mosquitto-dev libdmclient libdmclient-dev \
   packagegroup-sdk-target python-paho-mqtt libxmu  "

IMAGE_INSTALL += "\
   rmm susi4 susi-iot "

