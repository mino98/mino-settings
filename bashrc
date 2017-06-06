# Bash:
export PS1="\[\033[01;32m\]\u@mubook\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
export TERM=xterm-color
export PATH=$PATH:$HOME/bin:/usr/local/bin
export SHELL=/bin/bash
export EDITOR=vim

# History:
export HISTCONTROL='erasedups'
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTTIMEFORMAT='%d/%m/%Y %H:%M:%S - '

# Misc stuff:
alias top='top -o cpu -s 10'
alias ll="ls -laG"
alias pwgen="pwgen -Bscn 15 1"
alias apinfo='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport en1 -I'
alias grep='grep -n --color'
alias df='df -H'
alias rm='rm -i'

# Iterm2 integration:
source /Users/mino/.iterm2_shell_integration.bash

# Bash completion:
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
