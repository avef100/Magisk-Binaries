#!/bin/bash

# Define paths
MAGISK_DIR="path/to/Magisk"
BOOT_IMG="boot.img"
PATCHED_BOOT_IMG="new-boot.img"

# Ensure magiskboot exists
if [ ! -f "$MAGISK_DIR/magiskboot" ]; then
    echo "magiskboot not found in $MAGISK_DIR"
    exit 1
fi

# Ensure boot.img exists
if [ ! -f "$BOOT_IMG" ]; then
    echo "boot.img not found!"
    exit 1
fi

# Unpack boot.img
echo "Unpacking boot.img..."
cd "$MAGISK_DIR"
./magiskboot unpack ../$BOOT_IMG

# Patch ramdisk
echo "Patching ramdisk..."
./magiskboot cpio ramdisk.cpio "add 0750 init ./init.magisk"
./magiskboot cpio ramdisk.cpio "patch"
./magiskboot cpio ramdisk.cpio "mkdir 0750 overlay.d"

# signing and verifying
echo "signing booot.img with avb keys. pretty cool, i know.."
./magiskboot sign ../$BOOT_IMG
echo "your boot.img has been signed with the seceret key" 
./magiskboot verify ../$BOOT_IMG
echo "YOUR BOOT.IMG HAS BEEN SCANNED FOR VERIFICATION, PLEASE INSPECT THE LINE RIGHT ABOVE ME FOR ANY ERRORS, AND PLACE AN ISSUE"
# Repack boot.img
echo "Repacking boot.img..."
./magiskboot repack ../$BOOT_IMG

# Move the patched boot image
mv new-boot.img ../$PATCHED_BOOT_IMG

# Flash the patched boot image
# echo "Flashing patched boot.img..."
# adb reboot bootloader
# fastboot flash boot ../$PATCHED_BOOT_IMG
# fastboot reboot

echo "pat yourself on the back... i did all the work thogh and im a machine.."
