
DESCRIPTION = "OPTEE OS"

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-security/opee/optee-os-imx_git.bb

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PLATFORM_FLAVOR_mx8mq	= "${@d.getVar('MACHINE')[1:]}"

SRC_URI += " file://0001-add-imx8mq-advantech-support.patch \
"
