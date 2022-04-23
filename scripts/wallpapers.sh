#!/bin/bash

WALLPAPERS_DIR="$HOME/.local/wallpapers"
DEFAULT_WALLPAPER="014.jpg"

check_has_ssh() {
  read -t 30 -p "Did you remember to add the Github SSH keys? [y/N] " answer

  if [[ "$answer" != "y" ]]; then
    echo -e "\n=====> Unable to setup wallpapers..."
    exit 1
  fi
}

maybe_clone_repo() {
  local REPO="git@github.com:mbaumgartenbr/wallpapers.git"

  if [[ ! -d "$WALLPAPERS_DIR" ]]; then
    check_has_ssh

    echo -e "\n=====> Cloning Wallpapers repository..."
    git clone --depth 1 $REPO $WALLPAPERS_DIR
  fi
}

set_wallpaper() {
  local FILE_NAME=${1:-$DEFAULT_WALLPAPER}

  if [[ -f "$WALLPAPERS_DIR/$FILE_NAME" ]]; then
    echo -e "\n=====> Updating Wallpaper & ScreenSaver..."

    gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERS_DIR/$FILE_NAME"
    gsettings set org.gnome.desktop.screensaver picture-uri "file:///$WALLPAPERS_DIR/$FILE_NAME"
  else
    echo -e "\n=====> File $WALLPAPERS_DIR/$FILE_NAME not found. Options:"
    ls $WALLPAPERS_DIR
  fi
}

main() {
  maybe_clone_repo
  set_wallpaper "$1"
}

main "$@"
