#~/.bash_aliases - personal aliases sourced by ~/.nashrc
#for consistency, headers are wrapped in #,
#and braces are on columns 52-54.

############
#navigation#
############
#--------------------------------------------------{{{
alias up='cd ..'
#ls variations
alias ls='ls --color=auto'
alias  l='ls -CF'
alias ll='ls -alhF'
alias ld='ls -AlhFd'
#grep coloring
alias grep='grep --color=auto'
#go to previous directory
alias pd='cd -'
#--------------------------------------------------}}}

#######################
#application launching#
#######################
#--------------------------------------------------{{{
#use new location for tmux.conf
alias tmux='tmux -f ~/.tmux/conf'
#quiet the gdb startup messages
alias gdb='gdb -q'
#--------------------------------------------------}}}

################
#system options#
################
#--------------------------------------------------{{{
#check battery level
alias bat='cat /sys/class/power_supply/BAT0/capacity'
#adjust brightness to % passed in of max_brightness
alias bl='sudo /home/oh/code/dotfiles/scripts/bl'
#quick volume manipulation
alias vol='alsamixer'
#view current colors
alias colors='msgcat --color=test | head -n12'
#--------------------------------------------------}}}

################
#system actions#
################
#--------------------------------------------------{{{
#sudo with aliases
alias sudo='sudo '
#make wireless on/off easier
alias wu='sudo ip link set wlp1s0 up'
alias wd='sudo ip link set wlp1s0 down'
#I type 'startx' way too much for 6 chars
alias sx='startx'
#suspend and close terminal
alias zx='/home/oh/code/dotfiles/scripts/zzz && exit'
#quickly source bashrc
alias s='. ~/.bashrc'
#too much typing not to do this
alias a='tmux attach -t work || tmux new-session -s work'
#burn cd
#alias burn='wodim -eject -tao speed=2 dev=/dev/cdrom -v -data'
#rip cd and lock button
alias ripit='eject -i on; ripit'
#change mouse cursor theme
cur()
{
    if [ "$#" == 0 ]; then
        theme=$(cat ~/.icons/default/index.theme | grep '=' | sed -r 's/Inherits=(\S+).*/\1/')
        echo "Cursor Theme is currently: $theme"
    fi

    if [ "$#" == 1 ]; then
        if [ -d ~/.icons/$1 ]; then
            text="[Icon Theme]\nInherits=$1"
            echo -e $text | tee ~/.icons/default/index.theme > /dev/null

            rm ~/.icons/default/cursors
            ln -s ~/.icons/$1/cursors ~/.icons/default/cursors

        else
            echo -e "Error: Cursor Theme: /'$1/' not found.\n    Ensure that the desired theme is correctly installed and check case."
        fi
    fi
}
# General wifi function instead of the stuff before
con() {
    # Incorrect with no params
    if [ "$#" == 0 ]; then
        printf "I need at least a network to connect to"
    # Correct with 1 param
    elif [ "$#" == 1 ]; then
        # kill all connections
        if [ "$1" == "kill" ]; then
            sudo pkill dhcpcd && sudo pkill wpa_supplicant
        # Connect to desired wifi
        elif [ -f "/etc/wpa_supplicant/$1" ]; then
            sudo wpa_supplicant -B -i wlp1s0 -c "/etc/wpa_supplicant/$1" -qq && sudo dhcpcd -4 wlp1s0 -q -b
        fi
    fi
}
#alert when done something
alias beep='echo -ne "\a" && sleep 0.2 && echo -ne "\a" && sleep 0.2 && echo -ne "\a"'
#for source file templates
new()
{
    #too few
    if [ "$#" == 0 ]; then
        printf "new [descriptor]\n\tdescriptor = { html | rng | sdl | tex }\n" 
    fi

    #normal use
    if [ "$#" == 1 ]; then
        #assignment
        if [ $1 == "html" ]; then which=ex.html; fi
        if [ $1 == "rng" ]; then which=rng.c; fi
        if [ $1 == "sdl" ]; then which=sdl.c; fi
        if [ $1 == "tex" ]; then which=ex.tex; fi

        #actual copying
        cp /home/oh/code/utils/templates/$which ./
    fi

    #too many
    if [ "$#" -gt 1 ]; then
        printf "new [descriptor]\n\tdescriptor = { html | rng | sdl }\n" 
    fi
}
#I'm a dingbat, this doesn't need to be in /bin
alias tw='/home/oh/code/utils/texwatch'
#gotta go fast
alias v='vim'
#easy gpg usage
alias encrypt='gpg2 --encrypt'
alias decrypt='gpg2 --decrypt'
#single grep decrypt so I don't print excess
gpgrep() {
    if [ "$#" -ne 2 ]; then
        printf "Hey, make sure you pass a file and a pattern\n"
    else
        #decrypt file and find case insesitive match with the password below
        gpg2 --decrypt $1 | grep -e $2 -A 1 -i
    fi
}
#now easy combo
gpedit() {
    if [ "$#" -ne 1 ]; then
        printf "Hey, make sure you pass just a file\n"
    else
        gpg2 --decrypt $1 > tmp && \
        vim tmp && \
        gpg2 --output $1 --encrypt tmp
    fi
    #ensure recryption save has occurred before deleting tmp
    if [ -f "$1" ]; then
        rm tmp
    fi
}
#better aur interface
aur() {
    git clone https://aur.archlinux.org/$1.git ~/builds/$1
}
# Forget how to install plugins for pathogen
pathogen() {
    if [ "$#" -ne 1 ]; then
        printf "Pass me one repo and one repo only.\n"
    else
        install_path=$(echo "$1" | cut -d'/' -f2)
        git clone https://github.com/$1 $HOME/.vim/bundle/$install_path
    fi
}

#list git repos
alias repos="find ~ -name .git | sed 's:/home/oh:~:' | sed 's:/.git::' | grep -v -e .*/dotfiles/.*"
#quick sleep
alias zzz='/home/oh/code/dotfiles/scripts/zzz'
#better calendar
alias cal3='cal --sunday --three'
# Nobody wants ghostscript
alias gs='git status'
# Typos be gone!
alias getpkg='/home/oh/code/dotfiles/scripts/pac_fail'
#--------------------------------------------------}}}

# vim: set foldmethod=marker:
