#!/bin/bash
r='\033[0;31m'
g='\033[0;32m'
n='\033[0m'
b='\033[1m'
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
echo root:passwd | chpasswd

echo -e ${g}${b}You can add xorg to the installation packages, I usually add it at the DE or WM install script${n}
echo -e ${g}${b}You can remove the tlp package if you are installing on a desktop or vm${n}

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings
echo -e ${g}${b}Installing grub${n}
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
echo -e ${g}${b}Enabling services${n}
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
echo -e ${g}${b}Making Username as root and wheel users${n}
useradd -m Username
echo Username:passwd | chpasswd
groupadd libvirt
usermod -aG libvirt shreyansh
usermod -aG root shreyansh
usermod -aG wheel shreyansh
echo "shreyansh ALL=(ALL) ALL" >> /etc/sudoers.d/shreyansh
sed -i "82s/.//" /etc/sudoers
sed -i "82s/.//" /etc/sudoers
sed -i "82s/.//" /etc/sudoers
echo -e ${g}${b}Changing timezone to Timezone${n}
timedatectl set-timezone Timezone
timedatectl set-ntp true
hwclock --systohc
echo -e ${g}${b}Enabling the fastest and most updated mirror${n}
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
#Configuring initram for btrfs filesystem
#comment all these lines if you aren't using btrfs
sed -i '7s/./&btrfs/9' /etc/mkinitcpio.conf
sed -i '7s/./& i915/14' /etc/mkinitcpio.conf
sed -i '14s:.:&"/usr/bin/btrfs":10' /etc/mkinitcpio.conf
mkinitcpio -P linux
