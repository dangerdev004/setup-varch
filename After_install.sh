#Setting up firewalld
sudo firewall-cmd --add-port=1025-65535/tcp --permanent
sudo firewall-cmd --add-port=1025-65535/udp --permanent
sudo firewall-cmd --reload
#Enabling multilib database for pacman
sudo sed -i "93s/.//" /etc/pacman.conf
sudo sed -i "92s/.//" /etc/pacman.conf
#Reconfiguring pacman
sudo pacman -Syy
#Doing system upgrade
sudo pacman -Syu
#Installing base packages for gnome
sudo pacman -S xorg gdm gnome firefox gnome-tweaks simplescreenrecorder arc-gtk-theme arc-icon-theme obs-studio vlc dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji
#Installing additional packages for user shreyansh
sudo pacman -Sy samba mariadb gcc krita libreoffice-fresh jdk-openjdk jre-openjdk a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore gimp android-file-transfer obs-studio virtualbox openshot gnome-chess gnuchess gnome-weather telegram-desktop steam blender wine kdenlive neofetch screenfetch nautilus-share virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat edk2-ovmf npm atom lollypop rhythmbox
flatpak install com.spotify.Client
flatpak install org.signal.Signal
flatpak install com.google.AndroidStudio
sudo systemctl enable --now libvirtd
#Setting up samba services
git clone https://github.com/ShreyanshShrivastava/smb.conf
sudo cp -r smb.conf/smb.conf /etc/samba
testparm
sudo smbpasswd -a shreyansh
sudo mkdir /var/lib/samba/usershares
sudo groupadd -r sambashare
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares
sudo gpasswd sambashare -a shreyansh
sudo firewall-cmd --zone=home --add-service={samba,samba-client,samba-dc} --permanent
sudo firewall-cmd --reload
systemctl enable --now smb nmb
#Setting up mariadb
chattr +C /var/lib/mysql
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb
#Installing AUR helper (yay)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
#Installing zram and timeshift for better performnce and backup
yay -S zramd timeshift timeshift-autosnap pamac
#Installing chrome-gnome-shell
yay -S chrome-gnome-shell
#Setting up zramd
sudo sed -i "5s/.//" /etc/default/zramd
#Using 0.25 part of ram as zramd
sudo sed -i "5s/1/0.25/" /etc/default/zramd
sudo systemctl enable --now zramd
yay -S anydesk google-chrome webapp-manager snapd
sudo snap install g-assist --candidate
sudo snap install video-downloader
