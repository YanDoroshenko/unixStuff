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
alias s='sbt -jvm-debug 5150'

# Currency converter
alias currency='git/github/unixStuff/exchange.sh'


# Cmus music player
alias cmus='udisksctl mount -p block_devices/sda1 /mnt/hdd 2>/dev/null ; cmus'

alias dt='git difftool -y'

# Docker
function env {
    tmux kill-session -t env 2>/dev/null
    if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
        systemctl start docker
    fi
    tmux rename-session env
    tmux split-window -h -t env
    tmux split-window -v -t env
    tmux split-window -v -t env.0
    HISTFILE_BAK=$HISTFILE
    clear="unset HISTFILE && clear &&"
    tmux send-keys -t env.0 "$clear kafka" C-m
    tmux send-keys -t env.1 "$clear cassandra" C-m
    tmux send-keys -t env.2 "$clear postgres" C-m
    tmux send-keys -t env.3 "$clear cd ~/git/upstart; HISTFILE=$HISTFILE_BAK; clear" C-m
    tmux bind-key -T ENV -n C-q confirm-before -p "Stop Docker environment? (y/n)" 'new-window; send-keys -t env "systemctl stop docker.service && tmux kill-session -t env" Enter'
    tmux switch-client -T ENV -t env.3
}

function cassandra {
    if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
        systemctl start docker
    fi && docker run --rm  -p 127.0.0.1:9042:9042 -p 127.0.0.1:9160:9160 --name cassandra -v $HOME/docker/volumes/cassandra:/var/lib/cassandra cassandra:latest
}

function postgres {
    if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
        systemctl start docker
    fi && docker run --rm  -p 127.0.0.1:5432:5432 -e POSTGRES_PASSWORD="1234" --name postgres -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres:alpine
}

function kafka {
    if [ ! -z $(systemctl is-active docker | grep inactive) ]; then
        systemctl start docker
    fi && docker run  --rm \
        --name=kafka \
        -p 2181:2181 \
        -p 9092:9092 \
        --env ADVERTISED_HOST=localhost \
        --env ADVERTISED_PORT=9092  \
        --env LOG_RETENTION_HOURS=-1 \
        --env LOG_RETENTION_BYTES=-1 \
        -v $HOME/docker/volumes/zookeper:/tmp/zookeeper \
        -v $HOME/docker/volumes/kafka-logs:/tmp/kafka-logs  johnnypark/kafka-zookeeper
}

function o {
    read -p "Are you sure?(Y/n) " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        poweroff
    else
        echo
    fi
}

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
alias rr='rm -rf'
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
            *.rar)         unrar x $1       ;;
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

[[ $- != *i* ]] && return
if [[ -z "$TMUX" && "$TERM" =~ ^xterm.*$ ]]; then
    exec tmux -u -2
elif [[ -z "$TMUX" ]]; then
    exec tmux -u
fi
