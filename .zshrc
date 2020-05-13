DISABLE_AUTO_UPDATE="true"
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/custom
ZSH_THEME="dpoggi"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
plugins=(
  dircycle
  fancy-ctrl-z
  git
  history-substring-search
  zsh-completions
  zsh-syntax-highlighting
  z
)
source $ZSH/oh-my-zsh.sh

setopt AUTO_PUSHD
setopt EXTENDED_GLOB
setopt GLOB_DOTS

autoload -U compinit && compinit
autoload -U zmv

bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down

zstyle ':completion:*' special-dirs false
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'

alias vi='nvim -p'
alias vim='nvim -p'
alias xargs='xargs -o'
alias mmv='noglob zmv -W'
alias lsop='lsof -Pni'
alias sudo='sudo '
alias serve='python3 -m http.server'
alias ag='rg -S'
alias m='rg -S -l'
alias e='xargs -o nvim -p'
alias ev='xargs -o open -a "Visual Studio Code - Insiders"'
alias f='rg -L -uuu --files . 2>/dev/null | rg -S'
alias j='cd'
alias jj='popd'
alias dif='git diff --no-index --'
alias bup='brew update && brew upgrade && brew cu -y -a && brew cleanup'
alias rcopy='rsync -a --info=progress2'
alias docker-cleanup='docker rm $(docker ps -a -f "name=_run_" -q); docker rmi $(docker images -f "dangling=true" -q); docker volume rm $(docker volume ls -qf dangling=true)'
alias dr='docker run -v $PWD:$PWD -w $PWD'
alias be='bundle exec'
alias nr='npm run'
alias stree='open -a SourceTree "$(git rev-parse --show-toplevel || echo .)"'
alias code='code-insiders'
alias subl='open -a "Sublime Text"'
alias venv='python3 -m venv'
alias pr='hub pr checkout'
field() { awk "{print \$$1}" }
activate() { if [[ -f .activate ]]; then source .activate; else source env/bin/activate; fi }

alias gca='gc --amend --no-edit'
alias gri='grbi --autosquash --autostash'
alias grc='grbc'
alias gra='grba'
alias gmc='gm --continue'
alias gma='gm --abort'
alias glgg='glol'
alias gpsu='gpsup'
alias gbdd='gb -D'
alias gup='gl --rebase --prune'
alias guup='gl --rebase --prune upstream $(git rev-parse --abbrev-ref --symbolic-full-name HEAD)'
alias gwc='gwch'
alias gdc='gdca'
alias glb='git fetch && git reset --hard $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'
alias glub='git fetch upstream && git reset --hard upstream/$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)'
alias gchown='git commit --amend --reuse-message=HEAD --author "$(git config user.name) <$(git config user.email)>"'
alias gcu='f \\.orig | xargs rm'
alias gcf='gc --fixup'
alias gsquash='GIT_SEQUENCE_EDITOR=: gri'
compdef __git_commits gcf
gcff() { git commit --fixup $(git log -n 1 --pretty='%h' $1 2>/dev/null) }
gwm() { git --no-pager show --abbrev-commit $(git log $1..${2:-master} --ancestry-path --merges --pretty='%h' 2>/dev/null | tail -n1) }
gfix() { gcf $1 && gsquash $1~1 }
gffix() { gcff $1 && gsquash $1~1 }
gbdm() { git branch --merged ${1:-master} | grep -v "\* ${1:-master}" | xargs -n 1 git branch -d }

alias kube-secret='EDITOR=nvim ksecret'
alias kube-env='kubectl config use-context'
kube-shell() { kubectl exec -i -t $* -- /bin/sh }

#eval "$(keychain --quiet --eval --agents ssh vsts.id_rsa github.id_rsa)"
source $HOME/Private/Keys/azure_keys.sh
source $HOME/.dotfiles/.iterm2_shell_integration.zsh
