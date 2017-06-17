#~/.bash_aliases - personal aliases sourced by ~/.bashrc
#for consistency, headers are wrapped in #,
#and braces are on columns 52-54.

############
#navigation#
############
#--------------------------------------------------{{{
alias up='cd ..'
#go home
alias home='cd ~'
#quick movement to common dirs
alias dof='cd ~/Documents/Code/bash/dotfiles'
#quick go to cpp projects
alias gcpp='cd ~/Documents/Code/cpp'
#reset to default like I just logged in
alias res='home && clear && cat .todo'
#ls variations
alias ls='ls --color=auto'
alias  l='ls -CF'
alias ll='ls -alhF'
#grep coloring
alias grep='grep --color=auto'
#list git repos
alias repos='find -name .git'
#quick pi connection
alias pi='ssh alarm@alarmpi'
#--------------------------------------------------}}}

#######################
#application launching#
#######################
#--------------------------------------------------{{{
#launch notepadqq for heavier editing
alias text='notepadqq &> /dev/null & echo ""'
#launch chromium browser
alias web='chromium-browser &> /dev/null & echo ""'
#launch system monitor
alias usage='gnome-system-monitor &> /dev/null & echo ""'
#launch libre office write
alias lowriter='lowriter &> /dev/null & echo ""'
#launch spotify
alias spotify='spotify &> /dev/null & echo ""'
#--------------------------------------------------}}}

################
#system options#
################
#--------------------------------------------------{{{
#check battery level
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|percentage" | grep -v "discharging"'
#adjust brightness to % passed in of max_brightness
blight()
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
alias sizeof='du -hs'
#check apps downloaded with apt-get
alias apps='zcat /var/log/apt/history.log.*.gz | cat - /var/log/apt/history.log | grep -Po '"'"'^Commandline: apt-get install (?!.*--reinstall)\K.*'"'"''
#--------------------------------------------------}}}

################
#system actions#
################
#--------------------------------------------------{{{
#toggle light dm service
alias guion='sudo service lightdm start'
alias guioff='sudo service lightdm stop'
#make wireless on/off easier
alias wifi='nmcli r wifi'
#compile fast
alias cl='make all'
#suspend
alias zzz='systemctl suspend'
#suspend and close terminal
alias zx='systemctl suspend; exit'
#quickly source bashrc
alias src='. ~/.bashrc'
#burn cd
alias burn='wodim -eject -tao speed=2 dev=/dev/cdrom -v -data'
#--------------------------------------------------}}}

# vim: set foldmethod=marker:
