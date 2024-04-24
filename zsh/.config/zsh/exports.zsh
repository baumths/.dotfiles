HISTFILE=$HOME/.local/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

export TERMINAL="kitty"

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

export PATH="$PATH:$HOME/.pub-cache/bin" # Dart active global packages
export PATH="$PATH:$HOME/.local/share/flutter/bin"
export PATH="$PATH:$HOME/.local/share/lua/bin"

export ANDROID_HOME="$HOME/.local/share/android"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"

export PATH="$PATH:$HOME/.cargo/bin"

export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$GOPATH/bin"
