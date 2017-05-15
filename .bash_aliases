#navigation
alias up='cd ..'

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

#go home
alias home='cd ~'

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
#toggle light dm service
alias guion='sudo service lightdm start; chvt 7'
alias guioff='sudo service lightdm stop'
#make wireless on/off easier
alias wifi='nmcli r wifi'
#compile fast
alias cl='make all'

#suspend
alias zzz='systemctl suspend'
#suspend and close terminal
alias zx='systemctl suspend; exit'
