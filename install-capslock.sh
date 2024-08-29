#!/bin/bash

echo "Downloading and installing the package..."

if command -v rpm-ostree &> /dev/null; then
    echo "Installing package using rpm-ostree..."
    curl -sSL https://github.com/rogerfk/capslock-fix-rpm/releases/latest/download/capslock-delay-fix.rpm -o /tmp/capslock-delay-fix.rpm
    rpm-ostree install /tmp/capslock-delay-fix.rpm
elif command -v dnf &> /dev/null; then
    echo "Installing package using dnf..."
    sudo dnf install -y https://github.com/rogerfk/capslock-fix-rpm/releases/latest/download/capslock-delay-fix.rpm
elif command -v rpm &> /dev/null; then
    echo "Installing package using rpm..."
    curl -sSL https://github.com/rogerfk/capslock-fix-rpm/releases/latest/download/capslock-delay-fix.rpm -o /tmp/capslock-delay-fix.rpm
    sudo rpm -ivh /tmp/capslock-delay-fix.rpm
else
    echo "Error: Unable to find a suitable package manager to install the package."
    exit 1
fi

rm -f /tmp/capslock-delay-fix.rpm