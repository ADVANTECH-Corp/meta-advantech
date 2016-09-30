FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
KERNEL_SRC ?= "https://github.com/ADVANTECH-Corp/linux-2.6-imx.git;protocol=git"
SRC_URI += "file://imx_v7_adv_defconfig \
file://imx6qdl-advantech.dtsi \
file://*.dts \
file://0001_Project_001_add_all_risc_projects_to_build_dts_file.patch \
file://0002_SD_001_change_sdhc_init_order.patch \
file://0003_System_001_Add_advantech_MFG_defined_configuration_file.patch \
file://0004_System_001_Add_to_build_proc_board_file_and_information.patch \
file://0005_System_001_modify_thermal_parameter.patch \
file://0006_System_001_add_advboot_boardinfo_uboot_info.patch \
file://0007_System_001_add_check_board_type.patch \
file://0008_Ethernet_001_SI_Test.patch \
file://0008_Ethernet_002_SI_Test.patch \
file://0009_Ethernet_001_fix_Kernel_crash_after_switching_eth0_speed_duplex.patch \
file://0010_GPIO_001_add_gpio_GPIO_export_naming_rule_and_workaround_gpio_rename.patch \
file://0010_GPIO_002_Read_GPIO_DR_instead_of_GPIO_PSR.patch \
file://0010_GPIO_003_Initialize_GPIO_pin_defined_and_direction.patch \
file://0011_SLEEP_POWER_001_add_key_function_for_sleep_power_key.patch \
file://0011_SLEEP_POWER_002_add_key_function_for_sleep_power_key.patch \
file://0012_I2C_001_modify_i2c_switch_driver.patch \
file://0013_IR_001_add_ir_driver.patch \
file://0014_eMMC_001_Set_MMC_index_sequence.patch \
file://0015_SPI_001_add_spi_id.patch \
file://0017_3G_001_add_support_for_EWM-C109F601E.patch \
file://0019_SystemBus_001_add_a_system_bus_function.patch \
file://0020_dustwsn_001_Add_dustwsn_init_module_and_enable.patch \
file://0021_Battery_001_add_battery_driver.patch \
file://0021_Battery_002_add_battery_driver.patch \
file://0023_Multi_Display_001_add_vga_edid_Fix_multi_display_with_VGA_HDMI.patch \
file://0023_Multi_Display_002_Fix_HDMI_hot_plug_resolution_switch_issue.patch \
file://0024_Watchdog_001_Add_watchdog_driver_for_external_watchdog.patch \
file://0025_Audio_001_Set_sgtl5000_codec_registers_with_correct_values_and_fix_issue.patch \
file://0029_System_001_Add_ROM7421_project_to_check_board_type_cpu.patch \
file://0030_Ethernet_002_Fixed_LAN_issue_for_SI_test.patch \
file://0031_LVDS_002_Modify_LVDS_power_on_sequence_for_SI_test.patch \
file://0031_LVDS_003_Modify_LVDS_power_on_sequence_for_SI_test.patch \
file://0032_SD_001_Modify_mmc_block_index_about_mmcblkx.patch \
file://0033_SD_001_Add_to_read_and_write_carrier_sd_card_function.patch \
file://0034_PMIC_001_Fixed_PMIC_TPS65911_issue_for_SI_test.patch \
file://0035_RTC_001_Change_externel_RTC_to_rtc0.patch \
file://0036_USB_001_Set_USB_OTG_PHY_register_for_SI_test_of_USB_OTG_eye_diagram.patch \
file://0037_HDMI_001_Modify_HDMI_PHY_register_for_SI_test.patch \
file://0038_Watchdog_001_Modify_watchdog_function_watchdog-out_pin_at_present_wait_HW_rework.patch \
file://0039_Watchdog_001_Fixed_Watchdog_issue.patch \
file://0041_ANDROID_001_Add_android_config.patch \
file://0042_Project_002_add_to_build_imx6q-rsb4411_dts_file.patch \
file://0044_ANDROID_001_fixed_rtc_fail.patch \
file://0045_LVDS_002__Fixed_lvds_dual_channel_issue_for_i.MX6DP_CPU.patch \
file://0046_ANDROID_001_Add_bluetooth.patch \
file://0050_SATA_Add_a_table_of_SATA_Gen1_2_3_phy_register_all_projects.patch \
file://0051_SD_001_SD_cannot_be_detceted_on_kernel.patch \
file://0052_SPI_002_Fixed_SPI_cannot_detect_issue.patch \
file://0052_SPI_003_Fixed_SPI_cannot_detect_issue.patch \
file://0054_CAAM_002_Enable_caam_aclk_firstly.patch \
file://0056_Project_001_add_rom5420_solo.patch \
file://0057_PMIC_001_Modify_the_register_values_of_PMIC_TPS65911_for_SI_test.patch \
file://0059_USB_OTG_001_Fixed_USB_OTG_issue_for_SI_eye_diagram_test.patch \
file://0062_Project_001_Add_rsb4411_proc_file.patch \
file://0063_SATA_001_add_rsb4411_si_gen2_value.patch \
file://0064_USB_OTG_001_Fixed_USB_OTG_issue_for_SI_eye_diagram_test.patch \
file://0065_PCIE_001_Modify_the_register_value_of_pcie_for_SI_test.patch \
file://0066_LVDS_001_Modify_LVDS_power_on_sequence_for_SI_test.patch \
file://0066_LVDS_002_Modify_LVDS_power_on_sequence_for_SI_test.patch \
file://0067_USB_OTG_001_Modify_USB_OTG_PHY_register_for_SI_test_of_USB_OTG.patch \
file://0068_POWER_BUTTON_001_Add_software_power_off_function.patch \
file://0069_BATTERY_CHARGING_001_Fixed_power_on_off_issue_due_to_EC_problem.patch"

# Skip getting GIT revision for local version
SCMVERSION = "n"

# Copy advantech defconfig and dts file 
do_configure_prepend() {
    cp ${WORKDIR}/imx_v7_adv_defconfig ${B}/../defconfig
    cp ${WORKDIR}/imx6qdl-advantech.dtsi ${B}/../git/arch/arm/boot/dts/
    cp ${WORKDIR}/*.dts ${B}/../git/arch/arm/boot/dts/
}

