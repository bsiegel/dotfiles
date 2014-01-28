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
  alias vi='reattach-to-user-namespace vim -p'
  alias vim='reattach-to-user-namespace vim -p'
  alias xargs='xargs -o'
  alias mmv='noglob zmv -W'
  alias serve='python -m SimpleHTTPServer'
  alias ag='ag -S -U'
  alias m='ag -S -U -l'
  alias e='xargs -o reattach-to-user-namespace vim -p'
  alias f='find . | ag -S -U'
  alias j='cd'
  alias jj='popd'
  alias z='zeus'

  # complete words from tmux pane(s) {{{1
  # Source: http://blog.plenz.com/2012-01/zsh-complete-words-from-tmux-pane.html
  _tmux_pane_words() {
    local expl
    local -a w
    if [[ -z "$TMUX_PANE" ]]; then
      _message "not running inside tmux!"
      return 1
    fi
    # capture current pane first
    w=( ${(u)=$(tmux capture-pane -J -p)} )
    for i in $(tmux list-panes -F '#P'); do
      # skip current pane (handled above)
      [[ "$TMUX_PANE" = "$i" ]] && continue
      w+=( ${(u)=$(tmux capture-pane -J -p -t $i)} )
    done
    _wanted values expl 'words from current tmux pane' compadd -a w
  }

  zle -C tmux-pane-words-prefix   complete-word _generic
  zle -C tmux-pane-words-anywhere complete-word _generic
  bindkey '^Xt' tmux-pane-words-prefix
  bindkey '^X^X' tmux-pane-words-anywhere
  zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
  zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
  # display the (interactive) menu on first execution of the hotkey
  zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' menu yes select interactive
  zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
  # }}}

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
  plugins=(history-substring-search safe-paste git rbenv gem bundler brew osx zeus vagrant sbt pip knife)

  source $ZSH/oh-my-zsh.sh

  alias gdw='git diff --color-words'
  compdef _git gdw=git-diff
  alias gre='git reset'
  compdef _git gre=git-reset
  alias grh='git reset --hard'
  compdef _git grh=git-reset
  alias grb='git rebase --autostash'
  compdef _git grb=git-rebase
  alias gri='git rebase -i --autosquash --autostash'
  compdef _git gri=git-rebase
  alias grc='git rebase --continue'
  compdef _git grc=git-rebase
  alias gra='git rebase --abort'
  compdef _git gra=git-rebase
  alias gcpc='git cherry-pick --continue'
  compdef _git gcpc=git-cherry-pick
  alias gcpa='git cherry-pick --abort'
  compdef _git gcpi=git-cherry-pick
  alias gmc='git merge --continue'
  compdef _git gmc=git-merge
  alias gma='git merge --abort'
  compdef _git gma=git-merge
  alias gmt='git mergetool'
  compdef _git gmt=git-mergetool
  alias gl='git log'
  compdef _git gl=git-log
  alias glgg="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
  compdef _git glgg=git-log
  alias glg='git log --stat'
  compdef _git glg=git-log
  alias gp='git remote prune'
  compdef _git gp=git-remote
  alias gpl='git pull'
  compdef _git gpl=git-pull
  alias gps='git push'
  compdef _git gps=git-push
  alias gpsu='git push --set-upstream origin $(current_branch)'
  compdef _git gpsu=git-push
  alias grm='git rm'
  compdef _git grm=git-rm
  alias gbd='git branch -d'
  compdef _git gbd=git-branch
  alias gbdd='git branch -D'
  compdef _git gbdd=git-branch
  alias gsu='git branch --set-upstream-to=origin/$(current_branch)'
  compdef _git gsu=git-branch

  # Customize to your needs...
  export KEYTIMEOUT=1
  export PATH=$PATH:~/bin:/usr/local/share/npm/bin:/usr/local/opt/android-sdk/bin:/usr/local/opt/android-sdk/tools:/usr/local/opt/android-sdk/platform-tools
  export EDITOR='reattach-to-user-namespace vim -p'
  export VISUAL='reattach-to-user-namespace vim -p'
  export NODE_PATH=/usr/local/lib/node_modules
  export GOROOT=/usr/local/opt/go
  export ANDROID_HOME=/usr/local/opt/android-sdk
  source ~/private/Keys/aws_keys.sh
  export AWS_ACCESS_KEY_ID=$MD_AWS_ACCESS_KEY_ID
  export AWS_SECRET_ACCESS_KEY=$MD_AWS_SECRET_ACCESS_KEY
  export AWS_DEFAULT_REGION=us-east-1
else
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  TMUX_ACT=$(tmux -S /tmp/tmux-tmux ls -F '#{session_windows}' 2> /dev/null)
  if [[ -z "$TMUX_ACT" || "$TMUX_ACT" = "0" ]]; then
    exec tmux -S /tmp/tmux-tmux new -s tmux
  else
    TMUX_ATT=$(tmux -S /tmp/tmux-tmux ls -F '#{session_attached}' 2> /dev/null)
    if [[ -z "$TMUX_ATT" || "$TMUX_ATT" = "0" ]]; then
      exec tmux -S /tmp/tmux-tmux att -t tmux
    else
      TMUX_RSP=
      vared -p 'Attach to active tmux session [nyc]? ' TMUX_RSP
      if [[ "$TMUX_RSP" = "y" || "$TMUX_RSP" = "Y" ]]; then
        exec tmux -S /tmp/tmux-tmux att -t tmux
      elif [[ "$TMUX_RSP" = "c" || "$TMUX_RSP" = "C" ]]; then
        exec tmux -S /tmp/tmux-tmux new -t tmux
      else
        export ZSHRC_FORCE=1
        source ~/.zshrc
      fi
    fi
  fi
fi

[[ -a "/tmp/tmux-tmux" ]] && chmod 1777 /tmp/tmux-tmux
