FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
UBOOT_SRC ?= "https://github.com/ADVANTECH-Corp/uboot-imx.git;protocol=git"
SRC_URI += "file://*.cfg \
file://0001_project_001_add_all_project_files.patch \
file://0001_project_002_add_all_project_files.patch \
file://0001_project_003_add_all_project_files.patch \
file://0001_project_004_add_all_project_files.patch \
file://0002_spi_001_enable_u-boot_checksum.patch \
file://0002_spi_002_enable_u-boot_checksum.patch \
file://0003_system_001_enable_AXI_cache.patch \
file://0004_spi_001_get_mac_from_spi.patch \
file://0005_spi_001_board_set_boot_device.patch \
file://0006_spi_001_u-boot_environment_storge_in_spi.patch \
file://0006_spi_002_u-boot_environment_storge_in_spi.patch \
file://0006_spi_003_u-boot_environment_storge_in_spi.patch \
file://0006_spi_004_u-boot_environment_storge_in_spi.patch \
file://0006_spi_005_u-boot_environment_storge_in_spi.patch \
file://0006_spi_006_u-boot_environment_storge_in_spi.patch \
file://0007_spi_001_use_index_1_for_SD_3_for_emmc.patch \
file://0008_ethernet_001_Improve-RGMII_TXCLK-Duty-cycle.patch \
file://0009_LVDS_001_setup_lvds_init.patch \
file://0010_CPU_001_modify_thermal_parameter.patch \
file://0011_emmc_001_emmc_clock_for_dual-lite.patch \
file://0012_sata_001_sata_gen2_value_modify_for_si.patch \
file://0013_power_001_disable_pmic_config.patch \
file://0014_project_001_modify_rom7421_config.patch \
file://0014_project_002_modify_rom7421_config.patch \
file://0015_LVDS_001_disable_lvds_power_on.patch \
file://0016_project_001_modify_rom7420_config.patch \
file://0017_SD_001_TWO_SDCARD_SUPPORT.patch \
file://0017_SD_002_TWO_SDCARD_SUPPORT.patch \
file://0017_SD_003_TWO_SDCARD_SUPPORT.patch \
file://0018_project_001_add_rsb4410a2_config.patch \
file://0019_spi_001_enable_build_spl.patch \
file://0019_spi_002_enable_build_spl.patch \
file://0019_spi_003_enable_build_spl.patch \
file://0019_spi_004_enable_build_spl.patch \
file://0019_spi_005_enable_build_spl.patch \
file://0019_spi_006_enable_build_spl.patch \
file://0019_spi_007_enable_build_spl.patch \
file://0019_spi_008_enable_build_spl.patch \
file://0020_ANDROID_001_Add_android_config.patch \
file://0020_ANDROID_002_Add_android_config.patch \
file://0020_ANDROID_003_Add_android_config.patch \
file://0021_SD_001_modify_mmc_init_rules.patch \
file://0021_SD_002_modify_mmc_init_rules.patch \
file://0021_SD_003_modify_mmc_init_rules.patch \
file://0021_SD_004_modify_mmc_init_rules.patch \
file://0021_SD_005_modify_mmc_init_rules.patch \
file://0022_project_001_add_all_rsb-4411_config.patch \
file://0022_project_002_add_all_rsb-4411_config.patch \
file://0022_project_003_add_all_rsb-4411_config.patch \
file://0022_project_004_add_all_rsb-4411_config.patch \
file://0023_ANDROID_001_modify_uboot_setenv_parameter.patch \
file://0024_sata_001_enable_boot_from_sata.patch \
file://0024_sata_002_enable_boot_from_sata.patch \
file://0024_sata_003_enable_boot_from_sata.patch \
file://0024_sata_004_enable_boot_from_sata.patch \
file://0025_SD_001_fix_boot_from_wrong_mmc_device.patch \
file://0026_PCIE_001_fix_rgmii_txclk_duty_cycle.patch \
file://0027_SD_001_fix_eng_mode_boot_from_wrong_rootfs.patch \
file://0028_spi_001_enable_boot_from_carrier_spi.patch \
file://0028_spi_002_enable_boot_from_carrier_spi.patch \
file://0028_spi_003_enable_boot_from_carrier_spi.patch \
file://0029_project_001_add_rom-7421_2G_config.patch \
file://0029_project_002_add_rom-7421_2G_config.patch \
file://0029_project_003_add_rom-7421_2G_config.patch \
file://0030_spi_001_read_DDR_size_from_adv-loader.patch \
file://0030_spi_002_read_DDR_size_from_adv-loader.patch \
file://0030_spi_003_read_DDR_size_from_adv-loader.patch \
file://0031_SATA_Modify_sata_gen2_register_value.patch \
file://0032_ethernet_001_config_phy_addr_rsb-4411.patch \
file://0033_Project_001_Modify_rom-7421_2G_config_for_mx6qp.patch \
file://0033_Project_002_Modify_rom-7421_2G_config_for_mx6qp.patch \
file://0034_Project_001_Update_1G_ddr_parameter_for_rom7421_mx6qp_mp_ic.patch \
file://0035_spi_001_read_DDR_size_from_adv-loader.patch \
file://0036_project_001_add_rom-5420_solo_512MB_config.patch \
file://0036_project_002_add_rom-5420_solo_512MB_config.patch \
file://0036_project_003_add_rom-5420_solo_512MB_config.patch \
file://0036_project_004_add_rom-5420_solo_512MB_config.patch \
file://0037_ANDROID_001_add_rsb4411android_config.patch \
file://0038_spi_001_disable_splash_screen.patch \
file://0039_project_001_fixed_build_uboot_failed_issue_for_WISE_3310.patch \
file://0040_Project_001_modify_rom3420_and_udb220_config.patch \
file://0040_Project_002_modify_rom3420_and_udb220_config.patch"

PARALLEL_MAKE = ""
UBOOT_MAKE_TARGET += "all"
SPL_BINARY = "SPL"

# Copy cfg file
do_configure_prepend() {
    cp ${WORKDIR}/*.cfg ${B}/../git/board/freescale/mx6advantech
}

do_deploy_append() {
    install -d ${DEPLOYDIR}
    install ${S}/${config}/u-boot_crc.bin.crc ${DEPLOYDIR}/u-boot_crc.bin.crc
    install ${S}/${config}/u-boot_crc.bin ${DEPLOYDIR}/u-boot_crc.bin
}
