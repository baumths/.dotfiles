#!/bin/bash

# TODO: [ ] Install `lua` and its language server

# Helpers

exists() {
  command -v "$1" >/dev/null 2>&1
}

# CLI tools & packages

install_apt_pkgs() {
  sudo apt install -yy \
    zsh \
    fzf \
    stow \
    wget \
    curl \
    tree \
    kitty \
    lua5.4 \
    software-properties-common \
    apt-transport-https \
    gnome-tweaks \
    gnome-shell-extensions \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev
}

install_nvim() {
  sudo add-apt-repository ppa:neovim-ppa/unstable -yy
  sudo apt update
  sudo apt install -yy neovim
}

install_lazygit() {
  sudo add-apt-repository ppa:lazygit-team/release -yy
  sudo apt update
  sudo apt install -yy lazygit
}

install_docker() {
  curl -fsSL https://get.docker.com | bash
  sudo groupadd docker
  sudo usermod -aG docker "$USER"

  # easiest way to get `docker-compose`
  sudo apt install -yy python3-pip
  python3 -m pip install docker-compose
  sudo apt remove -yy python3-pip
}

## Revise this later, changed from snap to manual installation
install_flutter() {
  git clone -b stable --depth 1 https://github.com/flutter/flutter.git "$HOME/.local/share/flutter"

  if ! exists flutter; then
    echo -e "\n=====> Flutter not found. Did you add it to PATH?"
    export PATH="$PATH:$HOME/.local/share/flutter/bin"
  fi;

  flutter doctor
}

install_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  sudo apt update
  sudo apt install -yy google-chrome-stable
}

install_spotify() {
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update
  sudo apt install -yy spotify-client
}

# Looks

set_theme() {
  gsettings set org.gnome.shell.extensions.user-theme name ""
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
  gsettings set org.gnome.desktop.wm.preferences theme "Adwaita"
  gsettings set org.gnome.desktop.interface icon-theme "Adwaita"

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
  echo -e "\n=====> Installing apt packages..."
  install_apt_pkgs
  
  echo -e "\n=====> Creating symlinks..."
  setup_symlinks
  
  echo -e "\n=====> Installing Neovim..."
  install_nvim

  echo -e "\n=====> Installing Lazygit..."
  install_lazygit

  echo -e "\n=====> Installing Docker..."
  install_docker

  echo -e "\n=====> Installing Flutter..."
  install_flutter

  echo -e "\n=====> Installing Chrome..."
  install_chrome

  echo -e "\n=====> Installing Spotify..."
  install_spotify

  echo -e "\n=====> Updating Gnome Themes..."
  set_theme

  echo -e "\n=====> Setting things up..."
  chsh -s $(which zsh) # set zsh as default shell

  echo -e "\n=====> Post install reminder:"
  echo -e "\n=====> -- GIT GPG KEY --"
  echo -e "\n=====> -- GITHUB SSH  --"

  echo -e "\n[*] Remember to restart your computer once done."
}

main "$@"
