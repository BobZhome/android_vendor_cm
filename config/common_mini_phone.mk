# Inherit common CM stuff
$(call inherit-product, vendor/cm/config/common.mk)

# Bring in all audio files
$(call inherit-product, frameworks/base/data/sounds/OldAudio.mk)

# Include CM audio files
#include vendor/cm/config/cm_audio.mk

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=somebodys.ogg \
    ro.config.notification_sound=Heaven.ogg \
    ro.config.alarm_alert=Alarm_Beep_03.ogg

PRODUCT_PACKAGES += \
  Mms

ifeq ($(TARGET_BOOTANIMATION_NAME),)
PRODUCT_COPY_FILES += \
        vendor/cm/prebuilt/common/bootanimation/vertical-320x480.zip:system/media/bootanimation.zip
endif
