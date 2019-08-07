#!/bin/sh

if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

# Remap Caps-Lock to Ctrl
setxkbmap us -option ctrl:nocaps
# Get Caps-Lock by hitting both Shift keys at once
setxbbmap us -option shift:both_capslock
exec i3
