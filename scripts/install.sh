#!/bin/bash

# HELPERS

add_gpg_key() {
  local link="$1"
  local file_name="$2"
  local file_path="/usr/share/keyrings/$file_name"

  if [[ -f "$file_path" ]]; then
    echo "GPG key [$file_name] already exists, skipping..."
  else
    wget -O- $link | sudo gpg --dearmor -o $file_path
    echo "GPG key [$file_name] added."
  fi
}

add_apt_source() {
  local file_name="$1"
  local content="$2"
  local file_path="/etc/apt/sources.list.d/$file_name"

  if [[ -f "$file_path" ]]; then
    echo "Apt source [$file_name] already exists, skipping..."
  else
    echo $content | sudo tee $file_path > /dev/null
    echo "Apt source [$file_name] added."
  fi
}

# INSTALLERS

install_apt_pkgs() {
  sudo apt install -yy \
    zsh \
    fzf \
    stow \
    wget \
    curl \
    tree \
    gnupg \
    kitty \
    lua5.4 \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    lsb-release \
    gnome-tweaks \
    gnome-shell-extensions \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    golang
}

install_neovim() {
  sudo add-apt-repository ppa:neovim-ppa/unstable -yy
  sudo apt update
  sudo apt install -yy neovim
}

install_lazygit() {
  go install github.com/jesseduffield/lazygit@latest
}

install_docker() {
  local gpg_key_link="https://download.docker.com/linux/ubuntu/gpg" 
  local gpg_key_file_name="docker-archive-keyring.gpg"
  local apt_source_file_name="docker.list"

  add_gpg_key "$gpg_key_link" "$gpg_key_file_name"

  local content=""
  content+="deb [arch=$(dpkg --print-architecture) "
  content+="signed-by=/usr/share/keyrings/$gpg_key_file_name] "
  content+="https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

  add_apt_source "$apt_source_file_name" "$content"

  sudo apt update
  sudo apt install -yy \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

  sudo groupadd docker
  sudo usermod -aG docker "$USER"
}

install_flutter() {
  git clone -b stable --depth 1 https://github.com/flutter/flutter.git "$HOME/.local/share/flutter"
}

install_chrome() {
  local gpg_key_link="https://dl-ssl.google.com/linux/linux_signing_key.pub" 
  local gpg_key_file_name="google-chrome.gpg"
  local apt_source_file_name="google-chrome.list"

  add_gpg_key "$gpg_key_link" "$gpg_key_file_name"

  local content=""
  content+="deb [arch=$(dpkg --print-architecture) "
  content+="signed-by=/usr/share/keyrings/$gpg_key_file_name] "
  content+="http://dl.google.com/linux/chrome/deb/ stable main"

  add_apt_source "$apt_source_file_name" "$content"

  sudo apt update
  sudo apt install -yy google-chrome-stable
}

# SETUP

setup_shell() {
  # ALT + RETURN = TERMINAL
  gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Alt>Return']"

  # Input Sources
  gsettings set org.gnome.desktop.input-sources mru-sources "[('xkb', 'us'), ('xkb', 'br')]"
  gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'br'), ('xkb', 'us')]"
  gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape', 'compose:ralt']"

  # Keybingings
  gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>q']"
  gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "['<Alt>F1']"
  gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Alt>f']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>1']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>2']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>3']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>4']"

  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 60
  gsettings set org.gnome.desktop.peripherals.keyboard delay 240
  xset r rate 240 60

  # Wallpapers
  local WALLPAPERS_SCRIPT="$HOME/.dotfiles/scripts/wallpapers.sh"
  if [[ -f $WALLPAPERS_SCRIPT ]]; then
    echo -e "\n=====> Installing Wallpapers..."
    chmod +x $WALLPAPERS_SCRIPT
    bash $WALLPAPERS_SCRIPT
  else
    echo -e "\n[!] Failed to setup wallpapers."
  fi
}

setup_symlinks() {
  pushd "$HOME/.dotfiles"

  stow -v git/
  stow -v zsh/
  stow -v nvim/
  stow -v kitty/
  stow -v lazygit/

  popd
}

# Entrypoint
main () {
  echo -e "\n=====> Installing apt packages..."
  install_apt_pkgs
  
  echo -e "\n=====> Creating symlinks..."
  setup_symlinks
  
  echo -e "\n=====> Installing Neovim..."
  install_neovim

  echo -e "\n=====> Installing Lazygit..."
  install_lazygit

  echo -e "\n=====> Installing Docker..."
  install_docker

  echo -e "\n=====> Installing Chrome..."
  install_chrome

  echo -e "\n=====> Installing Flutter..."
  install_flutter

  echo -e "\n=====> Updating Gnome Themes..."
  setup_shell

  echo -e "\n=====> Setting things up..."
  echo "Set default shell to zsh"
  chsh -s $(which zsh)

  echo -e "\n[*] Remember to restart your computer once done."
}

main "$@"
