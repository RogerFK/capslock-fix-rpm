#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# GNOME and Budgie
if command_exists gsettings; then
    # Check if the first argument is defined and is 'u' or 'uninstall'
    if [ -n "$1" ] && { [ "$1" = "u" ] || [ "$1" = "uninstall" ]; }; then
        gsettings set org.gnome.desktop.input-sources xkb-options "['caps:capslock']"
        exit 0
    fi
    gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
    exit 0
fi

# KDE
if command_exists kwriteconfig5; then
    # Check if the first argument is defined and is 'u' or 'uninstall'
    if [ -n "$1" ] && { [ "$1" = "u" ] || [ "$1" = "uninstall" ]; }; then
        kwriteconfig5 --file kxkbrc --group "Layout" --key "Options" "caps:capslock"
        exit 0
    fi
    kwriteconfig5 --file kxkbrc --group "Layout" --key "Options" "caps:ctrl_modifier"
    exit 0
fi

# XFCE
if command_exists xfconf-query; then
    # Check if the first argument is defined and is 'u' or 'uninstall'
    if [ -n "$1" ] && { [ "$1" = "u" ] || [ "$1" = "uninstall" ]; }; then
        xfconf-query -c keyboard-layout -p /Default/XkbOptions/Compose -n -t string -s "caps:capslock"
        exit 0
    fi
    xfconf-query -c keyboard-layout -p /Default/XkbOptions/Compose -n -t string -s "caps:ctrl_modifier"
    exit 0
fi

# Generic X11 (fallback for XFCE and others)
if command_exists setxkbmap; then
    # Check if the first argument is defined and is 'u' or 'uninstall'
    if [ -n "$1" ] && { [ "$1" = "u" ] || [ "$1" = "uninstall" ]; }; then
        setxkbmap -option "caps:capslock"
        exit 0
    fi
    setxkbmap -option "caps:ctrl_modifier"
    exit 0
fi