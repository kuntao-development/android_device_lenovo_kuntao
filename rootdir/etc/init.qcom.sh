#!/vendor/bin/sh
# Copyright (c) 2009-2017, 2021-2022, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# Make modem config folder and copy firmware config to that folder for RIL
#
if [ -f /data/vendor/modem_config/ver_info.txt ]; then
    prev_version_info=`cat /data/vendor/modem_config/ver_info.txt`
else
    prev_version_info=""
fi

cur_version_info=`cat /vendor/firmware_mnt/verinfo/ver_info.txt`
if [ ! -f /vendor/firmware_mnt/verinfo/ver_info.txt -o "$prev_version_info" != "$cur_version_info" ]; then
    # add W for group recursively before delete
    chmod g+w -R /data/vendor/modem_config/*
    rm -rf /data/vendor/modem_config/*
    # preserve the read only mode for all subdir and files
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mbn_ota.txt /data/vendor/modem_config/mbn_ota.txt
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/apac/reliance/commerci/mcfg_sw.mbn /data/vendor/modem_config/rjil.mbn
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/eu/3uk/3uk/mcfg_sw.mbn /data/vendor/modem_config/3uk_gb.mbn
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/sea/smartfre/commerci/mcfg_sw.mbn /data/vendor/modem_config/smartfren.mbn
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/sea/ytl/gen_3gpp/mcfg_sw.mbn /data/vendor/modem_config/ytl.mbn
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/common/gcf/gen_3gpp/mcfg_sw.mbn /data/vendor/modem_config/gcf.mbn
    cp --preserve=m -d /vendor/firmware_mnt/image/modem_pr/mcfg/configs/mcfg_sw/generic/row/default/gen_3gpp/mcfg_sw.mbn /data/vendor/modem_config/row.mbn
    cp --preserve=m -d /vendor/firmware_mnt/verinfo/ver_info.txt /data/vendor/modem_config/
    # the group must be root, otherwise this script could not add "W" for group recursively
    chown -hR radio.root /data/vendor/modem_config/*
fi
chmod g-w /data/vendor/modem_config
setprop ro.vendor.ril.mbn_copy_completed 1
