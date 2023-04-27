#!/bin/bash

clone_and_install_helix() {
  local PATH_TO_HELIX="$1"

  mkdir -p "$PATH_TO_HELIX"
  pushd "$PATH_TO_HELIX" &> /dev/null

  git clone --depth 1 "https://github.com/helix-editor/helix" .
  cargo install --locked --path helix-term
  ln -s "$PWD/runtime" "$XDG_CONFIG_HOME/helix/runtime"

  popd &> /dev/null
}

update_helix() {
  local PATH_TO_HELIX="$1"

  pushd "$PATH_TO_HELIX" &> /dev/null

  git fetch && git pull
  cargo install --locked --path helix-term

  popd &> /dev/null
}

install_helix() {
  local PATH_TO_HELIX="$XDG_CONFIG_DATA/helix"

  if [[ -d "$PATH_TO_HELIX" ]]; then
    read -t 30 -p "Helix already installed, update it? [y/N]: " update

    if [[ "$update" =~ ^[yY]$ ]]; then
      update_helix "$PATH_TO_HELIX"
      echo "[*] Helix updated successfully."
    else
      echo "[*] Keeping current Helix version."
    fi
  else
    clone_and_install_helix "$PATH_TO_HELIX"
    echo "[*] Helix installed successfully."
  fi

}

install_helix
