ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/custom
ZSH_THEME="dpoggi"
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false
ZSH_TMUX_GROUP="tmux"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
plugins=(
  tmux
  dircycle
  fancy-ctrl-z
  gem
  git
  history-substring-search
  tmux-pane-words
  terraform
  zsh-completions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt GLOB_DOTS

autoload -U compinit && compinit
autoload -U zmv

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

alias vi='nvim -p'
alias vim='nvim -p'
alias xargs='xargs -o'
alias mmv='noglob zmv -W'
alias lsop='lsof -Pni'
alias sudo='sudo '
alias serve='python -m SimpleHTTPServer'
alias ag='rg -S'
alias m='rg -S -l'
alias e='xargs -o nvim -p'
alias f='rg -L -uuu --files . 2>/dev/null | rg -S'
alias j='cd'
alias jj='popd'
alias dif='git diff --no-index --'
alias bup='brew update && brew upgrade && brew cleanup && brew cu -y -a && brew cask cleanup'
alias rcopy='rsync -a --info=progress2'
alias docker-cleanup='docker rm $(docker ps -a -f "name=_run_" -q); docker rmi $(docker images -f "dangling=true" -q); docker volume rm $(docker volume ls -qf dangling=true)'
alias dr='docker run -v $PWD:$PWD -w $PWD'
alias be='bundle exec'
alias nr='npm run'
alias stree='open -a SourceTree .'
alias code='open -a "Visual Studio Code - Insiders"'
alias subl='open -a "Sublime Text"'
field() { awk "{print \$$1}" }
activate() { if [[ -f .activate ]]; then source .activate; else source env/bin/activate; fi }

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
alias gcf='gc --fixup'
gcff() { git commit --fixup $(git log -n 1 --pretty='%h' $1 2>/dev/null) }
gwm() { git --no-pager show --abbrev-commit $(git log $1..master --ancestry-path --merges --pretty='%h' 2>/dev/null | tail -n1) }

alias kube-secret='EDITOR=nvim ksecret'
alias kube-env='kubectl config use-context'
kube-shell() { kubectl exec -i -t $* -- /bin/sh }

eval "$(keychain --quiet --eval --agents ssh vsts.id_rsa github.id_rsa)"
eval "$(rbenv init --no-rehash - zsh)"
#eval "$(pyenv init --no-rehash - zsh)"
#eval "$(nodenv init --no-rehash - zsh)"
#eval "$(kubectl completion zsh)"
#eval "$(npm completion)"
