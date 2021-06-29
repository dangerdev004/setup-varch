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
#Alphabateical App Grid
git clone https://github.com/stuarthayhurst/alphabetical-grid-extension.git
cd alphabetical-grid-extension
./scripts/create-release.sh -i
cd
#PopShell
sudo npm install typescript -g
git clone https://github.com/pop-os/shell.git
cd shell
make local-install
cd
