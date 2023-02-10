echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/18]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-20.0 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/18]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo_kuntao -b lineage-20.0 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/18]'
# Frameworks base
rm -rf frameworks/base && git clone --depth=1 https://github.com/Astridxx/android_frameworks_base -b thirteen frameworks/base

echo 'Cloning frameworks native [4/18]'
# Native
rm -rf frameworks/native && git clone https://github.com/Astridxx/android_frameworks_native-1 -b thirteen frameworks/native

echo 'Cloning frameworks libs net [5/18]'
# Libs net
rm -rf frameworks/libs/net && git clone https://github.com/Astridxx/android_frameworks_libs_net -b thirteen frameworks/libs/net

echo 'Cloning system memory lmkd [6/18]'
# Lmkd
rm -rf system/memory/lmkd && git clone https://github.com/LineageOS/android_system_memory_lmkd -b lineage-20.0 system/memory/lmkd

echo 'Cloning connectivity modules [7/18]'
# Connectivity
rm -rf packages/modules/Connectivity && git clone https://github.com/Astridxx/android_packages_modules_Connectivity -b thirteen packages/modules/Connectivity

echo 'Cloning display hal [8/18]'
# Clang
rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/kuntao-development/android_hardware_qcom_display -b lineage-20.0-caf-msm8996 hardware/qcom-caf/msm8996/display

echo 'Cloning networkstack modules [9/18]'
# Networkstack
rm -rf packages/modules/NetworkStack && git clone https://github.com/kuntao-development/android_packages_modules_NetworkStack -b lineage-20.0 packages/modules/NetworkStack

echo 'Cloning sepolicy legacy um [10/18]'
# Sepolicy-legacy-um
rm -rf device/qcom/sepolicy-legacy-um && git clone https://github.com/kuntao-development/android_device_qcom_sepolicy -b rice-20.0-legacy-um device/qcom/sepolicy-legacy-um

echo 'Cloning system netd [11/18]'
# Netd
rm -rf system/netd && git clone https://github.com/Astridxx/android_system_netd-1 -b thirteen system/netd

echo 'Cloning system bpf [12/18]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-20.0 system/bpf

echo 'Cloning system libhidl [13/18]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-20.0 system/libhidl

echo 'Cloning system sepolicy [14/18]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/Astridxx/android_system_sepolicy -b lineage-20.0 system/sepolicy

echo 'Cloning system core [15/18]'
# Core
rm -rf system/core && git clone https://github.com/Astridxx/android_system_core -b thirteen system/core

echo 'Cloning vendor rice [16/18]'
# Rice vendor
rm -rf vendor/lineage && git clone https://github.com/Astridxx/android_vendor_rice -b thirteen vendor/lineage

echo 'Cloning revamped fmradio [17/18]'
# Logging
git clone https://github.com/iusmac/RevampedFMRadio -b qcom packages/apps/RevampedFMRadio

echo 'Reseting hwui to android-13.0.0_r13 [18/18]'
cd frameworks/base && wget https://raw.githubusercontent.com/kuntao-development/android_device_lenovo_kuntao/awaken-13.0/patch/0009-hwui-reset-to-android-13.0.0_r13.patch && patch -p1 < *.patch && cd -

echo 'Completed, proceeding to lunch'
