#!/bin/bash

printf "\e[92m"; echo '
 __  __               ___  ____     ___  
|  \/  | __ _  ___   / _ \/ ___|   ( _ ) 
| |\/| |/ _` |/ __| | | | \___ \   / _ \ 
| |  | | (_| | (__  | |_| |___) | | (_) |
|_|  |_|\__,_|\___|  \___/|____/   \___/ 

'; printf "\e[0m"; sleep 2
source ../assets/func.sh
usercheck
updateinfo
MacOS_version 8

sudo apt install -y automake gobjc libudev-dev xa65 build-essential byacc texi2html \
                    flex libreadline-dev unzip libxaw7-dev texinfo libxaw7-dev unar \
                    libgtk2.0-cil-dev libgtkglext1-dev libpulse-dev bison libnet1 \
                    libnet1-dev libpcap0.8 libpcap0.8-dev libvte-dev libasound2-dev \
                    raspberrypi-kernel-headers

# Mac OS 8 config
echo "
rom    ${MACOS_DIR}/QUAD650.ROM
disk   ${MACOS_DIR}/hdd.dsk
frameskip 2
ramsize 67108864
ether slirp
modelid 14
fpu true
nosound false
nocdrom false
nogui false
jit false
jitfpu false
jitdebug false
mousewheelmode 1
mousewheellines 3
mixer
ignoresegv true
idlewait true
seriala /dev/tnt1
serialb /dev/null
udptunnel false
extfs /home/pi/Downloads
# screen dga/800/600
screen win/640/480
" > ${MACOS_CONFIG}


# ROM & System
cd ${MACOS_DIR}
wget ${ROM}
mv Quadra-650.ROM QUAD650.ROM 2>/dev/null
wget -O ${MACOS_DIR}/hdd.dsk.gz ${HDD_IMAGE}
echo "* Decompressing the hard drive image - please wait"
gzip -d hdd.dsk.gz


# SDL2 check && builder
[ -f $SDL2_FILE ] || Build_SDL2;

# BasiliskII check && builder
[ -f $BASILISK_FILE ] || Build_BasiliskII;

echo "* Mac OS 8 installation complete"
sleep 2

