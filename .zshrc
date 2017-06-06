if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$SSH_TTY" ]]; then
  exec tmux new-session -t tmux
else
  ZSH=$HOME/.oh-my-zsh
  ZSH_THEME="dpoggi"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
  plugins=(
    git
    bundler
    zsh-completions
    zsh-syntax-highlighting
    history-substring-search
    tmux-pane-words
  )
  source $ZSH/oh-my-zsh.sh

  setopt AUTO_PUSHD
  setopt EXTENDED_GLOB
  setopt GLOB_DOTS

  autoload -U compinit && compinit
  autoload -U zmv

  bindkey '\e[A' history-substring-search-up
  bindkey '\e[B' history-substring-search-down

  alias vi='vim -p'
  alias vim='vim -p'
  alias xargs='xargs -o'
  alias mmv='noglob zmv -W'
  alias lsop='lsof -Pni'
  alias sudo='sudo '
  alias serve='python -m SimpleHTTPServer'
  alias ag='rg -S'
  alias m='rg -S -l'
  alias e='xargs -o vim -p'
  alias f='find -X . -type f 2>&1 | rg -S'
  alias j='cd'
  alias jj='popd'
  alias z='zeus'
  alias bup='brew update && brew upgrade && brew cleanup && brew cu -y -a && brew cask cleanup'
  alias rcopy='rsync -a --info=progress2'
  alias docker-cleanup='docker rm $(docker ps -a -f "name=_run_" -q); docker rmi $(docker images -f "dangling=true" -q); docker volume rm $(docker volume ls -qf dangling=true)'
  alias emu='emulator -avd $(emulator -list-avds | head -n1)'
  field() { awk "{print \$$1}" }

  alias gri='grbi --autosquash --autostash'
  alias grc='grbc'
  alias gra='grba'
  alias gmc='gm --continue'
  alias gma='gm --abort'
  alias glgg='glol'
  alias gpsu='gpsup'
  alias gbdd='gb -D'
  alias gup='gl --rebase --prune'
  alias gwc='gwch'
  alias gdc='gdca'
  alias glb='git fetch && git reset --hard $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'
  alias gbdm='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'
  alias gchown='git commit --amend --reuse-message=HEAD --author "$(git config user.name) <$(git config user.email)>"'
  alias gcu='f \\.orig | xargs rm'
  gfl() { git commit --fixup $(git log --pretty='%h' $1 2>/dev/null | head -n1) }
  gwm() { git --no-pager show --abbrev-commit $(git log $1..master --ancestry-path --merges --pretty='%h' 2>/dev/null | tail -n1) }

  aws-env() {
    unset ASSURANT_AWS_ACCESS_KEY_ID
    unset ASSURANT_AWS_SECRET_ACCESS_KEY
    unset MD_AWS_ACCESS_KEY_ID
    unset MD_AWS_SECRET_ACCESS_KEY
    export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id --profile ${1:=default})
    export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key --profile ${1:=default})
    export AWS_DEFAULT_REGION=us-east-1
    export AWS_PROFILE=${1:=default}
    if [[ "$AWS_PROFILE" = "default" ]]; then
      export ASSURANT_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
      export ASSURANT_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    elif [[ "$AWS_PROFILE" = "mobile-defense" ]]; then
      export MD_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
      export MD_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    fi
  }

  eval "$(keychain --quiet --eval --agents ssh md)"
  eval "$(rbenv init --no-rehash - zsh)"
  eval "$(nodenv init --no-rehash - zsh)"
fi
