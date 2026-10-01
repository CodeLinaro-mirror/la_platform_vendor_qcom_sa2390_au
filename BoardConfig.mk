include device/qcom/shikra_64/BoardConfig.mk

TARGET_CPU_VARIANT := generic

BUILD_BROKEN_PLUGIN_VALIDATION := vndfuzztest

BUILD_BROKEN_CLANG_PROPERTY := true

BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true

BUILD_BROKEN_PREBUILT_ELF_FILES := true

$(call soong_config_set,qti,IS_SHIKRA_TARGET,true)

$(call add_soong_config_var,qti,IS_ANDROID_SHIPPING_W)
ifeq ($(SHIPPING_API_LEVEL),36)
    $(call soong_config_set,qti,IS_ANDROID_SHIPPING_W,true)
endif

-include $(QCPATH)/common/sa2390_au/BoardConfigVendor.mk

#################################################################################
# This is the End of file                                                       #
#################################################################################
