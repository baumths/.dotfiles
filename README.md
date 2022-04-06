# Personal Ubuntu Dotfiles (setup + scripts)

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
  bash ~/.dotfiles/scipts/install.sh
  ```

###  Install JetBrains fonts

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
```

### Choose default terminal

```sh
sudo update-alternatives --config x-terminal-emulator
```
