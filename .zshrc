if [[ -n "$TMUX" || -n "$SSH_CLIENT" || -n "$ZSHRC_FORCE" ]]; then
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
  alias serve='python -m SimpleHTTPServer'
  alias ag='ag -S -U'
  alias jr='cd ~/working/mobiledefense_rails'
  alias js='cd ~/working/mobiledefense_snotur2'
  alias jsa='cd ~/working/mobiledefense_snotur_api_gem'
  alias jss='cd ~/working/mobiledefense_snotur_service'

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
  plugins=(history-substring-search git rails3 ruby gem bundler rake rbenv brew osx tmux zeus)

  source $ZSH/oh-my-zsh.sh

  alias gl='git log'
  compdef _git gl=git-log
  alias gp='git remote prune'
  compdef _git gp=git-remote
  alias gpl='git pull'
  compdef _git gpl=git-pull
  alias gps='git push'
  compdef _git gps=git-push
  alias glgg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
  alias glg='git log --stat'
  alias zeus='unbundled_zeus'

  # Customize to your needs...
  export PATH=$PATH:/usr/local/sbin:/usr/X11/bin:/usr/local/share/npm/bin:~/bin:~/android-sdks/tools:~/android-sdks/platform-tools
  export EDITOR=/usr/bin/vim
  export VISUAL=/usr/bin/vim
  export NODE_PATH=/usr/local/lib/node_modules
else
  TMUX_ACT=$(tmux -S /tmp/tmux-tmux ls -F '#{session_attached}' 2> /dev/null)
  if [[ -z "$TMUX_ACT" || "$TMUX_ACT" = "0" ]]; then
    exec tmux -S /tmp/tmux-tmux new -s tmux
  else
    TMUX_ATT=
    vared -p 'Attach to active tmux session [nyc]? ' TMUX_ATT
    if [[ "$TMUX_ATT" = "y" || "$TMUX_ATT" = "Y" ]]; then
      exec tmux -S /tmp/tmux-tmux att -t tmux
    else
      if [[ "$TMUX_ATT" = "c" || "$TMUX_ATT" = "C" ]]; then
        exec tmux -S /tmp/tmux-tmux new -t tmux
      else
        export ZSHRC_FORCE=1
        source ~/.zshrc
      fi
    fi
  fi
fi

[[ -a "/tmp/tmux-tmux" ]] && chmod 1777 /tmp/tmux-tmux
