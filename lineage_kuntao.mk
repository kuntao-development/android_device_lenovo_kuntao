#
# Copyright (C) 2022 The AwakenOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit 64-bit configs
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_m.mk)

# Inherit some common RiceDroid stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lenovo/kuntao/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := lineage_kuntao
PRODUCT_DEVICE := kuntao
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := Lenovo P2a42
PRODUCT_MANUFACTURER := LENOVO

# Rice
SUSHI_BOOTANIMATION := 1080
TARGET_BUILD_APERTURE_CAMERA := true
RICE_MAINTAINER := "Akshay"
RICE_CHIPSET := "Snapdragon®625"
WITH_GMS := true
TARGET_CORE_GMS := true

# Rice apps
PRODUCT_PACKAGES += \
    Photos \
    AndroidAutoStubPrebuilt \
    CalendarGooglePrebuilt \
    CalculatorGooglePrebuilt

PRODUCT_GMS_CLIENTID_BASE := android-lenovo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="kuntao_row-user 7.0 NRD90N P2a42_S251_171107_ROW release-keys" \
    TARGET_DEVICE="P2a42"

BUILD_FINGERPRINT := Lenovo/kuntao_row/P2a42:7.0/NRD90N/P2a42_S251_171107_ROW:user/release-keys
