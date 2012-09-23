# Inherit common CM stuff
$(call inherit-product, vendor/cm/config/common.mk)

# Bring in some old audio files
$(call inherit-product, frameworks/base/data/sounds/OldAudio.mk)

# Include CM audio files
#include vendor/cm/config/cm_audio.mk

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=somebodys.ogg \
    ro.config.notification_sound=Heaven.ogg \
    ro.config.alarm_alert=Alarm_Beep_03.ogg

PRODUCT_PACKAGES += \
  Mms

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/cm/prebuilt/common/bootanimation/320.zip:system/media/bootanimation.zip
endif
