#!/bin/bash

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

install_flutter() {
  git clone -b stable --depth 1 https://github.com/flutter/flutter.git "$HOME/.local/share/flutter"
}

install_chrome() {
  wget -O - https://dl-ssl.google.com/linux/linux_signing_key.pub \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/google-chrome.gpg

  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
  | sudo tee /etc/apt/sources.list.d/google-chrome.list

  sudo apt update
  sudo apt install -yy google-chrome-stable
}

install_spotify() {
  wget -O - https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/spotify.gpg

  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" \
  | sudo tee /etc/apt/sources.list.d/spotify.list

  sudo apt update
  sudo apt install -yy spotify-client
}

setup_shell() {
  gsettings set org.gnome.desktop.interface show-battery-percentage "true"

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

  echo -e "\n=====> Installing Chrome..."
  install_chrome

  echo -e "\n=====> Installing Flutter..."
  install_flutter

  echo -e "\n=====> Installing Spotify..."
  install_spotify

  echo -e "\n=====> Updating Gnome Themes..."
  setup_shell

  echo -e "\n=====> Setting things up..."
  chsh -s $(which zsh) # set zsh as default shell

  echo -e "\n=====> Post install reminder:"
  echo "=====> -- GIT GPG KEY --"
  echo "=====> -- GITHUB SSH  --"

  echo -e "\n[*] Remember to restart your computer once done."
}

main "$@"
