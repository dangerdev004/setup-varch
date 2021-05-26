#Setting up firewalld
firewall-cmd --add-port=1025-65535/tcp --permanent
firewall-cmd --add-port=1025-65535/udp --permanent
firewall-cmd --reload
#Enabling multilib database for pacman
sed -i "93s/.//" /etc/pacman.conf
sed -i "92s/.//" /etc/pacman.conf
#Reconfiguring pacman
pacman -Syy
#Doing system upgrade
pacman -Syu
#Installing base packages for gnome
pacman -S xorg gdm gnome firefox gnome-tweaks simplescreenrecorder arc-gtk-theme arc-icon-theme obs-studio vlc dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji
#Installing additional packages for user shreyansh
pacman -Sy samba mariadb gcc krita libreoffice-fresh jdk-openjdk jre-openjdk a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore gimp android-file-transfer obs-studio virtualbox openshot gnome-chess gnuchess gnome-weather telegram-desktop steam blender wine kdenlive neofetch screenfetch nautilus-share virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat edk2-ovmf npm snapd atom lollypop rhythmbox
pamac build onedrive-abraunegg
flatpak install com.spotify.Client
flatpak install org.signal.Signal
flatpak install com.google.AndroidStudio
sudo systemctl enable --now libvirtd
sudo snap install g-assist
sudo snap install video-downloader
systemctl enable --now libvirtd
snap install g-assist --candidate
snap install video-downloader
#Setting up samba services
git clone https://github.com/ShreyanshShrivastava/smb.conf
cp -r smb.conf/smb.conf /etc/samba
testparm
smbpasswd -a shreyansh
mkdir /var/lib/samba/usershares
groupadd -r sambashare
chown root:sambashare /var/lib/samba/usershares
chmod 1770 /var/lib/samba/usershares
gpasswd sambashare -a shreyansh
firewall-cmd --zone=home --add-service={samba,samba-client,samba-dc} --permanent
firewall-cmd --reload
systemctl enable --now smb nmb
#Setting up mariadb
chattr +C /var/lib/mysql
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable --now mariadb

#Installing AUR helper (yay)
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd
#Installing zram and timeshift for better performnce and backup
yay -S zramd timeshift timeshift-autosnap pamac
#Installing chrome-gnome-shell
yay -S chrome-gnome-shell
#Setting up zramd
sed -i "5s/.//" /etc/default/zramd
#Using 0.25 part of ram as zramd
sed -i "5s/1/0.25/" /etc/default/zramd
systemctl enable --now zramd
yay -S anydesk google-chrome webapp-manager
