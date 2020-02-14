set -e
sudo apt-get update


#######################################################################
# Tools
#######################################################################
sudo apt-get --yes install curl
sudo apt-get --yes install git
sudo apt-get --yes install ranger
sudo apt-get --yes install silversearcher-ag
sudo apt-get --yes install tmux
sudo apt-get --yes install tree
sudo apt-get --yes install wget
sudo apt-get --yes install xclip
sudo apt-get --yes install exfat-fuse exfat-utils
sudo apt-get --yes install tldr

sudo snap install --classic heroku


#######################################################################
# zsh
#######################################################################
sudo apt-get --yes install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set default shell to zsh
sudo usermod -s /usr/bin/zsh $(whoami)

# External plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone https://github.com/djui/alias-tips.git ~ZSH_CUSTOM/plugins/alias-tips


#######################################################################
# Dotfiles
#######################################################################
git clone https://github.com/bdavi/dotfiles.git ~/code/dotfiles
~/code/dotfiles/scripts/install_dotfiles


#######################################################################
# Vim
#######################################################################
sudo apt-get --yes install vim

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugInstall --sync' +qa


#######################################################################
# Apps
#######################################################################
sudo apt-get --yes install audacity
sudo apt-get --yes install chromium-browser
sudo apt-get --yes install doublecmd-gtk
sudo apt-get --yes install evince
sudo apt-get --yes install flameshot
sudo apt-get --yes install gimp
sudo apt-get --yes install kazam
sudo apt-get --yes install keepassxc
sudo apt-get --yes install libreoffice
sudo apt-get --yes install pinta
sudo apt-get --yes install speedcrunch
sudo apt-get --yes install terminator
sudo apt-get --yes install thunderbird
sudo apt-get --yes install virtualbox
sudo apt-get --yes install zeal
sudo apt-get --yes install gparted
sudo apt-get --yes install pandoc

sudo snap install slack --classic
sudo snap install spotify
sudo snap install vlc

# Etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo apt-get update
sudo apt-get install balena-etcher-electron

# Zotero
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
sudo apt-get --yes update
sudo apt-get --yes install zotero

# Albert
# This works for Ubuntu 19.04. Double check this for anything else
# https://software.opensuse.org/download.html?project=home:manuelschneid3r&package=albert
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_19.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_19.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get --yes install albert

# syncthing
# Add the release PGP keys:
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
# Add the "stable" channel to your APT sources:
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
# Update and install syncthing:
sudo apt-get update
sudo apt-get --yes install syncthing

# Stacer
# Not available yet for Ubuntu 19.10
sudo add-apt-repository --yes ppa:oguzhaninan/stacer
sudo apt-get update
sudo apt-get --yes install stacer


#######################################################################
# Databases
#######################################################################
# Sqlite
sudo apt-get --yes install sqlite3
sudo apt-get --yes install libsqlite3-dev
sudo apt-get --yes install sqlitebrowser

# Redis
sudo apt-get --yes install redis-server
sudo systemctl start redis-server.service
sudo systemctl enable redis-server.service

# Postgres
sudo apt-get --yes install postgresql postgresql-contrib libpq-dev
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo apt-get --yes install pgadmin3
sudo -u postgres psql postgres -c "alter user postgres with password 'postgres';"


#######################################################################
# Misc
#######################################################################
# Need this to make guard work with spring on larger projects.
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
