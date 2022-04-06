#!/bin/bash

WALLPAPERS_DIR="$HOME/.local/wallpapers"
DEFAULT_WALLPAPER="014.jpg"

maybe_clone_repo() {
  local REPO="git@github.com:mbaumgartenbr/wallpapers.git"

  if [[ ! -d "$WALLPAPERS_DIR" ]]; then
    echo "=====> Cloning Wallpapers repository..."
    git clone --depth 1 $REPO $WALLPAPERS_DIR
  fi
}

set_wallpaper() {
  local FILE_NAME=${1:-$DEFAULT_WALLPAPER}

  if [[ -f "$WALLPAPERS_DIR/$FILE_NAME" ]]; then
    echo "=====> Updating Wallpaper..."

    gsettings set org.gnome.desktop.background picture-uri "file:///$WALLPAPERS_DIR/$FILE_NAME"
  else
    echo "=====> File $WALLPAPERS_DIR/$FILE_NAME not found. Options:"
    ls $WALLPAPERS_DIR
  fi
}

main() {
  maybe_clone_repo
  set_wallpaper "$1"
}

main "$@"
