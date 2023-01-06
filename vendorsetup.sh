echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/20]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-19.1 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/20]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo_kuntao -b lineage-19.1 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/20]'
# frameworks base
rm -rf frameworks/base && git clone --depth=1 https://github.com/Astridxx/platform_frameworks_base -b arcadia-next frameworks/base

echo 'Cloning frameworks native [4/20]'
# Native
rm -rf frameworks/native && git clone https://github.com/Astridxx/platform_frameworks_native -b arcadia-next frameworks/native

echo 'Cloning system netd [5/20]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/android_system_netd -b lineage-19.1 system/netd

echo 'Cloning system bpf [6/20]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-19.1 system/bpf

echo 'Cloning system libhidl [7/20]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-19.1 system/libhidl

echo 'Cloning system sepolicy [8/20]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/LineageOS-UL/android_system_sepolicy -b lineage-19.1 system/sepolicy

echo 'Cloning system core [9/20]'
# Core
rm -rf system/core && git clone https://github.com/Astridxx/android_system_core -b arcadia-next system/core

echo 'Cloning system bt [10/20]'
# BT
rm -rf system/bt && git clone https://github.com/kuntao-development/system_bt -b twelve system/bt

echo 'Cloning system logging [11/20]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-19.1 system/logging

echo 'Cloning vendor fm [12/20]'
# Fm
rm -rf vendor/qcom/opensource/fm-commonsys && git clone https://github.com/kuntao-development/android_vendor_qcom_opensource_fm-commonsys -b lineage-19.1 vendor/qcom/opensource/fm-commonsys

echo 'Cloning deskclock [13/20]'
# DeskClock
rm -rf packages/apps/DeskClock && git clone https://github.com/Astridxx/android_packages_apps_DeskClock -b 12.1 packages/apps/DeskClock

echo 'Cloning display hal [14/20]'
# Clang
rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/kuntao-development/android_hardware_qcom_display -b lineage-19.1-caf-msm8996 hardware/qcom-caf/msm8996/display

echo 'Cloning build make [15/20]'
# Build make
rm -rf build/make && git clone https://github.com/Astridxx/platform_build_make -b arcadia-next build/make

echo 'Cloning launcher3 [16/20]'
# Launcher3
rm -rf packages/apps/Launcher3 && git clone https://github.com/Astridxx/platform_packages_apps_Launcher3 -b arcadia-next packages/apps/Launcher3

echo 'Cloning build soong [17/20]'
# Build soong
rm -rf build/soong && git clone https://github.com/Astridxx/platform_build_soong -b arcadia-next build/soong

echo 'Cloning settings [18/20]'
# Settings
rm -rf packages/apps/Settings && git clone https://github.com/Astridxx/platform_packages_apps_Settings -b arcadia-next packages/apps/Settings

echo 'Cloning sepolicy legacy um [19/20]'
# Sepolicy-legacy-um
rm -rf device/qcom/sepolicy-legacy-um && git clone https://github.com/Astridxx/android_device_qcom_sepolicy -b bliss-legacy-um device/qcom/sepolicy-legacy-um

echo 'Cloning vendor bliss [20/20]'
# Bliss vendor
rm -rf vendor/bliss && git clone https://github.com/Astridxx/platform_vendor_bliss -b arcadia-next vendor/bliss

echo 'Completed, proceeding to lunch'
