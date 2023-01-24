echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/18]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-20.0 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/18]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo_kuntao -b lineage-20.0 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/18]'
# Frameworks base
rm -rf frameworks/base && git clone --depth=1 https://github.com/kuntao-development/android_frameworks_base -b triton frameworks/base

echo 'Cloning frameworks native [4/18]'
# Native
rm -rf frameworks/native && git clone https://github.com/Astridxx/android_frameworks_native -b triton frameworks/native

echo 'Cloning frameworks libs net [5/18]'
# Libs net
rm -rf frameworks/libs/net && git clone https://github.com/kuntao-development/frameworks_libs_net -b lineage-20.0 frameworks/libs/net

echo 'Cloning connectivity modules [6/18]'
# Connectivity
rm -rf packages/modules/Connectivity && git clone https://github.com/kuntao-development/android_packages_modules_Connectivity -b triton packages/modules/Connectivity

echo 'Cloning display hal [7/18]'
# Clang
rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/kuntao-development/android_hardware_qcom_display -b lineage-20.0-caf-msm8996 hardware/qcom-caf/msm8996/display

echo 'Cloning networkstack modules [8/18]'
# Networkstack
rm -rf packages/modules/NetworkStack && git clone https://github.com/kuntao-development/android_packages_modules_NetworkStack -b lineage-20.0 packages/modules/NetworkStack

echo 'Cloning sepolicy legacy um [9/18]'
# Sepolicy-legacy-um
rm -rf device/qcom/sepolicy-legacy-um && git clone https://github.com/kuntao-development/android_device_qcom_sepolicy -b lineage-20.0-legacy-um device/qcom/sepolicy-legacy-um

echo 'Cloning system netd [10/18]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/platform_system_netd -b lineage-20.0 system/netd

echo 'Cloning system bpf [11/18]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-20.0 system/bpf

echo 'Cloning system libhidl [12/18]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-20.0 system/libhidl

echo 'Cloning system sepolicy [13/18]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/kuntao-development/android_system_sepolicy -b lineage-20.0 system/sepolicy

echo 'Cloning system core [14/18]'
# Core
rm -rf system/core && git clone https://github.com/kuntao-development/android_system_core -b triton system/core

echo 'Cloning system logging [15/18]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-20.0 system/logging

echo 'Cloning vendor awaken [16/18]'
# Awaken vendor
rm -rf vendor/awaken && git clone https://github.com/kuntao-development/android_vendor_awaken -b triton vendor/awaken

echo 'Cloning revamped fmradio [17/18]'
# Logging
git clone https://github.com/iusmac/RevampedFMRadio -b qcom packages/apps/RevampedFMRadio

echo 'Reseting hwui to android-13.0.0_r13 [18/18]'
cd frameworks/base && wget https://raw.githubusercontent.com/kuntao-development/android_device_lenovo_kuntao/awaken-13.0/patch/0009-hwui-reset-to-android-13.0.0_r13.patch && patch -p1 < *.patch && cd -

echo 'Completed, proceeding to lunch'
