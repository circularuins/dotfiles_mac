# PATHをリセット
PATH=$(cat /etc/paths | tr -s "\n" ":") # defaultのPATH設定
PATH=${PATH%:}

export PATH="/usr/local/bin:$PATH"

# Homebrew
source /usr/local/Library/Contributions/brew_bash_completion.sh # 補完を有効に

# Emacs
alias emacs="/usr/local/Cellar/emacs/24.3/bin/emacs -nw"
export EDITOR=/usr/local/Cellar/emacs/24.3/bin/emacs

# plenv
export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# tmux
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# leiningen
export PATH=$HOME/local/bin:$PATH
if [ ! -d $HOME/local/bin ]; then mkdir -p $HOME/local/bin; fi

# etc
alias ssh=~/.ssh/ssh-host-color # ssh接続先で色変更

# nvm
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" # This loads nvm

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
