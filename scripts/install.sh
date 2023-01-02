#!/bin/bash

setup_symlinks() {
  pushd "$HOME/.dotfiles" &> /dev/null

  if [ $? -eq 0 ]; then
    echo "[*] Stowing .dotfiles..."

    stow -v git/
    stow -v zsh/
    stow -v nvim/
    stow -v helix/
    stow -v kitty/
    stow -v lazygit/

    popd &> /dev/null
    echo "[*] Done Stowing .dotfiles."
  else
    echo "[!] Could not find '.dotfiles' directory at '$HOME'"
  fi
}

setup_gnome_settings() {
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

  gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 15
  gsettings set org.gnome.desktop.peripherals.keyboard delay 240

  # Wallpapers
  local WALLPAPERS_SCRIPT="$HOME/.dotfiles/scripts/wallpapers.sh"
  if [[ -f $WALLPAPERS_SCRIPT ]]; then
    echo -e "\n[*] Installing Wallpapers..."
    chmod +x $WALLPAPERS_SCRIPT
    bash $WALLPAPERS_SCRIPT
    chmod -x $WALLPAPERS_SCRIPT
  else
    echo -e "\n[!] Failed to setup wallpapers."
  fi
}

run_install_script() {
  local FILE_NAME="$1"
  local FILE_PATH="$HOME/.dotfiles/scripts/distros/$FILE_NAME"

  if [ -f "$FILE_PATH" ]; then
    chmod +x $FILE_PATH
    bash $FILE_PATH
    chmod -x $FILE_PATH
  else
    echo -e "\n[!] Could not find script at $FILE_PATH\n"
    exit 1
  fi
}

post_install() {
  echo -e ""
  setup_symlinks

  echo -e "\n[*] Updating Gnome shell settings..."
  setup_gnome_settings

  echo "[*] Setting 'zsh' as the default shell..."
  chsh -s $(which zsh)
}

main() {
  case "$(lsb_release -is)" in
    Ubuntu)
      run_install_script "ubuntu.sh"
      ;;
    *)
      echo -e "\n[!] Unknown distro, skipping...\n"
      exit 1
      ;;
  esac

  post_install

  echo -e "\n[#] Remember to restart your pc."
}

main "$@"
