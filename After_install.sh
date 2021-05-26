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
