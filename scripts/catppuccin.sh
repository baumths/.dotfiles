#!/bin/bash

if [ ! -d ~/dev/catppuccin-gtk/ ]; then
  echo "Could not find ~/dev/catppuccin-gtk directory."
  exit 1
fi

pushd ~/dev/catppuccin-gtk/ &> /dev/null

./install.sh -c dark --tweaks black rimless
./install.sh -c dark -s compact --tweaks black rimless

popd &> /dev/null

gsettings set org.gnome.shell.extensions.user-theme name Catppuccin-Dark
gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Dark-Compact
