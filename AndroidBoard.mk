LOCAL_PATH := $(call my-dir)
# Add own fstab / prebuilt modules here if they differ from the base.
include device/qcom/shikra_64/AndroidBoard.mk

# INSTALLED_BOOTLOADER_MODULE is empty when AndroidBoard.mk is parsed (it is set
# later in build/make/core/Makefile), so the $(INSTALLED_BOOTLOADER_MODULE) rules
# in shikra_64/AndroidBoard.mk expand to nothing and abl.elf becomes an orphan.
# Wire it in here via INSTALLED_RADIOIMAGE_TARGET, which is consumed as a
# prerequisite of $(BUILT_TARGET_FILES_DIR) in build/make/core/Makefile after
# all AndroidBoard.mk files have been parsed.
INSTALLED_RADIOIMAGE_TARGET += $(PRODUCT_OUT)/abl.elf

#################################################################################
# This is the End of file                                                       #
#################################################################################
