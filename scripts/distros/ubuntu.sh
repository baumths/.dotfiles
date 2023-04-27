#!/bin/bash

add_gpg_key() {
  local URL="$1"
  local FILE_NAME="$2"
  local FILE_PATH="/usr/share/keyrings/$FILE_NAME"

  if [[ -f "$FILE_PATH" ]]; then
    echo "[*] GPG key [$FILE_NAME] already exists, skipping..."
  else
    wget -O- $URL | sudo gpg --dearmor -o $FILE_PATH
    echo "[*] GPG key [$FILE_NAME] added."
  fi
}

add_apt_source() {
  local FILE_NAME="$1"
  local CONTENT="$2"
  local FILE_PATH="/etc/apt/sources.list.d/$FILE_NAME"

  if [[ -f "$FILE_PATH" ]]; then
    echo "[*] Apt source [$FILE_NAME] already exists, skipping..."
  else
    echo $CONTENT | sudo tee $FILE_PATH > /dev/null
    echo "[*] Apt source [$FILE_NAME] added."
  fi
}

install_packages() {
  sudo apt install -yy \
    zsh \
    fzf \
    exa \
    stow \
    wget \
    curl \
    tmux \
    xclip \
    gnupg \
    kitty \
    rustc \
    cargo \
    golang \
    lua5.4 \
    ripgrep \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnome-tweaks \
    gnome-shell-extensions \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev
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
  local GPG_KEY_LINK="https://download.docker.com/linux/ubuntu/gpg" 
  local GPG_KEY_FILE_NAME="docker-archive-keyring.gpg"
  local APT_SOURCE_FILE_NAME="docker.list"

  add_gpg_key "$GPG_KEY_LINK" "$GPG_KEY_FILE_NAME"

  local CONTENT=""
  CONTENT+="deb [arch=$(dpkg --print-architecture) "
  CONTENT+="signed-by=/usr/share/keyrings/$GPG_KEY_FILE_NAME] "
  CONTENT+="https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

  add_apt_source "$APT_SOURCE_FILE_NAME" "$CONTENT"

  sudo apt update
  sudo apt install -yy \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

  sudo groupadd docker
  sudo usermod -aG docker "$USER"
}

install_chrome() {
  local GPG_KEY_LINK="https://dl-ssl.google.com/linux/linux_signing_key.pub" 
  local GPG_KEY_FILE_NAME="google-chrome.gpg"
  local APT_SOURCE_FILE_NAME="google-chrome.list"

  add_gpg_key "$GPG_KEY_LINK" "$GPG_KEY_FILE_NAME"

  local CONTENT=""
  CONTENT+="deb [arch=$(dpkg --print-architecture) "
  CONTENT+="signed-by=/usr/share/keyrings/$GPG_KEY_FILE_NAME] "
  CONTENT+="http://dl.google.com/linux/chrome/deb/ stable main"

  add_apt_source "$APT_SOURCE_FILE_NAME" "$CONTENT"

  sudo apt update
  sudo apt install -yy google-chrome-stable
}

main () {
  echo -e "\n[*] Installing apt Packages..."
  install_packages
  
  echo -e "\n[*] Installing Neovim..."
  install_neovim

  echo -e "\n[*] Installing Lazygit..."
  install_lazygit

  echo -e "\n[*] Installing Docker..."
  install_docker

  echo -e "\n[*] Installing Chrome..."
  install_chrome
}

main "$@"
