SUMMARY = "Shell scripts to enable audio mixer for playback & recording"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://audio_playback.sh \
	   file://audio_recording.sh"

do_install() {
    install -d ${D}/tools
    install -m 755 ${WORKDIR}/audio_playback.sh ${D}/tools/audio_playback.sh
    install -m 755 ${WORKDIR}/audio_recording.sh ${D}/tools/audio_recording.sh
}

FILES_${PN} = "/tools"
