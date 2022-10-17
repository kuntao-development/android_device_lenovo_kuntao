echo 'Starting to clone stuffs needed for kuntao'

echo 'Cloning kernel tree [1/11]'
# Kernel
rm -rf kernel/lenovo/msm8953 && git clone --depth=1 https://github.com/kuntao-development/android_kernel_lenovo_msm8953 -b lineage-19.1 kernel/lenovo/msm8953 

echo 'Cloning vendor tree [2/11]'
# Vendor
rm -rf vendor/lenovo/kuntao && git clone https://github.com/kuntao-development/proprietary_vendor_lenovo -b lineage-19.1 vendor/lenovo/kuntao

echo 'Cloning frameworks native [3/11]'
# Native
rm -rf frameworks/native && git clone https://github.com/kuntao-development/android_frameworks_native -b 12.1 frameworks/native

echo 'Cloning system netd [4/11]'
# Netd
rm -rf system/netd && git clone https://github.com/kuntao-development/android_system_netd -b lineage-19.1 system/netd

echo 'Cloning system bpf [5/11]'
# Bpf
rm -rf system/bpf && git clone https://github.com/kuntao-development/android_system_bpf -b lineage-19.1 system/bpf

echo 'Cloning system libhidl [6/11]'
# Hidl
rm -rf system/libhidl && git clone https://github.com/kuntao-development/android_system_libhidl -b lineage-19.1 system/libhidl

echo 'Cloning system sepolicy [7/11]'
# Sepolicy
rm -rf system/sepolicy && git clone https://github.com/LineageOS-UL/android_system_sepolicy -b lineage-19.1 system/sepolicy

echo 'Cloning system core [8/11]'
# Core
rm -rf system/core && git clone https://github.com/kuntao-development/android_system_core -b 12.1 system/core

echo 'Cloning system logging [9/11]'
# Logging
rm -rf system/logging && git clone https://github.com/kuntao-development/android_system_logging -b lineage-19.1 system/logging

echo 'Cloning vendor fm [10/11]'
# Fm
rm -rf vendor/qcom/opensource/fm-commonsys && git clone https://github.com/kuntao-development/android_vendor_qcom_opensource_fm-commonsys -b lineage-19.1 vendor/qcom/opensource/fm-commonsys

echo 'Cloning vendor lineage [11/11]'
# Lineage vendor
rm -rf vendor/lineage && git clone https://github.com/kuntao-development/android_vendor_crdroid -b 12.1 vendor/lineage

echo 'Completed, proceeding to lunch'
