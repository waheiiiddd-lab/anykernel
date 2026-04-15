# AnyKernel3 Ramdisk Mod Script
# By zixine

## AnyKernel setup
# set up layouts and directories
properties() { '
kernel.string=zixine-elysium-universal by @waheiiiddd-lab
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
'; }

# shell variables
block=/dev/block/by-name/boot;
is_slot_device=auto;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

# [PENTING] Menghapus Verifikasi AVB/DM-Verity dari fstab ramdisk
# Ini mencegah pesan "Your device is corrupted" pada Advan/Itel
if [ -d $ramdisk/fstab* ]; then
  ui_print "- Patching fstab to disable DM-Verity..."
  sed -i "s/,avb_pubkey=.*//g" $ramdisk/fstab*;
  sed -i "s/,avb=.*//g" $ramdisk/fstab*;
  sed -i "s/,verify//g" $ramdisk/fstab*;
  sed -i "s/wait,avb/wait/g" $ramdisk/fstab*;
fi

# Sebagai gantinya, biarkan default atau gunakan Enforcing
append_cmdline "androidboot.selinux=enforcing";
append_cmdline "patch_vbmeta_flag=1";

write_boot;
## end install
