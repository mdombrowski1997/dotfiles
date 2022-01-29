#~/.bash_aliases - personal aliases sourced by ~/.bashrc
# for consistency, headers are wrapped in #,
# and braces are on columns 52-54.

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
#quiet the gdb startup messages
alias gdb='gdb -q'
# Pretend I have yarn scripts
run() {
    usage() {
        printf "usage run <command>\n"
    }

    scripts="$PWD/.scripts.sh"
    if [[ -f "$scripts" ]]; then
        (
            source $scripts

            if [[ $# -eq 1 ]]; then
                cmd=$1
                output=$(command -v $cmd)
                if [[ -n $output ]]; then
                    $cmd
                else
                    printf "Error: command \"$cmd\" not found in \"$scripts\".\n"
                fi
            else
                usage
            fi
        )
    else
        printf "Error: file \"$scripts\" not found.\n"
    fi
}
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
# Too much typing not to do this
alias a='~/.config/i3/F1'
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
    usage() {
        printf "usage: con <config>\n"
    }
    # Incorrect with no params
    if [ "$#" == 0 ]; then
        usage
        # Correct with 1 param
    elif [ "$#" == 1 ]; then
        # kill all connections
        if [ "$1" == "kill" ]; then
            sudo pkill dhcpcd && sudo pkill wpa_supplicant && sudo rm -rf /var/run/wpa_supplicant
            # Connect to desired wifi
        elif [ -f "/etc/wpa_supplicant/$1" ]; then
            sudo wpa_supplicant -B -i wlp1s0 -c "/etc/wpa_supplicant/$1" -qq
            if [ "$?" == "0" ];  then
                # while [ -z "$success" ]; do 
                    output=$(sudo dhcpcd -4 wlp1s0 -t0 --noarp)
                    success=$(grep 'forked to background' <<< $output)
                    failure=$(grep 'dhcpcd exited' <<< $output)
                    if [ -n "$failure" ]; then
                        printf "$output\n"
                    else
                        printf "$success\n"
                    fi
                # done
            else
                printf "Error in initializing wpa_supplicant\n"
            fi
        else
            usage
        fi
    fi
}
#alert when done something
alias beep='echo -ne "\a" && sleep 0.2 && echo -ne "\a" && sleep 0.2 && echo -ne "\a"'
# I'm a dingbat, this doesn't need to be in /bin
alias tw='/home/oh/code/utils/texwatch'
# Gotta go fast
alias v='vim'
# Easy gpg usage
alias encrypt='gpg2 --encrypt'
alias decrypt='gpg2 --decrypt'
# Single grep decrypt so I don't print excess
gpgrep() {
    if [ "$#" -ne 2 ]; then
        printf "Hey, make sure you pass a file and a pattern\n"
    else
        # Decrypt file and find case insesitive match with the password below
        gpg2 --decrypt $1 | grep -e $2 -A 1 -i
    fi
}
# Now easy combo
gpedit() {
    if [ "$#" -ne 1 ]; then
        printf "Hey, make sure you pass just a file\n"
    else
        gpg2 --decrypt $1 > tmp && \
            vim tmp && \
            gpg2 --output $1 --encrypt tmp
    fi
    # Ensure recryption save has occurred before deleting tmp
    if [ -f "$1" ]; then
        rm tmp
    fi
}
# Better aur interface
aur() {
    build_dir="$HOME/builds"
    url="https://aur.archlinux.org/$1.git"
    echo "Fetching package \"$1\" from \"$url\""
    git clone $url $build_dir/$1

    if [[ $? -eq 0 ]]; then
        echo "Fetch successful"
        prevdir=$PWD
        cd "$HOME/builds/$1"
        echo "Running 'makepkg -sci' to build."
        makepkg -sci
        if [[ $? -eq 0 ]]; then
            echo "Build successful"
        else
            echo "Build failed"
        fi
        cd "$prevdir"
    else
        rmdir "$HOME/builds/$1"
    fi
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
join_by() {
    local IFS="$1"
    echo "${$2[*]}"
}
# Networking made easy
scan() {
    if [ "$#" -gt 1 ]; then
        printf "Pass me one exactly one interface.\n"
    elif [ "$#" -eq 0 ]; then
        interface='wlp1s0'
    elif [ "$#" -eq 1 ]; then
        interface=$1
    fi

    output=$(sudo iw dev wlp1s0 scan | grep -E 'SSID:|WPA:' | uniq) # | tr 'WPA:' 'TRUE') # | cut -d':' -f2)
    echo $output
    return

    # Build array manually
    let len=0
    for line in $output; do
        lines[$len]=$line
        # echo "$i $line"
        let len=$len+1
    done

    # Get secured networks
    declare -A secured
    for i in "${!lines[@]}"; do
        if [[ ${lines[$i]} == *'TRUE'* ]]; then
            let prev=$i-1
            echo ${lines[$prev]}
            secured[$i]=${lines[$prev]}
        fi
    done
    # secured=$(echo ${secured[*]} | cut -d':' -f2 | sort | uniq)
    # secured=$(local IFS=$'\n'; echo "${secured[*]}")
    # secured=$(printf "%s\n" "${secured[@]}")
    # secured=$(printenv)
    # printenv
    printf "%s\n" "${secured[@]}"
    echo
    # printf -v secured "%s\n" "${secured[@]}"
    # secured=$(echo $secured | cut -d':' -f2 | sort | uniq)

    # echo $secured
    # Lock 🔒

    # declare -A unsecured

    # Print networks 
}
connect() {
    if [ "$#" -gt 2 ]; then
        printf 'Usage: connect ssid [interface]\n'
        return
    elif [ "$#" -lt 1 ]; then
        printf 'Usage: connect ssid [interface]\n'
        return
    elif [ "$#" -eq 1 ]; then
        interface='wlp1s0'
    elif [ "$#" -eq 2 ]; then
        interface=$2
    fi
    ssid=$1

    sudo iw dev $interface connect -w $ssid && 
        if [ ! $(pgrep dhcpcd) ]; then
            sudo dhcpcd -4 $interface
        fi
}
#--------------------------------------------------}}}

# vim: set foldmethod=marker:

