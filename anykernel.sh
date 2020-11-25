# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Extended Kernel by attack11 @ xda-developers
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=whyred
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel install
dump_boot;

case "$ZIPFILE" in
  *Hmp*)
    ui_print " " "You are flashing OC for HMP kernel..."
    zip_type=HMP
    ;;
  *Eas*)
    ui_print " " "You are flashing OC for EAS kernel..."
    zip_type=EAS
    ;;
esac

ui_print " " "Checking installed kernel type..."

kernel_name="$(uname -r)";
case "$kernel_name" in
  *Hmp*)
    ui_print " " "You are using HMP kernel..."
    kernel_type=HMP
    if [ "$kernel_type" != "$zip_type" ]; then
    ui_print " "; ui_print "You are trying to flash $zip_type zip over $kernel_type kernel, please use the correct zip!";
    exit 1;
    else
    ui_print " " "Everything its correct! Flashing..."
    cat $home/dtb > $split_img/kernel_dtb;
    fi;
    ;;
  *Eas*)
    ui_print " " "You are using EAS kernel..."
    kernel_type=EAS
    if [ "$kernel_type" != "$zip_type" ]; then
    ui_print " "; ui_print "You are trying to flash $zip_type zip over $kernel_type kernel, please use the correct zip!";
    exit 1;
    else
    ui_print " " "Everything its correct! Flashing..."
    cat $home/dtb > $split_img/kernel_dtb;
    fi;
    ;;
esac

write_boot;
## end install

