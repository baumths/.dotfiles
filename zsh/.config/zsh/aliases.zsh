alias v="nvim"
alias nvimrc="nvim ~/.config/nvim/"

alias g="lazygit"

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Colorize ls output
alias ls="ls --color=auto"
alias l="ls -la"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Update
alias upd="sudo apt update && sudo apt upgrade -y && sudo apt autoremove --purge -y && sudo apt clean -y"

# Python serve in current folder
alias pserve="python3 -m http.server 8000"

# Format json
alias pjson="python3 -m json.tool"

# Access To Memory -------------------------------------------------------------

export ATOM_DIR="$HOME/dev/github/atom"
export ATOM_COMPOSE_FILE="$ATOM_DIR/docker/docker-compose.dev.yml"

alias atom="docker-compose -f $ATOM_COMPOSE_FILE"
alias atom-ex="atom exec atom"
alias atom-cc="atom-ex php symfony cc"
alias atom-sp="atom-ex php symfony search:populate"

# FLUTTER ----------------------------------------------------------------------

alias fbuild="flutter pub run build_runner build --delete-conflicting-outputs"
alias fwatch="flutter pub run build_runner watch --delete-conflicting-outputs"
