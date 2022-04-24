# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=nvim
export EDITOR=$VISUAL

## ALIAS SECTION ##

# General system aliases #
alias v='nvim '
alias j='nvim /tmp/$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 32 | head -n 1).json'
alias s='sbt -jvm-debug 5150'
alias t='sbt clean coverage test coverageReport coverageGuard'

# History

# /etc/profile.d/best_bash_history.sh
# Save 5,000 lines of history in memory
HISTSIZE=10000
# Save 2,000,000 lines of history to disk (will have to grep ~/.bash_history for full listing)
HISTFILESIZE=2000000
# Append to history instead of overwrite
shopt -s histappend
# Ignore redundant or space commands
HISTCONTROL=ignoreboth
# Ignore more
HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'
# Set time format
HISTTIMEFORMAT='%F %T '
# Multiple commands on one line show up as a single line
shopt -s cmdhist

# Currency converter
alias currency='git/github/unixStuff/exchange.sh'


# Cmus music player
alias cmus='udisksctl mount -p block_devices/sda1 /mnt/hdd 2>/dev/null ; cmus'

alias dt='git difftool -y'

# AWS credentials setup
alias creds='~/git/resident/hub/tools/get_aws_credentials/okta_aws.py'

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
alias y='yay --color=always '
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

[[ $- != *i* ]] && return
if [[ -z "$TMUX" && "$TERM" =~ ^xterm.*$ ]]; then
    exec tmux -u -2
elif [[ -z "$TMUX" ]]; then
    exec tmux -u
fi

function vpn_on()
{
    nmcli c up $1
    #    sudo ip route add 192.168.10.1 dev ppp0
    sudo ip route add 172.16.0.0/12 dev ppp0
    sudo ip route add 10.0.0.0/8 dev ppp0
    sudo ip route add 192.168.224.0/19 dev ppp0
}

function vpn_off()
{
    nmcli c down prod || nmcli c down QA || true
    nmcli radio wifi off
    nmcli radio wifi on
}
alias prod='vpn_on prod'
alias qa='vpn_on QA'
alias off='vpn_off'

