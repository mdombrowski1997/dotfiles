#!/bin/sh

if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

# Remap Caps-Lock to Ctrl
setxkbmap us -option ctrl:nocaps

# Start libinput-gestures (restart if already running)
libinput-gestures-setup restart

# https://code.visualstudio.com/docs/editor/settings-sync#_troubleshooting-keychain-issues
# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p "$HOME"/.local/share/keyrings

exec i3
