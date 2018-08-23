# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=nvim
export EDITOR=$VISUAL

## ALIAS SECTION ##

# General system aliases #
alias v='nvim '
alias lisp='rlwrap sbcl'
alias kf='sudo zkServer.sh start && sleep 5 && sudo kafka-server-start.sh /usr/share/kafka/config/server.properties'
alias nzk='sudo zkServer.sh stop &&'

# Tmux with correct colors
if [[ $TERM =~ ^xterm.*$ ]]; then
    alias t='tmux -2'
else
    alias t='tmux'
fi

alias dt='git difftool -y'

alias o='
read -p "Are you sure?(Y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    poweroff
else
    echo
fi
'
alias sudo='sudo '

alias sd='sudo $(fc -ln -1)'

alias wr='curl wttr.in/Prague'

# Coloring output #
alias ls='ls --color=auto'
alias dmesg='dmesg --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias gcc='gcc -fdiagnostics-color=auto'
alias pacman='pacman --color=auto'
alias dir='dir --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'
alias less='less -r'

# FS aliases #
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias downloads='cd ~/Downloads'
alias drop='cd ~/Dropbox'
alias docs='cd ~/Documents'
alias rr='rm -rf'
alias s='cd ~/Dropbox/studies'
alias cp='cp -r'
alias mkdir='mkdir -p'

# Network aliases #
alias p='ping -c 3 google.com'

# VPN
alias cs='systemctl start openvpn-client@casablanca'
alias ncs='systemctl stop openvpn-client@casablanca'
alias dl='systemctl start openvpn-client@datalite'
alias ndl='systemctl stop openvpn-client@datalite'

# Package aliases #
alias y='pakku --color=always '
alias g='y -S '
alias ug='y -Rncs '
alias u='y -Syyuu '
alias m='y -Rncs $(y -Qdtq) 2>/dev/null'
alias l='pacman -Q | grep'

# Extraction script #
x () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)     tar xvjf $1    ;;
            *.tar.gz)      tar xvzf $1    ;;
            *.tgz)         tar xvzf $1    ;;
            *.tar.xz)      tar xvJf $1    ;;
            *.bz2)         bunzip2 $1     ;;
            *.rar)         rar x $1       ;;
            *.gz)          gunzip $1      ;;
            *.tar)         tar xvf $1     ;;
            *.tbz2)        tar xvjf $1    ;;
            *.zip)         unzip $1       ;;
            *.Z)           uncompress $1  ;;
            *.7z)          7z x $1        ;;
            *)             echo "don't know how to extract '$1'..."
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Convert pdf to jpg #
function pdftojpg {
    bash /home/yan/git/unixStuff/pdftojpg.sh "$1";
}

# Color prompt #
if [[ ${EUID} == 0 ]]; then
    PS1='\[\e[1;31m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] '
else
    PS1='\[\e[1;32m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
fi

# Fix bash-completion
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
