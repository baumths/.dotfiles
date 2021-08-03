# My ubuntu dotfiles setup + scripts

> On a new Ubuntu Machine

- Update packages
  ```bash
  sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
  ```
- Clone this repo
  ```bash
  cd ~
  git clone --depth=1 https://github.com/mbaumgartenbr/.dotfiles.git
  ```
- Run install script
  ```bash
  bash .dotfiles/scipts/install.sh
  ```