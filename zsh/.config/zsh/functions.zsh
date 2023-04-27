# UTIL -------------------------------------------------------------------------

function mkd() {
  mkdir $@ && cd $_
}

# FLUTTER ----------------------------------------------------------------------

# Credits: https://gist.github.com/lukepighetti/393845a6751c0b00c20d5cfbac1f8bd1
function watch_flutter_run() {
  tmux new-session \;\
  send-keys "flutter run --pid-file=/tmp/tf1.pid $@" Enter \;\
  split-window -h \;\
  send-keys 'watchexec -p -e dart -w lib -- "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;\
  select-pane -t 0 \;
}

# GOOGLE CLOUD -----------------------------------------------------------------

function gcloud() {
  if [[ -n $1 && $1 == "auth" ]]; then
    docker run -ti --name gcloud-config gcr.io/google.com/cloudsdktool/cloud-sdk gcloud auth login
  else
    docker run -it --rm --volumes-from gcloud-config gcr.io/google.com/cloudsdktool/cloud-sdk bash
  fi;
}

# ZSH --------------------------------------------------------------------------

function zsh_add_file() {
  [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

  if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    # For plugins
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
  fi
}

function zsh_add_completion() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

  if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
    # For completions
    completion_file_path=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
    fpath+="$(dirname "${completion_file_path}")"
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
  else
    git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fpath+=$(ls $ZDOTDIR/plugins/$PLUGIN_NAME/_*)
    [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
  fi

	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}
