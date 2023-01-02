echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/17]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-20.0 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/17]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo_kuntao -b lineage-20.0 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/17]'
# Frameworks base
rm -rf frameworks/base && git clone --depth=1 https://github.com/kuntao-development/frameworks_base -b 13 frameworks/base

echo 'Cloning frameworks native [4/17]'
# Native
rm -rf frameworks/native && git clone https://github.com/kuntao-development/frameworks_native -b 13 frameworks/native

echo 'Cloning frameworks libs net [5/17]'
# Libs net
rm -rf frameworks/libs/net && git clone https://github.com/kuntao-development/frameworks_libs_net -b lineage-20.0 frameworks/libs/net

echo 'Cloning connectivity modules [6/17]'
# Connectivity
rm -rf packages/modules/Connectivity && git clone https://github.com/kuntao-development/packages_modules_Connectivity -b 13 packages/modules/Connectivity

echo 'Cloning display hal [7/17]'
# Clang
rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/kuntao-development/android_hardware_qcom_display -b lineage-20.0-caf-msm8996 hardware/qcom-caf/msm8996/display

echo 'Cloning networkstack modules [8/17]'
# Networkstack
rm -rf packages/modules/NetworkStack && git clone https://github.com/kuntao-development/android_packages_modules_NetworkStack -b lineage-20.0 packages/modules/NetworkStack

echo 'Cloning sepolicy legacy um [9/17]'
# Sepolicy-legacy-um
rm -rf device/qcom/sepolicy-legacy-um && git clone https://github.com/kuntao-development/android_device_qcom_sepolicy -b derp-legacy-um device/qcom/sepolicy-legacy-um

echo 'Cloning system netd [10/17]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/platform_system_netd -b lineage-20.0 system/netd

echo 'Cloning system bpf [11/17]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-20.0 system/bpf

echo 'Cloning system libhidl [12/17]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-20.0 system/libhidl

echo 'Cloning system sepolicy [13/17]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/LineageOS-UL/android_system_sepolicy -b lineage-20.0 system/sepolicy

echo 'Cloning system core [14/17]'
# Core
rm -rf system/core && git clone https://github.com/kuntao-development/android_system_core -b 13 system/core

echo 'Cloning system logging [15/17]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-20.0 system/logging

echo 'Cloning vendor fm [16/17]'
# Fm
rm -rf vendor/qcom/opensource/fm-commonsys && git clone https://github.com/kuntao-development/android_vendor_qcom_opensource_fm-commonsys -b lineage-20.0 vendor/qcom/opensource/fm-commonsys

echo 'Cloning vendor derp [17/17]'
# Derp vendor
rm -rf vendor/derp && git clone https://github.com/kuntao-development/vendor_derp -b 13 vendor/derp

# ************************************
# Fix Bluetooth calling on legacy SOCs
# ************************************
# git clone --depth=1 https://android.googlesource.com/platform/packages/modules/Bluetooth.git -b android-13.0.0_r13
patch_name='Do not send enhanced sco setup cmd - r13'
patch_dir=packages/modules/Bluetooth
cur_commit="$(git -C $patch_dir show -s --format=%s)" || exit $?

if [ "$cur_commit" != "$patch_name" ]; then
    echo 'Patching Bluetooth stack in "packages/modules/Bluetooth" ...'

    # Apply and commit patch
    git -C $patch_dir apply --verbose < <(cat <<'EOL'
diff --git a/system/main/shim/controller.cc b/system/main/shim/controller.cc
index ca80b52..9171ada 100644
--- a/system/main/shim/controller.cc
+++ b/system/main/shim/controller.cc
@@ -40,7 +40,6 @@ constexpr uint8_t kPhyLe1M = 0x01;
  * Interesting commands supported by controller
  */
 constexpr int kReadRemoteExtendedFeatures = 0x41c;
-constexpr int kEnhancedSetupSynchronousConnection = 0x428;
 constexpr int kEnhancedAcceptSynchronousConnection = 0x429;
 constexpr int kLeSetPrivacyMode = 0x204e;
 constexpr int kConfigureDataPath = 0x0c83;
@@ -220,9 +219,9 @@ FORWARD_IF_RUST(
 FORWARD_IF_RUST(supports_reading_remote_extended_features,
                 GetController()->IsSupported((bluetooth::hci::OpCode)
                                                  kReadRemoteExtendedFeatures))
-FORWARD_IF_RUST(supports_enhanced_setup_synchronous_connection,
-                GetController()->IsSupported((
-                    bluetooth::hci::OpCode)kEnhancedSetupSynchronousConnection))
+static bool supports_enhanced_setup_synchronous_connection(void) {
+    return false;
+}
 FORWARD_IF_RUST(
     supports_enhanced_accept_synchronous_connection,
     GetController()->IsSupported((bluetooth::hci::OpCode)
EOL
    ) &&
    git -C $patch_dir commit -am "$patch_name" || exit $?
else
    echo 'Skipping patching Bluetooth stack in "packages/modules/Bluetooth". Already applied.'
fi
