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
  alias vi=osxvim
  alias vim=osxvim
  alias xargs='xargs -o'
  alias mmv='noglob zmv -W'
  alias serve='python -m SimpleHTTPServer'
  alias ag='ag -S -U'
  alias jj='popd'
  alias z='zeus'
  alias rdbg='be rdebug $(git rev-parse --show-toplevel)/script/server'
  
  function j() {
    cd `f $1`
  }

  function f() {
    word=$1
    pattern=$word[1]
    patternw='[\/|\.|_|-| ]'$word[1]'[a-zA-Z]*'
    i=2
    while [[ -n $word[$i] ]]; do
      pattern="$pattern.*$word[$i]"
      patternw="$patternw"'[\.|_|-| ]'"$word[$i]"'[a-zA-Z]*'
      i=$(($i+1))
    done
    directories=`find -L . -maxdepth 1 -type d | egrep -v '(^\.\/\.|\.sparsebundle$)'`
    candidate=`echo $directories | egrep "^\.$patternw$" | head -n1`
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep -i "^\.$patternw$" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep "^\.$patternw" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep -i "^\.$patternw" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep "^\.\/$pattern" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep -i "^\.\/$pattern" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep "$patternw" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep -i "$patternw" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep "[\.|_|-| ]$pattern" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep -i "[\.|_|-| ]$pattern" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep "$pattern" | head -n1`
    fi
    if [[ -z $candidate ]]; then
      candidate=`echo $directories | egrep -i "$pattern" | head -n1`
    fi
    if [[ -n $candidate ]]; then
      echo $candidate
    else
      return 1
    fi
  }

  setopt AUTO_PUSHD
  setopt EXTENDED_GLOB
  setopt GLOB_DOTS

  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
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
  plugins=(history-substring-search safe-paste git gem bundler rbenv brew osx tmux zeus vagrant sbt pip knife)

  source $ZSH/oh-my-zsh.sh

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
  gfix() {
    git commit --fixup $1 && EDITOR=: VISUAL=: git rebase -i --autosquash $1~1
  }
  gbrm() {
    if [[ -n $1 ]]; then
      arr=$(echo $1 | tr "/" ":")
      arr=("${(s/:/)arr}")
      echo git push $arr[1] :$arr[2]
    else
      echo "fatal: must specify a remote ref to delete"
    fi
  }

  # Customize to your needs...
  export PATH=$PATH:~/bin:/usr/local/share/npm/bin:/usr/local/opt/android-sdk/bin:/usr/local/opt/android-sdk/tools:/usr/local/opt/android-sdk/platform-tools
  export EDITOR=osxvim
  export VISUAL=osxvim
  export NODE_PATH=/usr/local/lib/node_modules
  export GOROOT=/usr/local/opt/go
  export ANDROID_HOME=/usr/local/opt/android-sdk
  source ~/private/Keys/aws_keys.sh
else
  TMUX_ACT=$(tmux -S /tmp/tmux-tmux ls -F '#{session_windows}' 2> /dev/null)
  if [[ -z "$TMUX_ACT" || "$TMUX_ACT" = "0" ]]; then
    exec tmux -S /tmp/tmux-tmux new -s tmux
  else
    TMUX_ATT=$(tmux -S /tmp/tmux-tmux ls -F '#{session_attached}' 2> /dev/null)
    if [[ -z "$TMUX_ATT" || "$TMUX_ATT" = "0" ]]; then
      exec tmux -S /tmp/tmux-tmux att -t tmux
    else
      TMUX_RSP=
      vared -p 'Attach to active tmux session [nyc]? ' TMUX_ATT
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
