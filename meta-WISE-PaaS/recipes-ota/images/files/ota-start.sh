#!/bin/bash

if [ -e /usr/local/OTA-Agent ];then

	if [ ! -e /cache/ota ];then
		mkdir /cache/ota
	fi
	if [ ! -e /cache/ota/agent_config.xml ];then
		cp /usr/local/OTA-Agent/agent_config.xml /cache/ota
	fi

	/etc/init.d/otaagent start
	/etc/init.d/otawatchdog start

fi


