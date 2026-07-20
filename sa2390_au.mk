TARGET_BOARD_PLATFORM := sa2390
TARGET_BOARD_SUFFIX := _au
TARGET_BOARD_FAMILY := f-sa2390
TARGET_BOOTLOADER_BOARD_NAME := sa2390

# Automotive board type flags
TARGET_BOARD_AUTO := true
TARGET_BOARD_TYPE := auto

# ----------------------------------------------------------------------------
# Set LOCAL_PATH to device/qcom/shikra_64 BEFORE the include so that
# `PRODUCT_COPY_FILES += $(LOCAL_PATH)/<file>` entries inside shikra_64.mk
# (charger_fstab.qcom, fstab*.qcom, ueventd-odm.rc, ...) resolve to the real
# shikra_64 directory.
#
# Without this, $(LOCAL_PATH) would include the value from this
# makefile -- which is device/qcom/sa2390_au/ -- and the build would look for
# device/qcom/sa2390_au/charger_fstab.qcom and fail with "missing and no known
# rule to make it".
LOCAL_PATH := device/qcom/shikra_64

# Inherit the entire base product
include device/qcom/shikra_64/shikra_64.mk

# Restore LOCAL_PATH to this directory for any subsequent product-makefile
# references in this file.
LOCAL_PATH := device/qcom/sa2390_au

# Override identity so it becomes a distinct lunch target
PRODUCT_NAME   := sa2390_au
PRODUCT_DEVICE := sa2390_au
PRODUCT_BRAND  := qti
PRODUCT_MODEL  := sa2390_au for arm64

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

TARGET_NO_TELEPHONY := true

TARGET_CONSOLE_ENABLED ?= true
TARGET_USES_QMAA_OVERRIDE_DATA_CONNECTIVITY := false

# Inherit Android Automotive (Car) system product makefiles
$(call inherit-product, device/qcom/qssi_au/qssi_au_system_generic.mk)
$(call inherit-product, packages/services/Car/car_product/build/car_generic_system.mk)
$(call inherit-product, packages/services/Car/car_product/build/car_system_ext.mk)
$(call inherit-product, packages/services/Car/car_product/build/car_product.mk)

# Inherit Android Automotive (Car) vendor packages
$(call inherit-product, packages/services/Car/car_product/build/car_vendor.mk)

# Enable Car Telemetry
ENABLE_CARTELEMETRY_SERVICE := true
PRODUCT_PACKAGES += android.automotive.telemetryd@1.0
PRODUCT_PACKAGES += ScriptExecutor

# Audio HAL stub-mode fallback.
# The shikra virtual soundcard (shikradspvirtualsndcard) does not register during
# early bringup, so AHAL's 30-second health-monitor fires and boot-loops with
# StubMode=DISABLED.  Set FALL_BACK_TO_STUB (2): AHAL tries normal init first;
# on timeout it escalates to FAIL_SAFE_STUB (3) and crashes; init restarts it;
# the next instance sees prop=3, loads the stub HAL, and boot completes.
# On subsequent boots the property resets to 2 so normal audio init is retried
# automatically once the audio drivers are properly configured.
PRODUCT_PROPERTY_OVERRIDES += persist.vendor.audio.hal.stubmode=2

#################################################################################
# This is the End of file                                                       #
#################################################################################
