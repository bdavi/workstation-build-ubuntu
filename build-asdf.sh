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

asdf update

# Ruby
sudo apt-get --yes install autoconf bison build-essential \
  libssl-dev libyaml-dev libreadline6-dev zlib1g-dev \
  libncurses5-dev libffi-dev libgdbm-dev

asdf plugin-add ruby
asdf install ruby latest
asdf global ruby $(asdf latest ruby)

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
asdf global rust $(asdf latest yarn)
