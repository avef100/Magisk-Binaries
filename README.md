USAGE: patch, sign, and verify your boot.img by hand. becuase why the hell not, and maybe im obssed with toying with firmware images. or maybe i have to much time on my hand, or maybe, just maybe, im paranoid and scared my phone is spying on me and therefore cant use magisk, so ill get crafty and patch it by hand ;)

#CREDITS
All credits should be redirected to the absolute genius, Topjohnwu, the creater of the magic, and he also made magisk. (see what i did there)

# Magisk-Binaries
magisk binaries extracted from a magisk apk i built from the source code, includes: the impossible to find: magiskboot, magiskinit, busybox, magisk, and more. this only supports devices with an arm64 architecture, working on the other ones.

DO NOT USE THE SCRIPT UNLESS YOU ARE ABLE TO CUSTOMIZE IT AND FIX ANY ERRORS I MADE WHILE WRITING IT.  ADDITIONALLY THE SCRIPT HAS THE OPTION TO TAKE A REGULAR BOOT.IMG AND PATCH IT AND FLASH IT IN FASTBOOT FOR YOU. ONLY IF YOU UNCOMMENT THE LAST COUPLE LINES AND EDIT IT. (I AM GOING TO GET HELP FROM A ONE OF MY CLOSEST FRIENDS SE7EN (SHOT OUT TO HIM FOR ENCOURAGING ME TO DO ALL THE WORK IM DOING) PERFECTING THE SCRIPT)
HOW TO USE:
im going to assume you know your way arount linux and git... so:
1. Clone this repository  
2. cd Magisk-Binaries
3. run chmod +x on any executanle. ***make sure its an executable: eg. $ file magiskboot outpt: =linux executable.....

$ ./git clone https://github.com/avef100/Magisk-Binaries
$ ./cd Magisk-Bnaries
$ ./chmod 755 magiskboot
$ ./file magiskboot  #double check output says executable

EXTRACT YOUR BOOT IMAGE--FROM ROOTED PHONE (OTHERWISE GET IT FROM AP_XXXX_...tar.md5 INF FIRMWARE PACKAGE)

$ ./adb shell
$ ./su
$ ./dd if=/dev/block/by-name/boot of=/sdcard/boot.img
$ ./exit
$ ./adb pull /sdcard/boot.img

    NOW FOR THE GOOD PART
A. unpacking your boot.img
  $./magiskboot unpack boot.img

you will now have 3 new files.

l. ramdisk.cpio     # The patcher 

ll. kernel          # If you are patching your boot image manualy just for shits and giggles, i better hope you know    what that is :)

lll. kernel_dt      # what i said above lol but just in case ill give you a hint: DT= device tree

!!!HERE IS WHERE THE REAL MAGISK HAPPENS!!!
b. Applying patches
# (at any point aftter injecting the init script, you can apply your own patches only if you are an expert and know wtf you are doing. always run the verification command at the end to make sure you didnt screw up the patch.)


$ ./magiskboot cpio ramdisk.cpio "add 0750 init ./magiskinit"  # Add Magisk init script

$ ./magiskboot cpio ramdisk.cpio "patch"                       # Apply Magisk patches

$ ./magiskboot cpio ramdisk.cpio "mkdir 0750 overlay.d"        # Create required directory

NOW ITS TIME TO SIGN IT WITH.....WAIT FOR IT.....THE OFFICIAL AVB KEYS

$ ./magiskboot sign boot.img      # [x509.pem pk8]  signing the img
$ ./magiskboot verify boot.img    # [x509.pem] verification will tell you if its integrity was affected (look for something li "unexpected" in the bottom line.) it will also say primitive or permisive.. it will tell you if it worked....

c. REPAACKING
$ ./magiskboot repack boot.img

your out put will be a rooted patched boot image in the same directory call new-boot.img

check out my script TEMPLATE (still in the works) which patches it for you and if uncommented, will also flash it with fastboot.

OFFICIAL MAGISKBOOT MAN PAGE
./magiskboot --help
