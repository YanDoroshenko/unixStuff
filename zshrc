# Based off https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc

export PATH="/home/yan/.local/bin":$PATH

export VISUAL=nvim
export EDITOR=$VISUAL


# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Share history
setopt share_history

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=30

# Go to normal Vim mode
bindkey -M viins ';;' vi-cmd-mode
bindkey -M vicmd ' ' vi-insert

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

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

# General system aliases #
alias v="$EDITOR "
alias j='nvim /tmp/$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 32 | head -n 1).json'
alias s='sbt -jvm-debug 5150'
alias t='sbt clean coverage test coverageReport coverageGuard'
alias dt='git difftool -y'
alias sudo='doas '
alias sd='sudo $(fc -ln -1)'

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

# AWS credentials setup
alias creds='~/git/resident/hub/tools/get_aws_credentials/okta_aws.py'

# VPN
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

# View images
alias nsxiv="nsxiv-rifle $1"
alias i="nsxiv ."

# Set window title
local term_title () { print -n "\e]0;${(j: :q)@}\a" }
precmd () {
    local DIR="$(print -P '[%c]')"
    term_title "$DIR" "zsh"
}
preexec () {
    local DIR="$(print -P '[%c]')"
    local CMD="${(j:\n:)${(f)1}}"
    term_title "$DIR" "$CMD"
}

alias d2='sudo mount /dev/sda1 /mnt/hdd ; cd /mnt/hdd/diabloii/d2launcher-3.5.2 && ./d2launcher'

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
