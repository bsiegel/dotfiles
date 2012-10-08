# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dpoggi"

autoload -U zmv

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi=vim
alias view='vim -R'
alias mmv='noglob zmv -W'

setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt GLOB_DOTS

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(history-substring-search git git-flow rails3 ruby bundler gem rvm rake brew osx tmux)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/share/npm/bin
export PATH=$PATH:~/android-sdks/tools:~/android-sdks/platform-tools
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export NODE_PATH=/usr/local/lib/node_modules

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

if [[ -z "$TMUX" && -z "$SSH_CLIENT" ]]; then
  TMUX_ACT=$(tmux -S /tmp/tmux-tmux ls -F '#{session_attached}' 2> /dev/null)
  if [[ -z "$TMUX_ACT" || "$TMUX_ACT" = "0" ]]; then
    exec tmux -S /tmp/tmux-tmux att -t tmux
  else
    TMUX_ATT=
    vared -p 'Attach to active tmux session [nyc]? ' TMUX_ATT
    if [[ "$TMUX_ATT" = "y" || "$TMUX_ATT" = "Y" ]]; then
      exec tmux -S /tmp/tmux-tmux att -t tmux
    else
      if [[ "$TMUX_ATT" = "c" || "$TMUX_ATT" = "C" ]]; then
        exec tmux -S /tmp/tmux-tmux new -t tmux
      fi
    fi
  fi
fi

[[ -a "/tmp/tmux-tmux" ]] && chmod 1777 /tmp/tmux-tmux
