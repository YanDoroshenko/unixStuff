# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=vim
export EDITOR=$VISUAL


## ALIAS SECTION ##

# General system aliases #
alias o='
read -p "Are you sure?(Y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    poweroff
else
    echo
fi
'
alias sudo='sudo '
alias k='xmodmap -e "keycode 134 = Menu"'

# Local PostgreSQL server #
alias db='
if [[ $(systemctl | grep postgres) ]]; then
    read -p "PostgreSQL server running. Stop?(Y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo systemctl stop postgresql.service
    fi
else
    read -p "PostgreSQL server not running. Start?(Y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	sudo systemctl start postgresql.service
    fi
fi'

# Touchpad on/off. Does not work in Wayland #
alias t='synclient TouchpadOff=0'
alias nt='synclient TouchpadOff=1'

# Coloring output #
alias ls='ls --color=always'
alias dmesg='dmesg --color=always'
alias grep='grep --color=always'
alias gcc='gcc -fdiagnostics-color=always'
alias pacman='pacman --color=always'
alias dir='dir --color=always'
alias la='ls -a --color=always'
alias ll='ls -l --color=always'

# FS aliases #
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias downloads='cd ~/Downloads'
alias drop='cd ~/Dropbox'
alias docs='cd ~/Documents'
alias rm='rm -r'
alias s='cd ~/Dropbox/studies'
alias cp='cp -r'
alias mkdir='mkdir -p'

# Connection aliases #
alias vpn='sudo openconnect vpn.cleverlance.com'
alias p='ping -c 3 google.com'

# Package aliases #
alias g='yaourt -S '
alias ug='yaourt -Rncs '
alias u='yaourt -Syu --aur '
alias m='yaourt -Qdt '
alias l='yaourt -Q | grep'

# Extraction script #
x () {
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)     tar xvjf $1    ;;
	    *.tar.gz)      tar xvzf $1    ;;
	    *.tar.xz)      tar xvJf $1    ;;
	    *.bz2)         bunzip2 $1     ;;
	    *.rar)         rar x $1       ;;
	    *.gz)          gunzip $1      ;;
	    *.tar)         tar xvf $1     ;;
	    *.tbz2)        tar xvjf $1    ;;
	    *.zip)         unzip $1       ;;
	    *.Z)           uncompress $1  ;;
	    *.7z)          7z x $1        ;;
	    *)             echo "don't know how to extract '%1'..."
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
