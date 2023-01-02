# Personal Linux Setup & Scripts

- Update packages

  Ubuntu: `sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y`

- Install Git

  Ubuntu: `sudo apt install git -y`

- Clone this repo
  ```bash
  cd ~
  git clone --depth 1 https://github.com/mbaumgartenbr/.dotfiles.git
  ```
- Run install script
  ```bash
  chmod +x ~/.dotfiles/scripts/install.sh
  bash ~/.dotfiles/scripts/install.sh
  ```

### Choose the default terminal

```bash
sudo update-alternatives --config x-terminal-emulator
```
