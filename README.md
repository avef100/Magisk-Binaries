
# Magisk-Binaries
magisk binaries extracted from the apk i built from the source code, includes: the impossible to find: magiskboot, magiskinit, busybox, magisk, and more. this only supports devices with an arm64 architecture, working on the other ones.

HOW TO USE:
im going to assume you know your way arount linux and git... so:
1. Clone this repository
2. cd Magisk-Binaries
3. run chmod +x on any executanle. ***make sure its an executable: eg. $ file magiskboot
   MAKE SURE YOUR BOOT.IMG IS IN THE MAGISK_BINARY DIRECTORY.
5. =linux executable.....
   NOW FOR THE GOOD PART
A. unpacking your boot.img
  $ ./magiskboot unpack boot.img
  $ ls
you will now find multiple files: kernel, kernel_dts and most importantly: THE RAMDISK.CPIO used for patching ./magiskboot cpio ramdisk.cpio "add 750 init /path/to/magiskinit"
finally, ./magiskboot repack boot.img

your out put will be a rooted patched boot image in the same directory call new-boot.img
