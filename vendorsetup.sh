echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/15]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-19.1 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/15]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo_kuntao -b lineage-19.1 vendor/lenovo/kuntao

echo 'Cloning frameworks base [3/15]'
# Frameworks
rm -rf frameworks/base && git clone --depth=1 https://github.com/kuntao-development/android_frameworks_base-1 -b 12.1 frameworks/base

echo 'Cloning frameworks native [4/15]'
# Native
rm -rf frameworks/native && git clone https://github.com/kuntao-development/android_frameworks_native -b 12.1 frameworks/native

echo 'Cloning system netd [5/15]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/android_system_netd -b cr-12.1 system/netd

echo 'Cloning system bpf [6/15]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-19.1 system/bpf

echo 'Cloning system libhidl [7/15]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-19.1 system/libhidl

echo 'Cloning system sepolicy [8/15]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/kuntao-development/android_system_sepolicy -b lineage-19.1 system/sepolicy

echo 'Cloning system core [9/15]'
# Core
rm -rf system/core && git clone https://github.com/kuntao-development/android_system_core -b 12.1 system/core

echo 'Cloning system logging [10/15]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-19.1 system/logging

echo 'Cloning system lmkd [11/15]'
# Lmkd
rm -rf system/memory/lmkd && git clone https://github.com/crdroidandroid/android_system_memory_lmkd -b 12.0 system/memory/lmkd

echo 'Cloning deskclock [12/15]'
# DeskClock
rm -rf packages/apps/DeskClock && git clone https://github.com/Astridxx/android_packages_apps_DeskClock -b 12.1 packages/apps/DeskClock

echo 'Cloning display hal [13/15]'
# Display
rm -rf hardware/qcom-caf/msm8996/display && git clone https://github.com/kuntao-development/android_hardware_qcom_display -b lineage-19.1-caf-msm8996 hardware/qcom-caf/msm8996/display

echo 'Cloning vendor fm [14/15]'
# Fm
rm -rf vendor/qcom/opensource/fm-commonsys && git clone https://github.com/kuntao-development/android_vendor_qcom_opensource_fm-commonsys -b lineage-19.1 vendor/qcom/opensource/fm-commonsys

echo 'Cloning vendor lineage [15/15]'
# Lineage vendor
rm -rf vendor/lineage && git clone https://github.com/kuntao-development/android_vendor_crdroid -b 12.1 vendor/lineage

echo 'Completed, proceeding to lunch'
