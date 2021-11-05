#Enabling multilib database for pacman
sudo sed -i "93s/.//" /etc/pacman.conf
sudo sed -i "94s/.//" /etc/pacman.conf
#Reconfiguring pacman
sudo pacman -Syy
#Doing system upgrade
sudo pacman -Syu
#Installing base packages for gnome
sudo pacman -S gdm gnome firefox gnome-tweaks simplescreenrecorder arc-gtk-theme arc-icon-theme obs-studio vlc dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji awesome-terminal-fonts
#Installing additional packages for user shreyansh
sudo pacman -Sy samba mariadb gcc krita libreoffice-fresh jdk-openjdk jre-openjdk a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore gimp android-file-transfer obs-studio virtualbox openshot gnome-chess gnuchess gnome-weather telegram-desktop steam blender wine wine-mono wine-gecko kdenlive neofetch screenfetch nautilus-share virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat edk2-ovmf npm atom lollypop rhythmbox sassc
sudo systemctl enable --now libvirtd
#Setting up samba services
git clone https://github.com/dangerdev004/smb.conf
sudo cp smb.conf/smb.conf /etc/samba
sudo mkdir /var/lib/samba/usershares
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares
sudo smbpasswd -a shreyansh
sudo groupadd -r sambashare
sudo gpasswd sambashare -a shreyansh
systemctl enable --now smb nmb
#Setting up mariadb
sudo chattr +C /var/lib/mysql
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable --now mariadb
#Enabling gdm service on startup
sudo systemctl enable gdm
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
#Using 0.25 part of ram as zram
sudo sed -i "5s/1.0/0.25/" /etc/default/zramd
sudo systemctl enable --now zramd
yay -S anydesk google-chrome webapp-manager snapd
sudo systemctl enable --now snapd
sudo systemctl enable gdm
pamac build onedrive-abraunegg
#Installing zsh shell with powerlevel10k
sudo pacman -S zsh
sudo chsh -s /usr/bin/zsh
#Installing ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
