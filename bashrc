#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export VISUAL=vim
export EDITOR=$VISUAL


## ALIAS SECTION##

### DOOM II! ###
alias chocolate-doom="chocolate-doom -iwad /home/yan/Downloads/doom2.wad"

alias sudo='sudo '

## Web server
alias web='sudo /opt/lampp/xampp start'
alias noweb='sudo /opt/lampp/xampp stop'
alias sun='ssh dorosyan@sunray1.felk.cvut.cz'

#FS ALIASES
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias grep='grep --color=auto'
alias downloads='cd ~/Downloads'
alias drop='cd /mnt/Files/Dropbox'
alias zal='cd /mnt/Files/Dropbox/studies/ZAL'
alias zwa='cd /mnt/Files/Dropbox/studies/ZWA/project'
alias docs='cd ~/Documents'
alias rm='rm -r'
alias cp='cp -r'
alias mkdir='mkdir -p'

# EXTRACTION SCRIPT
extract () {
    if [ -f $1 ] ; then
	case $1 in
	    *.tar.bz2)     tar xvjf $1    ;;
	    *.tar.gz)      tar xvzf $1    ;;
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
alias get='yaourt -S '
alias unget='yaourt -Rncs '
alias upd='yaourt -Syu '
alias mess='yaourt -Qdt '
alias list='yaourt -Q | grep'

PS1='\[\e[1;32m\]\u\[\e[m\] \[\e[0;37m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '

# Convert pdf to jpg

function pdftojpg {
bash /home/yan/git/unixStuff/pdftojpg.sh "$1";
}

# function Extract for common file formats

function extract {
if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
else
    if [ -f "$1" ] ; then
	NAME=${1%.*}
	#mkdir $NAME && cd $NAME
	case "$1" in
	    *.tar.bz2)   tar xvjf ./"$1"    ;;
	    *.tar.gz)    tar xvzf ./"$1"    ;;
	    *.tar.xz)    tar xvJf ./"$1"    ;;
	    *.lzma)      unlzma ./"$1"      ;;
	    *.bz2)       bunzip2 ./"$1"     ;;
	    *.rar)       unrar x -ad ./"$1" ;;
	    *.gz)        gunzip ./"$1"      ;;
	    *.tar)       tar xvf ./"$1"     ;;
	    *.tbz2)      tar xvjf ./"$1"    ;;
	    *.tgz)       tar xvzf ./"$1"    ;;
	    *.zip)       unzip ./"$1"       ;;
	    *.Z)         uncompress ./"$1"  ;;
	    *.7z)        7z x ./"$1"        ;;
	    *.xz)        unxz ./"$1"        ;;
	    *.exe)       cabextract ./"$1"  ;;
	    *)           echo "extract: '$1' - unknown archive method" ;;
	esac
    else
	echo "'$1' - file does not exist"
    fi
fi
}
