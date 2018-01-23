#~/.bash_aliases - personal aliases sourced by ~/.nashrc
#for consistency, headers are wrapped in #,
#and braces are on columns 52-54.

############
#navigation#
############
#--------------------------------------------------{{{
alias up='cd ..'
#quick movement to common dirs
#alias dof='cd ~/Documents/Code/bash/dotfiles'
#quick go to cpp projects
#alias gcpp='cd ~/Documents/Code/cpp'
#reset to default like I just logged in
#alias res='cd && clear && cat .todo'
#ls variations
alias ls='ls --color=auto'
alias  l='ls -CF'
alias ll='ls -alhF'
alias ld='ls -AlhFd'
#grep coloring
alias grep='grep --color=auto'
#list git repos
alias repos='find ~ -name .git'
#quick pi connection
#alias pi='ssh alarm@alarmpi'
#see last commit for git repo
alias lc='git show --summary'
#go to previous directory
alias pd='cd -'
#I do this too often
alias rd='rm -r'
#add some pushd/popd/dirs stuff
#--------------------------------------------------}}}

#######################
#application launching#
#######################
#--------------------------------------------------{{{
#launch notepadqq for heavier editing
#alias text='notepadqq &> /dev/null & echo ""'
#launch chromium browser
#alias web='chromium-browser &> /dev/null & echo ""'
#launch system monitor
#alias usage='gnome-system-monitor &> /dev/null & echo ""'
#launch libre office write
#alias lowriter='lowriter &> /dev/null & echo ""'
#launch spotify
#alias spotify='spotify &> /dev/null & echo ""'
#use new location for tmux.conf
alias tmux='tmux -f ~/.tmux/conf'
#quick burn cd
alias burn='cdrecord -v -pad speed=1 dev=/dev/sr0 -dao -swab *.wav'
#roll dice quicker
alias d='dice'
#--------------------------------------------------}}}

################
#system options#
################
#--------------------------------------------------{{{
#check battery level
#alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage" | grep -v "discharging"'
alias bat='cat /sys/class/power_supply/BAT0/capacity'
#adjust brightness to % passed in of max_brightness
bl()
{
    if [ "$#" == 0 ]; then
        curblightlvl=$(cat /sys/class/backlight/intel_backlight/brightness)
        ((curblightlvl = curblightlvl / 44))

        echo "   backlight is currently: $curblightlvl"
    fi

    if [ "$#" == 1 ]; then
        ((blightlvl = $1 * 44))

        echo $blightlvl | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null
    fi
}
#quick volume manipulation
alias vol='alsamixer'
#quick check size of folder
alias so='du -hs'
#quick time/date output when no tmux
#alias t='echo -n "  " && date +%-I:%M\ %p'
#check apps downloaded with apt-get
#alias apps='zcat /var/log/apt/history.log.*.gz | cat - /var/log/apt/history.log | grep -Po '"'"'^Commandline: apt-get install (?!.*--reinstall)\K.*'"'"''
#--------------------------------------------------}}}

################
#system actions#
################
#--------------------------------------------------{{{
#toggle light dm service
#alias guion='sudo service lightdm start'
#alias guioff='sudo service lightdm stop'
#make wireless on/off easier
#alias wifi='nmcli r wifi'
alias wu='sudo ip link set wlp3s0 up'
alias wd='sudo ip link set wlp3s0 down'
#I type 'startx' way too much for 6 chars
alias sx='startx'
#compile fast
alias cl='make all'
#suspend
alias zz='sudo systemctl suspend'
#suspend and close terminal
alias zx='sudo systemctl suspend; exit'
#quickly source bashrc
alias s='. ~/.bashrc'
#too much typing not to do this
alias a='tmux a'
#burn cd
#alias burn='wodim -eject -tao speed=2 dev=/dev/cdrom -v -data'
#rip cd and lock button
alias ripit='eject -i on; ripit'
#change mouse cursor theme
cur()
{
    if [ "$#" == 0 ]; then
        theme=$(cat ~/.icons/default/index.theme | grep '=' | sed -r 's/Inherits=(\S+).*/\1/')
        echo "   Cursor Theme is currently: $theme"
    fi

    if [ "$#" == 1 ]; then
        if [ -d ~/.icons/$1 ]; then
            text="[Icon Theme]\nInherits=$1"
            echo -e $text | tee ~/.icons/default/index.theme > /dev/null

            rm ~/.icons/default/cursors
            ln -s ~/.icons/$1/cursors ~/.icons/default/cursors

        else
            echo -e "    Cursor Theme: /'$1/' not found.\n    Ensure that the desired theme is correctly installed and check case."
        fi
    fi
}
#seek and destroy process(es)
hunt()
{
    #search and stop at this process
    var=$(ps aux | grep $1 | awk 'BEGIN {} {if ($11=="grep") exit; else print $2} END {}')
    #get rid of \n's
    var=$(echo $var | tr -d "\012")
    #confirmation
    echo -n "Are you sure you want to kill process(es) $var labeled $1? [y/n]: "
    read check
    if [ $check == "y" ]; then
        #kill desired process(es)
        sudo kill $var
    else
        echo "OK, aborting..."
    fi
}
#quick liberty wifi connect
alias libcon='sudo wpa_supplicant -B -i wlp3s0 -c /etc/wpa_supplicant/Liberty-Secure && sudo dhcpcd -4 wlp3s0'
#fix psmouse modules faster
alias psm='sudo modprobe psmouse'
alias psr='sudo modprobe -r psmouse'
#no need to explain
alias wifi-menu='sudo wifi-menu'
#--------------------------------------------------}}}

# vim: set foldmethod=marker:
