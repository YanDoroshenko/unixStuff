# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=nvim
export EDITOR=$VISUAL

# BIG SHARED HISTORY

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

## ALIAS SECTION ##

# General system aliases #
alias v='nvim '
alias sbt='SBT_OPTS="-Xms512M -Xmx1024M -Xss2M -XX:MaxMetaspaceSize=1024M" sbt ' # Prevent OutOfMemoryError in SBT by giving it more memory

# Currency converter
alias currency='git/github/unixStuff/exchange.sh'

# Tmux with correct colors
if [[ $TERM =~ ^xterm.*$ ]]; then
    alias t='tmux -u -2'
else
    alias t='tmux -u'
fi

# Cmus music player
alias cmus='udisksctl mount -p block_devices/sda1 /mnt/hdd 2>/dev/null ; cmus'

alias dt='git difftool -y'

# Docker
alias env='
if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
    systemctl start docker
fi
tmux new-session -d -s env
tmux split-window -h
tmux split-window -v -t 0
tmux split-window -v -t 0.2
clear="unset HISTFILE && clear &&"
tmux send-keys -t 0.0 "$clear kafka" C-m
tmux send-keys -t 0.1 "$clear cassandra" C-m
tmux send-keys -t 0.2 "$clear postgres" C-m
tmux send-keys -t 0.3 "$clear cd ~/git/upstart" C-m
tmux attach-session -t env
systemctl stop docker
'

alias cassandra='
if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
    systemctl start docker
fi &&
docker run --rm  -p 127.0.0.1:9042:9042 -p 127.0.0.1:9160:9160 --name cassandra -v $HOME/docker/volumes/cassandra:/var/lib/cassandra cassandra:latest
'
alias postgres='
if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
    systemctl start docker
fi &&
docker run --rm  -p 127.0.0.1:5432:5432 -e POSTGRES_PASSWORD="1234" --name postgres -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres:alpine
'
alias kafka='
if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
    systemctl start docker
fi &&
docker run --rm --name kafka -p 2181:2181 -p 9092:9092 -e ADVERTISED_HOST=127.0.0.1 -e LOG_RETENTION_HOURS=-1 -e LOG_RETENTION_BYTES=-1 johnnypark/kafka-zookeeper
'

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
    bash /home/yan/git/github/unixStuff/pdftojpg.sh "$1";
}

# Color prompt #
if [[ ${EUID} == 0 ]]; then
    PS1='\[\e[1;31m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] '
else
    PS1='\[\e[1;32m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
fi

# Fix bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias f='~/Downloads/fusion/4.2.0/bin/fusion start'
alias nf='~/Downloads/fusion/4.2.0/bin/fusion stop'
