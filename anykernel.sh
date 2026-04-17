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

# Di dalam anykernel.sh
# Memaksa flag verifikasi tetap '0' agar bootloader tidak melapor ke Android bahwa sistem 'Corrupted'
ui_print "- Spoofing VBMeta flags..."
patch_vbmeta_flag=1; 

# Jangan pakai permissive! Pakai enforcing agar bank aman.
append_cmdline "androidboot.selinux=enforcing";
append_cmdline "androidboot.veritymode=enforcing";

write_boot;
## end install
