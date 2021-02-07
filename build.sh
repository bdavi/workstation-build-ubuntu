sudo apt-get update


#######################################################################
# Tools
#######################################################################
sudo apt-get --yes install curl git ranger highlight silversearcher-ag \
  tmux tree wget xclip exfat-fuse exfat-utils tldr shellcheck rofi

sudo snap install --classic heroku
sudo apt install x11-xserver-utils


#######################################################################
# zsh
#######################################################################
sudo apt-get --yes install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set default shell to zsh
sudo usermod -s /usr/bin/zsh $(whoami)

# External plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips

# MUST LOG OUT/IN HERE


#######################################################################
# i3
#######################################################################
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt-get update

sudo apt-get --yes install i3-gaps-wm
sudo apt-get --yes install i3lock
sudo apt-get --yes install picom
sudo apt-get --yes install nitrogen
sudo apt-get --yes install polybar


#######################################################################
# Dotfiles
#######################################################################
git clone https://github.com/bdavi/dotfiles.git ~/code/dotfiles
~/code/dotfiles/scripts/install_dotfiles


#######################################################################
# Vim
#######################################################################
sudo apt-get --yes install vim-gtk3 # use this instead of just vim for clipboard integration

# # Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +'PlugInstall --sync' +qa


#######################################################################
# Apps
#######################################################################
sudo apt-get --yes install audacity chromium-browser evince flameshot gimp peek \
  keepassxc libreoffice pinta speedcrunch sakura thunderbird virtualbox zeal \
  gparted pandoc stacer inkscape krusader

sudo snap install slack --classic
sudo snap install vlc

# Etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
sudo apt-get update
sudo apt-get --yes install balena-etcher-electron

# # Zotero
# wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
# sudo apt-get --yes update
# sudo apt-get --yes install zotero

# # syncthing
# # Add the release PGP keys:
# curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
# # Add the "stable" channel to your APT sources:
# echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
# # Update and install syncthing:
# sudo apt-get update
# sudo apt-get --yes install syncthing


#######################################################################
# Databases
#######################################################################
# Sqlite
sudo apt-get --yes install sqlite3 libsqlite3-dev sqlitebrowser

# Redis
sudo apt-get --yes install redis-server
sudo systemctl start redis-server.service
sudo systemctl enable redis-server.service

# Postgres
sudo apt-get --yes install postgresql postgresql-contrib libpq-dev

sudo systemctl start postgresql
sudo systemctl enable postgresql

curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt-get --yes install pgadmin4

sudo -u postgres psql postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql postgres -c "CREATE USER brian WITH SUPERUSER;"

# MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# MongoDB Compass
# Install by hand from here: https://www.mongodb.com/try/download/compass


#######################################################################
# Misc
#######################################################################
# Need this to make guard work with spring on larger projects.
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p


#######################################################################
# Languages using asdf-vm
#######################################################################
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

chmod +x $HOME/.asdf/asdf.sh
sudo $HOME/.asdf/asdf.sh
chmod +x $HOME/.asdf/completions/asdf.bash
sudo $HOME/.asdf/completions/asdf.bash

# Needed for most plugins
sudo apt-get --yes install \
  automake autoconf libreadline-dev \
  libncurses-dev libssl-dev libyaml-dev \
  libxslt-dev libffi-dev libtool unixodbc-dev \
  unzip curl

# MUST LOG OUT/IN HERE

asdf update

# Ruby
sudo apt-get --yes install autoconf bison build-essential \
  libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm-dev

asdf plugin-add ruby
asdf install ruby latest
asdf global ruby $(asdf latest ruby)

# MUST LOG OUT/IN HERE

gem install bundler
gem install guard
gem install rails
gem install rubocop

# Python
sudo apt-get --yes install --no-install-recommends make build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev

asdf plugin-add python

asdf install python 2.7.17
asdf install python latest
asdf global python $(asdf latest python) 2.7.17

pip install pylint

# Node
sudo apt-get --yes install dirmngr
sudo apt-get --yes install gpg
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install nodejs latest
asdf global nodejs $(asdf latest nodejs)

npm install -g ember-cli

# Yarn
asdf plugin-add yarn
asdf install yarn latest
asdf global yarn $(asdf latest yarn)

# Rust
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf install rust latest
asdf global rust $(asdf latest rust)

# Erlang
sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk

asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf install erlang latest
asdf global erlang $(asdf latest erlang)

# Elixir
# Make sure Erlang is installed
sudo apt-get install unzip

asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install elixir latest
asdf global elixir $(asdf latest elixir)


#######################################################################
# Manual Steps
#######################################################################
# 1. Setup Zeal docsets
# 2. SSH keys for github: `ssh-keygen -b 4096`
# 3. Firefox
#   - Canvas Fingerprint Defender
#   - Cookie AutoDelete
#   - Decentraleyes
#   - Ember Inspector
#   - HTTPS Everywhere
#   - KeePassXC
#   - LiveReload - Web extension
#   - Multi-Account Containers
#   - Privacy Badger
#   - React Developer Tools
#   - Vimuim C
#   - Zotero (https://www.zotero.org/download/)
#   - uBlock Origin
# 4. Syncthing shares
