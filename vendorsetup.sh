echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/18]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-20.0 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/18]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo -b lineage-20.0 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/18]'
# Frameworks base
rm -rf frameworks/base && git clone --depth=1 https://github.com/kuntao-development/android_frameworks_base -b triton frameworks/base

echo 'Cloning frameworks native [4/18]'
# Native
rm -rf frameworks/native && git clone https://github.com/Astridxx/android_frameworks_native -b triton frameworks/native

echo 'Cloning frameworks libs net [5/18]'
# Libs net
rm -rf frameworks/libs/net && git clone https://github.com/kuntao-development/frameworks_libs_net -b lineage-20.0 frameworks/libs/net

echo 'Cloning frameworks opt telephony [6/18]'
# Telephony
rm -rf frameworks/opt/telephony && git clone https://github.com/kuntao-development/android_frameworks_opt_telephony -b lineage-20.0 frameworks/opt/telephony

echo 'Cloning connectivity modules  [7/18]'
# Connectivity
rm -rf packages/modules/Connectivity && git clone https://github.com/kuntao-development/android_packages_modules_Connectivity -b triton packages/modules/Connectivity

echo 'Cloning networkstack modules [8/18]'
# Networkstack
rm -rf packages/modules/NetworkStack && git clone https://github.com/kuntao-development/android_packages_modules_NetworkStack -b lineage-20.0 packages/modules/NetworkStack

echo 'Cloning sepolicy legacy um [9/18]'
# Sepolicy-legacy-um
rm -rf device/qcom/sepolicy-legacy-um && git clone https://github.com/kuntao-development/android_device_qcom_sepolicy -b lineage-20.0-legacy-um device/qcom/sepolicy-legacy-um

echo 'Cloning system netd [10/18]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/android_system_netd -b lineage-20.0 system/netd

echo 'Cloning system bpf [11/18]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-20.0 system/bpf

echo 'Cloning system libhidl [12/18]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-20.0 system/libhidl

echo 'Cloning system sepolicy [13/18]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/LineageOS-UL/android_system_sepolicy -b lineage-20.0 system/sepolicy

echo 'Cloning system core [14/18]'
# Core
rm -rf system/core && git clone https://github.com/kuntao-development/android_system_core -b triton system/core

echo 'Cloning system logging [15/18]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-20.0 system/logging

echo 'Cloning vendor fm [16/18]'
# Fm
rm -rf vendor/qcom/opensource/fm-commonsys && git clone https://github.com/kuntao-development/android_vendor_qcom_opensource_fm-commonsys -b lineage-20.0 vendor/qcom/opensource/fm-commonsys

echo 'Cloning vendor awaken [17/18]'
# Awaken vendor
rm -rf vendor/awaken && git clone https://github.com/kuntao-development/android_vendor_awaken -b triton vendor/awaken

echo 'Cloning clang 12 [18/18]'
# Clang
git clone --depth=1 https://github.com/ArrowOS-Devices/android_prebuilts_clang_host_linux-x86_clang-r416183b -b master prebuilts/clang/host/linux-x86/clang-r416183b

echo 'Completed, proceeding to lunch'
