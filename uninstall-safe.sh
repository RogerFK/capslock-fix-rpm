#!/bin/bash

set -e

# Run the remap_capslock.sh script with the uninstall argument
if [ -f /usr/bin/remap_capslock.sh ]; then
    echo "Reverting capslock changes..."
    /usr/bin/remap_capslock.sh uninstall
fi

# Uninstall the package
if command -v rpm-ostree &> /dev/null; then
    echo "Uninstalling package using rpm-ostree..."
    sudo rpm-ostree uninstall capslock-delay-fix
elif command -v dnf &> /dev/null; then
    echo "Uninstalling package using dnf..."
    sudo dnf remove capslock-delay-fix
    # Remove any leftover files
    sudo rm -f /usr/share/X11/xkb/symbols/capslock
    sudo rm -f /etc/xdg/autostart/apply-custom-capslock.desktop
    sudo rm -f /usr/bin/remap_capslock.sh
elif command -v rpm &> /dev/null; then
    echo "Uninstalling package using rpm..."
    sudo rpm -e capslock-delay-fix
    # Remove any leftover files
    sudo rm -f /usr/share/X11/xkb/symbols/capslock
    sudo rm -f /etc/xdg/autostart/apply-custom-capslock.desktop
    sudo rm -f /usr/bin/remap_capslock.sh
else
    echo "Error: Unable to find a suitable package manager to uninstall the package."
    exit 1
fi

echo "Uninstallation complete. Please reboot your system for changes to take effect."