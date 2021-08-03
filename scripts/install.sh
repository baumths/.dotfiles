#!/bin/bash

# Helpers

exists() {
  command -v "$1" >/dev/null 2>&1
}

# CLI tools & packages

install_apt_pkgs() {
  apt install -yy \
    stow \
    wget \
    software-properties-common \
    apt-transport-https \
    gnome-tweaks \
    gnome-shell-extensions \
    fonts-firacode
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

install_chrome() {
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
  apt update
  apt install -yy google-chrome-stable
}

install_code() {
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  apt install -yy code
}

## Revize this later, changed from snap to manual installation
install_flutter() {
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/flutter"

  apt install -yy \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev

  if ! exists flutter; then
    echo "Flutter not found. Did you add it to PATH?"
    export PATH="$PATH:$HOME/flutter/bin"
  fi;

  flutter doctor
  flutter config --enable-linux-desktop
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

install_theme() {
  install_wallpaper "nordic.jpg"
  
  install_icons "Flat-Remix-Blue-Dark"

  install_shell_theme "Nordic-darker-v40"
}

# Setup

setup_symlinks() {
  (
    pushd "$HOME/.dotfiles"

    echo "=====> Creating symlinks."
    
    stow -v bash/
    stow -v git/
    stow -v theme/ --ignore="wallpapers"

    echo "=====> Done creating symlinks."

    popd
  )
}

check_has_sudo() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
  fi;
}

# Entrypoint
main () {
  check_has_sudo

  install_apt_pkgs
  
  setup_symlinks
  
  install_chrome
  install_code
  install_docker
  install_flutter
  install_theme
}

main $@
