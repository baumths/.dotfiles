## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
    git status --porcelain | grep '??' &> /dev/null ; then
    # This will show the marker if there are any untracked files in repo.
    # If instead you want to show the marker only if there are untracked
    # files in $PWD, use:
    #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
    hook_com[staged]+='!' # signify new files with a bang
  fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%F{9}%m%u%c%f%{$fg[white]%} %{$fg[green]%} %b%{$fg[blue]%})"

PROMPT="%B%F{4}[%f%b"
PROMPT+="%B%F{15}%n%f%b"     # user
PROMPT+="%B%F{9}@%f%b"
PROMPT+="%B%F{15}%m%f%b"     # host
PROMPT+="%B%F{4}]%f%b"
PROMPT+="\$vcs_info_msg_0_ " # git
PROMPT+="%B%F{208}%~%f%b"    # cwd
PROMPT+=$'\n'
PROMPT+="%B%F{15} ➜%f%b "
