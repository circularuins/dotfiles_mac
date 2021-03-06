# PATHをリセット
PATH=$(cat /etc/paths | tr -s "\n" ":") # defaultのPATH設定
PATH=${PATH%:}

export PATH="/usr/local/bin:$PATH"

# Homebrew
#source /usr/local/Library/Contributions/brew_bash_completion.sh # 補完を有効に

# Emacs
alias emacs="/usr/local/Cellar/emacs-plus/25.3/bin/emacs -nw"
export EDITOR=/usr/local/Cellar/emacs-plus/25.3/bin/emacs

# plenv
#export PATH="$HOME/.plenv/bin:$PATH"
#eval "$(plenv init -)"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
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

# java
## javaのバージョンを切り替える
export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "1.8"`
PATH=${JAVA_HOME}/bin:${PATH}
## 1.6のterminal日本語文字化けを防ぐ
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
## AndroidSDKの場所
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# go
export GOPATH=$HOME/project/go
export PATH=$PATH:$GOPATH/bin

# git
source ~/dotfiles/git-completion.bash
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

# コンソールのユーザー名のところに現在のディレクトリ名を表示する
export PS1="\W $ "

HISTSIZE=50000
HISTTIMEFORMAT='%Y/%m/%d %H:%M:%S '
