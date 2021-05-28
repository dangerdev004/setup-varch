sudo snap install g-assist --candidate
sudo snap install video-downloader
flatpak install com.spotify.Client
flatpak install org.signal.Signal
flatpak install com.google.AndroidStudio
#Installing zsh theme powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sudo sed -i "11s:robbyrussell:powerlevel10k/powerlevel10k:" /home/shreyansh/.zshrc
#Adding autosuggestion and syntax highlighting plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo sed -i "73s/)/ /" .zshrc
sudo sed -i "74 i \ \ zsh-autosuggestions" /home/shreyansh/.zshrc
sudo sed -i "75 i \ \ zsh-syntax-highlighting" .zshrc
sudo sed -i "76 i )" .zshrc
#Installing gnome shell extensions
#DashToDock
git clone https://github.com/ewlsh/dash-to-dock/
cd dash-to-dock
git checkout ewlsh/gnome-40
make
make install
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
#PopShell
sudo npm install typescript -g
git clone https://github.com/pop-os/shell.git
cd shell
make local-install
cd
sudo reboot
onedrive
onedrive --synchronize
sudo reboot
