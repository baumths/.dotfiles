export SHELL=/bin/zsh
export ZDOTDIR=$HOME/.config/zsh
export XDG_CONFIG_HOME=$HOME/.config/
export XDG_CONFIG_DATA=$HOME/.local/share

setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
setopt functionargzero
setopt appendhistory

unsetopt beep

stty stop undef	# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

autoload -Uz compinit
zstyle :compinstall filename "$HOME/.zshrc"
zmodload zsh/complist
_comp_options+=(globdots)

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Local config
local files=(
  'aliases'
  'exports'
  'functions'
  'prompt'
  'vim_mode'
)

for file in "${files[@]}"; do
 [ -f "$ZDOTDIR/$file.zsh" ] && source "$ZDOTDIR/$file.zsh"
done

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# FZF
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
compinit

autoload edit-command-line; zle -N edit-command-line

bindkey '^[[Z' autosuggest-accept # <shift-tab> completes from history
