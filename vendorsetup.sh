echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/23]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-20.0 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/23]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo_kuntao -b lineage-20.0 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/23]'
# Frameworks base
rm -rf frameworks/base && git clone --depth=1 https://github.com/Astridxx/frameworks_base-1 -b xt frameworks/base

echo 'Cloning frameworks native [4/23]'
# Native
rm -rf frameworks/native && git clone https://github.com/Astridxx/frameworks_native-1 -b xt frameworks/native

echo 'Cloning frameworks libs net [5/23]'
# Libs net
rm -rf frameworks/libs/net && git clone https://github.com/kuntao-development/frameworks_libs_net -b lineage-20.0 frameworks/libs/net

echo 'Cloning deskclock [6/23]'
# DeskClock
rm -rf packages/apps/DeskClock && git clone https://github.com/Astridxx/android_packages_apps_DeskClock -b thirteen packages/apps/DeskClock

echo 'Cloning connectivity modules [7/23]'
# Connectivity
rm -rf packages/modules/Connectivity && git clone https://github.com/Astridxx/packages_modules_Connectivity -b xt packages/modules/Connectivity

echo 'Cloning networkstack modules [8/23]'
# Networkstack
rm -rf packages/modules/NetworkStack && git clone https://github.com/Astridxx/packages_modules_NetworkStack -b xt packages/modules/NetworkStack

echo 'Cloning sepolicy legacy um [9/23]'
# Sepolicy-legacy-um
rm -rf device/qcom/sepolicy-legacy-um && git clone https://github.com/kuntao-development/android_device_qcom_sepolicy -b xt-legacy-um device/qcom/sepolicy-legacy-um

echo 'Cloning system memory lmkd [10/23]'
# Lmkd
rm -rf system/memory/lmkd && git clone https://github.com/kuntao-development/android_system_memory_lmkd -b xt system/memory/lmkd

echo 'Cloning system netd [11/23]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/android_system_netd -b lineage-20.0 system/netd

echo 'Cloning system bpf [12/23]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-20.0 system/bpf

echo 'Cloning system libhidl [13/23]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-20.0 system/libhidl

echo 'Cloning system sepolicy [14/23]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/LineageOS-UL/android_system_sepolicy -b lineage-20.0 system/sepolicy

echo 'Cloning system core [15/23]'
# Core
rm -rf system/core && git clone https://github.com/Astridxx/system_core -b xt system/core

echo 'Cloning system logging [16/23]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-20.0 system/logging

echo 'Cloning vendor fm [17/23]'
# Fm
rm -rf vendor/qcom/opensource/fm-commonsys && git clone https://github.com/kuntao-development/android_vendor_qcom_opensource_fm-commonsys -b lineage-20.0 vendor/qcom/opensource/fm-commonsys

echo 'Cloning vendor xtended [18/23]'
# Xtended vendor
rm -rf vendor/xtended && git clone https://github.com/Astridxx/vendor_xtended -b xt vendor/xtended

echo 'Cloning audio hal [19/23]'
# Clang
rm -rf hardware/qcom-caf/msm8996/audio && git clone https://github.com/LineageOS/android_hardware_qcom_audio -b lineage-20.0-caf-msm8996 hardware/qcom-caf/msm8996/audio

echo 'Cloning display hal [20/23]'
# Clang
rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/LineageOS/android_hardware_qcom_display -b lineage-20.0-caf-msm8996 hardware/qcom-caf/msm8996/display

echo 'Cloning media hal [21/23]'
# Clang
rm -rf hardware/qcom-caf/msm8996/media && git clone https://github.com/LineageOS/android_hardware_qcom_media -b lineage-20.0-caf-msm8996 hardware/qcom-caf/msm8996/media

echo 'Cloning clang 12 [22/23]'
# Clang
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_clang_kernel_linux-x86_clang-r416183b -b lineage-20.0 prebuilts/clang/kernel/linux-x86/clang-r416183b

echo 'Cloning external tinyxml [23/23]'
# Clang
git clone https://github.com/ArrowOS/android_external_tinyxml -b arrow-13.0 external/tinyxml

# ************************************
# Fix Bluetooth calling on legacy SOCs
# ************************************
# git clone --depth=1 https://android.googlesource.com/platform/packages/modules/Bluetooth.git -b android-13.0.0_r11
echo 'Patching Bluetooth stack in "packages/modules/Bluetooth" ...'
patch_name='Send enhanced sco setup cmd only for wcn3990'
patch_dir=packages/modules/Bluetooth
cur_commit="$(git -C $patch_dir show -s --format=%s)" || exit $?

# Remove old commit
if [ "$cur_commit" = "$patch_name" ]; then
    git -C $patch_dir reset --hard HEAD^ || exit $?
fi

