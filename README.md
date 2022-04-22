# Personal Ubuntu Dotfiles (setup + scripts)

- Update packages
  ```bash
  sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
  ```
- Install Git
  ```bash
  sudo apt install git -y
  ```
- Clone this repo
  ```bash
  cd ~
  git clone --depth=1 https://github.com/mbaumgartenbr/.dotfiles.git
  ```
- Run install script
  ```bash
  chmod +x ~/.dotfiles/scipts/install.sh
  bash ~/.dotfiles/scipts/install.sh
  ```

###  Install JetBrains Nerd Font

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
```

### Choose default terminal

```bash
sudo update-alternatives --config x-terminal-emulator
```
