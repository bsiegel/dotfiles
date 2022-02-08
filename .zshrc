DISABLE_AUTO_UPDATE="true"
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/custom
ZSH_DISABLE_COMPFIX="true"
ZSH_THEME="dpoggi"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
plugins=(
  dircycle
  fancy-ctrl-z
  git
  history-substring-search
  zsh-autosuggestions
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
bindkey '^ ' autosuggest-accept

# Remove this when zsh >5.8 is released
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

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
alias bup='brew update && brew upgrade && brew cleanup'
alias nup='npm ls -g --depth 0 --json | jq ".dependencies | keys[]" | xargs npm i -g'
alias rcopy='rsync -a --info=progress2'
alias docker-cleanup='docker rm $(docker ps -a -f "name=_run_" -q); docker rmi $(docker images -f "dangling=true" -q); docker volume rm $(docker volume ls -qf dangling=true)'
alias dr='docker run -v $PWD:$PWD -w $PWD'
alias be='bundle exec'
alias nr='npm run'
alias stree='open -a SourceTree "$(git rev-parse --show-toplevel || echo .)"'
alias code='code-insiders'
alias subl='open -a "Sublime Text"'
alias venv='python3 -m venv'
alias pr='gh pr checkout'
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
alias gbn='git rev-parse --abbrev-ref --symbolic-full-name HEAD'
alias grbn='git rev-parse --abbrev-ref --symbolic-full-name @{u}'
alias gup='gl --rebase --prune'
alias guup='gl --rebase --prune upstream $(gbn)'
alias gpup='gp upstream $(gbn)'
alias grr='git rev-parse --show-cdup 2>/dev/null || echo .'
alias gwc='gwch'
alias gdc='gdca'
#alias glb='git fetch && git reset --hard $(git rev-parse --abbrev-ref --symbolic-full-name @{u})'
#alias glub='git fetch upstream && git reset --hard upstream/$(git rev-parse --abbrev-ref --symbolic-full-name HEAD)'
alias gchown='git commit --amend --reuse-message=HEAD --author "$(git config user.name) <$(git config user.email)>"'
alias gcu='f \\.orig | xargs rm'
alias gcf='gc --fixup'
alias gsquash='GIT_SEQUENCE_EDITOR=: gri'
compdef __git_commits gcf
gcff() { git commit --fixup $(git log -n 1 --pretty='%h' $1 2>/dev/null) }
gwm() { git --no-pager show --abbrev-commit $(git log $1..${2:-develop} --ancestry-path --merges --pretty='%h' 2>/dev/null | tail -n1) }
gfix() { gcf $1 && gsquash $1~1 }
gffix() { gcff $1 && gsquash $1~1 }
gbdm() { gco ${1:-develop} && git branch --merged ${1:-develop} | grep -v "^\(\s\|\*\)*\(${1:-develop}\|develop\|main\|master\)$" | xargs -n 1 git branch -d }

export RR=$(grr)
chpwd() { export RR=$(grr) }

alias kube-env='kubectl config use-context'
alias docker-shell='docker run --rm -it --entrypoint /bin/sh'
kube-shell() { kubectl exec -i -t $* -- /bin/sh }

alias adb-screenshot='adb exec-out screencap -p > ~/Desktop/Screenshot\ $(date +%F)\ $(date +%H.%M.%S).png'
alias adb-mirror='adb exec-out screenrecord --bit-rate=16m --output-format=h264 --size 1920x1080 - | ffplay -framerate 60 -framedrop -bufsize 16M -'
alias ashell='jshell --class-path $ANDROID_HOME/platforms/android-30/android.jar'

#eval "$(keychain --quiet --eval --agents ssh vsts.id_rsa github.id_rsa)"
#source $HOME/Private/Keys/azure_keys.sh
source $HOME/.dotfiles/.iterm2_shell_integration.zsh