# Apply and commit patch
git -C $patch_dir apply --verbose < <(cat <<'EOL'
From 0c0cee3eaedaf372d63e71f170f2e82af7d08668 Mon Sep 17 00:00:00 2001
From: Satheesh Kumar Pallemoni <palsat@codeaurora.org>
Date: Fri, 16 Sep 2022 08:39:52 +0200
Subject: [PATCH] Send enhanced sco setup cmd only for wcn3990

Send enhanced sco setup cmd only for wcn3990.
For older BT SOCs, send setup synchronous connection
command.

CRs-Fixed: 2117588
Change-Id: I45d04f7c4490c49f2ffb736466f8c96db360ab70
---
 system/bta/ag/bta_ag_sco.cc | 11 +++++++++--
 system/stack/btm/btm_sco.cc | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/system/bta/ag/bta_ag_sco.cc b/system/bta/ag/bta_ag_sco.cc
index f33530a..b6b4a2a 100644
--- a/system/bta/ag/bta_ag_sco.cc
+++ b/system/bta/ag/bta_ag_sco.cc
@@ -34,6 +34,7 @@
 #include "main/shim/dumpsys.h"
 #include "osi/include/log.h"
 #include "osi/include/osi.h"  // UNUSED_ATTR
+#include "osi/include/properties.h"
 #include "stack/btm/btm_sco.h"
 #include "stack/include/btm_api.h"
 #include "stack/include/btu.h"  // do_in_main_thread
@@ -44,6 +45,8 @@
 #define BTA_AG_CODEC_NEGOTIATION_TIMEOUT_MS (3 * 1000) /* 3 seconds */
 #endif

+static char value[PROPERTY_VALUE_MAX];
+
 static bool sco_allowed = true;
 static RawAddress active_device_addr = {};

@@ -188,7 +191,9 @@ static void bta_ag_sco_disc_cback(uint16_t sco_idx) {
     if (bta_ag_cb.sco.p_curr_scb->inuse_codec == BTM_SCO_CODEC_MSBC) {
       /* Bypass vendor specific and voice settings if enhanced eSCO supported */
       if (!(controller_get_interface()
-                ->supports_enhanced_setup_synchronous_connection())) {
+                ->supports_enhanced_setup_synchronous_connection() &&
+            (osi_property_get("qcom.bluetooth.soc", value, "qcombtsoc") &&
+             strcmp(value, "cherokee") == 0))){
         BTM_WriteVoiceSettings(BTM_VOICE_SETTING_CVSD);
       }

@@ -476,7 +481,9 @@ static void bta_ag_create_pending_sco(tBTA_AG_SCB* p_scb, bool is_local) {

     /* Bypass voice settings if enhanced SCO setup command is supported */
     if (!(controller_get_interface()
-              ->supports_enhanced_setup_synchronous_connection())) {
+              ->supports_enhanced_setup_synchronous_connection() &&
+          (osi_property_get("qcom.bluetooth.soc", value, "qcombtsoc") &&
+           strcmp(value, "cherokee") == 0))) {
       if (esco_codec == BTM_SCO_CODEC_MSBC) {
         BTM_WriteVoiceSettings(BTM_VOICE_SETTING_TRANS);
       } else {
diff --git a/system/stack/btm/btm_sco.cc b/system/stack/btm/btm_sco.cc
index 9c5c41f..f4c7018 100644
--- a/system/stack/btm/btm_sco.cc
+++ b/system/stack/btm/btm_sco.cc
@@ -33,6 +33,7 @@
 #include "osi/include/allocator.h"
 #include "osi/include/log.h"
 #include "osi/include/osi.h"
+#include "osi/include/properties.h"
 #include "stack/btm/btm_sec.h"
 #include "stack/btm/security_device_record.h"
 #include "stack/include/acl_api.h"
@@ -80,6 +81,8 @@ const bluetooth::legacy::hci::Interface& GetLegacyHciInterface() {
   (ESCO_PKT_TYPES_MASK_NO_2_EV3 | ESCO_PKT_TYPES_MASK_NO_3_EV3 | \
    ESCO_PKT_TYPES_MASK_NO_2_EV5 | ESCO_PKT_TYPES_MASK_NO_3_EV5)

+static char value[PROPERTY_VALUE_MAX];
+
 /******************************************************************************/
 /*            L O C A L    F U N C T I O N     P R O T O T Y P E S            */
 /******************************************************************************/
@@ -140,7 +143,9 @@ static void btm_esco_conn_rsp(uint16_t sco_inx, uint8_t hci_status,
     }
     /* Use Enhanced Synchronous commands if supported */
     if (controller_get_interface()
-            ->supports_enhanced_setup_synchronous_connection()) {
+            ->supports_enhanced_setup_synchronous_connection() &&
+        (osi_property_get("qcom.bluetooth.soc", value, "qcombtsoc") &&
+         strcmp(value, "cherokee") == 0)) {
       /* Use the saved SCO routing */
       p_setup->input_data_path = p_setup->output_data_path = ESCO_DATA_PATH;

@@ -341,7 +346,9 @@ static tBTM_STATUS btm_send_connect_request(uint16_t acl_handle,

     /* Use Enhanced Synchronous commands if supported */
     if (controller_get_interface()
-            ->supports_enhanced_setup_synchronous_connection()) {
+            ->supports_enhanced_setup_synchronous_connection() &&
+        (osi_property_get("qcom.bluetooth.soc", value, "qcombtsoc") &&
+         strcmp(value, "cherokee") == 0)) {
       LOG_INFO("Sending enhanced SCO connect request over handle:0x%04x",
                acl_handle);
       /* Use the saved SCO routing */
@@ -1174,7 +1181,9 @@ static tBTM_STATUS BTM_ChangeEScoLinkParms(uint16_t sco_inx,

     /* Use Enhanced Synchronous commands if supported */
     if (controller_get_interface()
-            ->supports_enhanced_setup_synchronous_connection()) {
+            ->supports_enhanced_setup_synchronous_connection() &&
+         (osi_property_get("qcom.bluetooth.soc", value, "qcombtsoc") &&
+          strcmp(value, "cherokee") == 0)) {
       /* Use the saved SCO routing */
       p_setup->input_data_path = p_setup->output_data_path = ESCO_DATA_PATH;

EOL
) &&
git -C $patch_dir commit -am "$patch_name"
