#!/bin/bash

ARCH=$(dpkg --print-architecture);
cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex-sdk;
else apt install git -y && git clone https://github.com/xf0r3m/immudex-sdk;

fi
source ~/immudex-sdk/versions/template.sh;

echo "deb http://deb.debian.org/debian/ stable main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ stable main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security stable-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security stable-security main" >> /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ stable-updates main" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ stable-updates main" >> /etc/apt/sources.list;
update_packages;


if [ $ARCH = "amd64" ]; then
install_packages --no-install-recommends linux-image-amd64 live-boot systemd-sysv -y;
else
install_packages --no-install-recommends linux-image-686-pae live-boot systemd-sysv -y;
fi

install_packages --no-install-recommends network-manager net-tools iproute2 wireless-tools wget openssh-client alsa-utils firefox-esr icewm xserver-xorg-core xserver-xorg xinit xterm vim geany iputils-ping man man-db texinfo less ranger feh isc-dhcp-client whiptail locales keyboard-configuration console-setup curl xfe lightdm rsync git conky-all cryptsetup figlet file gnome-themes-extra sudo lolcat parted;

install_packages debootstrap squashfs-tools xorriso isolinux syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools openssh-server extlinux grub-efi-amd64;

ln -s /usr/games/lolcat /usr/bin;
cp -vv ~/immudex-sdk/files/lightdm-gtk-greeter.conf /etc/lightdm

if [ ! -d /usr/share/images/desktop-base ]; then
  mkdir -p /usr/share/images/desktop-base;
fi
cp -vv ~/immudex-sdk/images/d13_wallpaper.png /usr/share/images/desktop-base;
cp -vv ~/immudex-sdk/images/immudex_xfce_greeter_logo.png /usr/share/images/desktop-base;
cp -vv ~/immudex-sdk/images/lightdm_wallpaper.jpg /usr/share/images/desktop-base;
cp -vv ~/immudex-sdk/images/immudex-sdk.xpm /usr/share/images/desktop-base;

cp -rvv ~/immudex-sdk/files/icewm /root/.icewm;
cp -vv ~/immudex-sdk/files/conkyrc /root/.conkyrc;
cp -vv ~/immudex-sdk/files/vimrc /root/.vimrc;
cp -vv ~/immudex-sdk/files/xinitrc /root/.xinitrc;
ln /root/.xinitrc /root/.xsession;
cp -vv ~/immudex-sdk/files/XTerm /root/XTerm;
cp -vv ~/immudex-sdk/files/lightdm.conf /etc/lightdm;
cp -vv ~/immudex-sdk/files/lightdm-autologin /etc/pam.d;

cp -vv ~/immudex-sdk/tools/immudex-motd2 /usr/local/bin;
cp -vv ~/immudex-sdk/tools/library.sh /usr/local/bin;
cp -vv ~/immudex-sdk/tools/immudex-build-menu /usr/local/bin;
cp -vv ~/immudex-sdk/tools/immudex-build-show-log /usr/local/bin;
cp -vv ~/immudex-sdk/tools/immudex-crypt /usr/local/bin;
cp -vv ~/immudex-sdk/tools/immudex-create-media /usr/local/bin;
cp -vv ~/immudex-sdk/tools/immudex-install /usr/local/bin;
cp -vv ~/immudex-sdk/tools/immudex-upgrade /usr/local/bin;

chmod +x /usr/local/bin/*;


cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/immudex-motd2
touch /tmp/.motd;
fi
EOL

echo "alias immudex-chhome='export HOME=\$(pwd)'" >> /etc/bash.bashrc;

echo "root:toor" | chpasswd;

echo "immudex-sdk" > /etc/hostname
echo "127.0.1.1 immudex-sdk" >> /etc/hosts

sed -i '/^#PermitRootLogin/s/#//' /etc/ssh/sshd_config
sed -i '/^PermitRootLogin/s/prohibit-password/yes/' /etc/ssh/sshd_config
systemctl disable ssh.service;

tidy;
