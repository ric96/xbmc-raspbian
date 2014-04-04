#!/bin/bash
clear
echo "Updating System"
sudo apt-get update
sudo apt-get upgrade -y
echo "System Up-to-Date"
echo "Updateing XBMC"
echo "Downloading Updates"
git clone --depth 1 git://github.com/xbmc/xbmc-rbp.git
echo "Download Compleated"
echo "Preparing Update"
cd xbmc-rbp/
sed -i 's/USE_BUILDROOT=1/USE_BUILDROOT=0/' tools/rbp/setup-sdk.sh
sed -i 's/TOOLCHAIN=\/usr\/local\/bcm-gcc/TOOLCHAIN=\/usr/' tools/rbp/setup-sdk.sh
sudo sh tools/rbp/setup-sdk.sh
sed -i 's/cd $(SOURCE); $(CONFIGURE)/#cd $(SOURCE); $(CONFIGURE)/' tools/rbp/depends/xbmc/Makefile
make -C tools/rbp/depends/xbmc/
./configure --prefix=/usr --build=arm-linux-gnueabihf --host=arm-linux-gnueabihf \
--localstatedir=/var/lib --with-platform=raspberry-pi --disable-gl --enable-gles \
--disable-x11 --disable-sdl --enable-ccache --enable-optimizations \
--enable-external-libraries --disable-goom --disable-hal --disable-pulse \
--disable-vaapi --disable-vdpau --disable-xrandr --disable-airplay \
--disable-alsa --enable-avahi --disable-libbluray --disable-dvdcss \
--disable-debug --disable-joystick --enable-mid --disable-nfs --disable-profiling \
--disable-projectm --enable-rsxs --enable-rtmp --disable-vaapi \
--disable-vdadecoder --disable-external-ffmpeg  --disable-optical-drive
sed -i 's/-msse2//' lib/libsquish/Makefile
sed -i 's/-DSQUISH_USE_SSE=2//' lib/libsquish/Makefile
make
echo "Installing Updates"
sudo make install
cd
cd
echo "Update Compleated !!"
