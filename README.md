# Personal Linux Setup & Scripts

- Update packages

  Ubuntu: `sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y`

- Install Git

  Ubuntu: `sudo apt install git -y`

- Clone this repo
  ```sh
  cd ~ && git clone git@github.com:baumths/.dotfiles.git
  ```

- Run install script
  ```sh
  bash ~/.dotfiles/scripts/install.sh
  ```

### Choose the default terminal

```sh
sudo update-alternatives --config x-terminal-emulator
```
