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

# etc
alias ssh=~/.ssh/ssh-host-color # ssh接続先で色変更
