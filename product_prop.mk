#
# Copyright (C) 2017-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Default to BFQ I/O scheduler
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.io.scheduler=bfq

# Charger
PRODUCT_PRODUCT_PROPERTIES += \
    ro.charger.enable_suspend=true

# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_b=1
