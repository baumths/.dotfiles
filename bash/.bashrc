case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend checkwinsize globstar

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)" 

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

for file in ~/.{aliases,exports,prompt,functions}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
    source "$file"
  fi
done
unset file

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [[ -d /etc/bash_completion.d/ ]]; then
  for file in /etc/bash_completion.d/* ; do
    source "$file"
  done
fi
