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
sudo cp smb.conf/smb.conf /etc/samba
sudo mkdir /var/lib/samba/usershares
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares
sudo smbpasswd -a shreyansh
sudo groupadd -r sambashare
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
#Using 0.25 part of ram as zram
sudo sed -i "5s/1/0.25/" /etc/default/zramd
sudo systemctl enable --now zramd
yay -S anydesk google-chrome webapp-manager snapd
sudo systemctl enable --now snapd
sudo snap install g-assist --candidate
sudo snap install video-downloader
pamac build onedrive-abraunegg
#Installing zsh shell with powerlevel10k
sudo pacman -S zsh
sudo chsh -s /usr/bin/zsh
#Installing ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Installing zsh theme powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo sed -i "18s:robbyrussell:powerlevel10k/powerlevel10k:" /home/shreyansh/.zshrc
#Adding autosuggestion and syntax highlighting plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo sed -i "80s/)/ /" .zshrc
sudo sed -i "81 i \ \ zsh-autosuggestions" /home/shreyansh/.zshrc
sudo sed -i "82 i \ \ zsh-syntax-highlighting" .zshrc
sudo sed -i "83 i )" .zshrc
#Installing gnome shell extensions
#DashToDock
git clone https://github.com/ewlsh/dash-to-dock/
cd dash-to-dock
git checkout ewlsh/gnome-40
make
make install
cd
#PopShell
sudo npm install typescript -g
git clone https://github.com/pop-os/shell.git
cd shell
make local-install
cd
#KDE Connect
wget https://github.com/GSConnect/gnome-shell-extension-gsconnect/releases/download/v46/gsconnect@andyholmes.github.io.zipunzip gsconnect@andyholmes.github.io.zip \ -d /home/shreyansh/.local/share/gnome-shell/extensions/gsconnect@andyholmes.github.io.zip
gnome-extensions install --force gsconnect@andyholmes.github.io.zip
#Alphabateical App Grid
git clone https://github.com/stuarthayhurst/alphabetical-grid-extension.git
cd alphabetical-grid-extension
./scripts/create-release.sh -i
cd
#Appindicator support
git clone https://github.com/ubuntu/gnome-shell-extension-appindicator.git
ln -s $PWD ~/.local/share/gnome-shell/extensions/appindicatorsupport@rgcjonas.gmail.com
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
#OpenWeather
yay -S gnome-shell-extension-openweather-git
gnome-extensions enable openweather-extension@jenslody.de
#Restarting gnome shell
busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
#Configuring OneDrive
onedrive
sudo reboot
