#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:Hellocomputer@12my | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
#Installing grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
#Enabling services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
#Making shreyansh as root and wheel users
useradd -m shreyansh
echo shreyansh:Hellocomputer@12my | chpasswd
groupadd libvirt
usermod -aG libvirt shreyansh
usermod -aG wheel shreyansh
echo "shreyansh ALL=(ALL) ALL" >> /etc/sudoers.d/shreyansh
sed -i "82s/.//" /etc/sudoers
sed -i "82s/.//" /etc/sudoers
sed -i "82s/.//" /etc/sudoers
#Changing timezone to IST
timedatectl set-timezone Asia/Kolkata
timedatectl set-ntp true
hwclock --systohc
#Enabling the fastest and most updated mirror
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
#Setting up firewalld
firewall-cmd --add-port=1025-65535/tcp --permanent
firewall-cmd --add-port=1025-65535/udp --permanent
firewall-cmd --reload
#Enabling multilib database for pacman
sed -i "93s/.//" /etc/pacman.conf
sed -i "92s/.//" /etc/pacman.conf
pacman -Syy
#Installing AUR helper (yay)
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd
#Installing zram and timeshift for better performnce and backup
yay -S zramd timeshift timeshift-autosnap pamac
#Setting up zramd
sed -i "5s/.//" /etc/default/zramd
#Using 0.25 part of ram as zramd
sed -i "5s/1/0.25/" /etc/default/zramd
systemctl enable --now zramd
#Doing system upgrade
pacman -Syu
#Installing base packages for gnome
pacman -S xorg gdm gnome firefox gnome-tweaks simplescreenrecorder arc-gtk-theme arc-icon-theme obs-studio vlc dina-font tamsyn-font bdf-unifont ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-droid gnu-free-fonts ttf-ibm-plex ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family ttf-anonymous-pro ttf-cascadia-code ttf-fantasque-sans-mono ttf-fira-mono ttf-hack ttf-fira-code ttf-inconsolata ttf-jetbrains-mono ttf-monofur adobe-source-code-pro-fonts cantarell-fonts inter-font ttf-opensans gentium-plus-font ttf-junicode adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts noto-fonts-cjk noto-fonts-emoji
#Installing additional packages for user shreyansh
pacman -Sy samba mariadb gcc libreoffice-fresh jdk-openjdk jre-openjdk a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore gimp android-file-transfer obs-studio virtualbox openshot gnome-chess gnuchess gnome-weather telegram-desktop steam blender wine kdenlive neofetch screenfetch nautilus-share virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat edk2-ovmf npm snapd atom lollypop rhythmbox
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
