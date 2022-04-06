#!/bin/bash

# TODO: [ ] Install `lua` and its language server

# Helpers

check_has_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
  fi
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

# CLI tools & packages

install_apt_pkgs() {
  apt install -yy \
    zsh \
    fzf \
    stow \
    wget \
    tree \
    kitty \
    software-properties-common \
    apt-transport-https \
    gnome-session \
    gnome-tweaks \
    gnome-shell-extensions
}

install_nvim() {
  add-apt-repository ppa:neovim-ppa/unstable -yy
  apt update
  apt install -yy neovim
}

install_lazygit() {
  add-apt-repository ppa:lazygit-team/release -yy
  apt update
  apt install -yy lazygit
}

install_docker() {
  curl -fsSL https://get.docker.com | bash
  groupadd docker
  usermod -aG docker "$USER"

  # easiest way to get `docker-compose`
  apt install -yy python3-pip
  python3 -m pip install docker-compose
  apt remove -yy python3-pip
}

## Revise this later, changed from snap to manual installation
install_flutter() {
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/.local/share/flutter"

  apt install -yy \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev

  if ! exists flutter; then
    echo "Flutter not found. Did you add it to PATH?"
    export PATH="$PATH:$HOME/.local/share/flutter/bin"
  fi;

  flutter doctor
}

install_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  apt update
  apt install -yy google-chrome-stable
}

install_spotify() {
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  apt update
  apt install -yy spotify-client
}

# Looks

set_theme() {
  gsettings set org.gnome.shell.extensions.user-theme name ""
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
  gsettings set org.gnome.desktop.wm.preferences theme "Adwaita"
  gsettings set org.gnome.desktop.interface icon-theme "Adwaita"

  # Wallpapers
  local WALLPAPERS_SCRIPT="$HOME/.dotfiles/scripts/wallpapers.sh"
  if [[ -f $WALLPAPERS_SCRIPT]]; then
    echo "=====> Installing Wallpapers..."
    chmod +x $WALLPAPERS_SCRIPT
    bash $WALLPAPERS_SCRIPT
  else
    echo "[!] Failed to setup wallpapers."
  fi
}

# Setup

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
  check_has_sudo

  echo "=====> Installing apt packages..."
  install_apt_pkgs
  
  echo "=====> Creating symlinks..."
  setup_symlinks
  
  echo "=====> Installing Neovim..."
  install_nvim

  echo "=====> Installing Lazygit..."
  install_lazygit

  echo "=====> Installing Docker..."
  install_docker

  echo "=====> Installing Flutter..."
  install_flutter

  echo "=====> Installing Chrome..."
  install_chrome

  echo "=====> Installing Spotify..."
  install_spotify

  echo "=====> Updating Gnome Themes..."
  set_theme

  echo "=====> Post install reminder:"
  echo "=====> -- GIT GPG KEY --"
  echo "=====> -- GITHUB SSH  --"
}

main "$@"
