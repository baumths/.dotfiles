#!/bin/bash

# Helpers

check_has_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
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

# Theme

install_shell_theme() {
  if [ -z "$1" ]; then
    echo "The shell theme was not specified. Skiping..."
    return;
  fi;

  gsettings set org.gnome.shell.extensions.user-theme name "$1"
  gsettings set org.gnome.desktop.interface gtk-theme "$1"
  gsettings set org.gnome.desktop.wm.preferences theme "$1"
}

install_wallpaper() {
  if [ -z "$1" ]; then
    echo "The wallpaper was not specified. Skiping..."
    return;
  fi;

  gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/.dotfiles/theme/wallpapers/$1"
}

install_icons() {
  if [ -z "$1" ]; then
    echo "The icon theme was not specified. Skiping..."
    return;
  fi;
  
  gsettings set org.gnome.desktop.interface icon-theme "$1"
}

install_themes() {
  install_wallpaper "nordic.jpg"
  
  install_icons "Flat-Remix-Blue-Dark"

  install_shell_theme "Nordic-darker-v40"
}

# Setup

setup_symlinks() {
  (
    pushd "$HOME/.dotfiles"

    echo "=====> Creating symlinks."
    
    stow -v git/
    stow -v zsh/
    stow -v nvim/
    stow -v kitty/
    stow -v lazygit/

    stow -v theme/ --ignore="wallpapers"

    echo "=====> Done creating symlinks."

    popd
  )
}

# Entrypoint
main () {
  check_has_sudo

  install_apt_pkgs
  
  setup_symlinks
  
  install_nvim
  install_lazygit
  install_docker
  install_flutter
  install_chrome
  install_spotify
  install_themes

  echo "======================> REMEMBER TO ADD REMAINING CONFIGS ======================"
}

main "$@"
