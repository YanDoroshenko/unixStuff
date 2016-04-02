#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=vim
export EDITOR=$VISUAL


## ALIAS SECTION ##
alias o='poweroff'
alias sudo='sudo '

## Touchpad on/off ##
alias t='synclient TouchpadOff=0'
alias nt='synclient TouchpadOff=1'

# Coloring output
alias ls='ls --color=always'
alias dmesg='dmesg --color=always'
alias grep='grep --color=always'
alias gcc='gcc -fdiagnostics-color=always'
alias pacman='pacman --color=always'
alias dir='dir --color=always'
alias la='ls -a --color=always'
alias ll='ls -l --color=always'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias downloads='cd ~/Downloads'
alias drop='cd /mnt/Files/Dropbox'
alias zal='cd /mnt/Files/Dropbox/studies/ZAL'
alias zwa='cd /mnt/Files/Dropbox/studies/ZWA/project'
alias docs='cd ~/Documents'
alias rm='rm -r'
alias k='cd /mnt/Files/Dropbox/studies/LinuxKernelChallenge/src'
alias s='cd /mnt/Files/Dropbox/studies'
alias cp='cp -r'
alias mkdir='mkdir -p'

# EXTRACTION SCRIPT
extract () {
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

#PACKAGE ALIASES
alias p='ping -c 3 google.com'
alias g='yaourt -S '
alias ug='yaourt -Rncs '
alias u='yaourt -Syua '
alias m='yaourt -Qdt '
alias l='yaourt -Q | grep'

# Convert pdf to jpg

function pdftojpg {
bash /home/yan/git/unixStuff/pdftojpg.sh "$1";
}

# Color prompt
if [[ ${EUID} == 0 ]]; then
PS1='\[\e[1;31m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] '
else
PS1='\[\e[1;32m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '
fi
