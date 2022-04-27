[ -z "$PS1" ] && return

export ZSH="$HOME/.dotfiles/oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=20000
export HISTFILESIZE=20000
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

READLINK=$(which greadlink 2>/dev/null || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

source "$HOME/.zprofile"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

alias magic-cli="python $HOME/.magic-cli/magic-cli.py"

# Load version control information
# autoload -Uz vcs_info
# precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
# zstyle ':vcs_info:git:*' formats '%b'

# Set up the prompt
# setopt PROMPT_SUBST
# PROMPT='%1~ %F{green}${vcs_info_msg_0_}%f $ '

for DOTFILE in "$DOTFILES_DIR"/system/.{alias,function,airflow}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done
