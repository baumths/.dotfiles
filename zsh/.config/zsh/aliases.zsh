alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

alias q="exit"
alias lg="lazygit"
alias grep="rg"
alias ls="exa"
alias l="exa -la"
alias tree="exa -T"
alias dc="docker compose"
alias ds="df -H /dev/sda*"
alias config-open="cd ~/.dotfiles && hx ."
alias dotconfig="hx $HOME/.dotfiles"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias upd="sudo apt update && sudo apt upgrade -y && sudo apt autoremove --purge -y && sudo apt clean -y"

# Access To Memory -------------------------------------------------------------

export ATOM_DIR="$HOME/projects/atom"
export ATOM_COMPOSE_FILE="$ATOM_DIR/docker/docker-compose.dev.yml"

alias atom="docker compose -f $ATOM_COMPOSE_FILE"
alias atom-ex="atom exec atom"
alias atom-cc="atom-ex php symfony cc"
alias atom-sp="atom-ex php symfony search:populate"

# FLUTTER ----------------------------------------------------------------------

alias fbuild="dart run build_runner build -d"
alias fwatch="dart run build_runner watch -d"
