
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"


do_compile_prepend () {
	cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${S}/${SOC_DIR}/fsl-imx8mq-evk.dtb
}
