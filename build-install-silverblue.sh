#!/bin/bash

# DISCLAIMER: I used this script to build and install the package on my own system as a test. 
#             I am not responsible if it messes up your system, or if it doesn't work for you.

DEVTOOLBOX=${DEVTOOLBOX:-dev}

set -e

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
mkdir -p ~/rpmbuild/SPECS/
cp capslock-delay-fix.spec ~/rpmbuild/SPECS/

# Copy necessary files to the temporary directory
mkdir -p $TEMP_DIR/capslock-delay-fix/
cp meson.build $TEMP_DIR/capslock-delay-fix/
cp capslock $TEMP_DIR/capslock-delay-fix/
cp apply-custom-capslock.desktop $TEMP_DIR/capslock-delay-fix/
cp remap_capslock.sh $TEMP_DIR/capslock-delay-fix/

# Check if the toolbox exists, create it if it doesn't
if ! toolbox list | grep -q "$DEVTOOLBOX"; then
    echo "Creating toolbox '$DEVTOOLBOX'..."
    toolbox create $DEVTOOLBOX
fi

# Enter the toolbox
toolbox enter $DEVTOOLBOX << EOF
# Install necessary build tools if not already installed
if ! command -v rpmbuild &> /dev/null; then
    echo "Installing rpmbuild..."
    sudo dnf install -y rpm-build
fi

if ! command -v meson &> /dev/null; then
    echo "Installing meson..."
    sudo dnf install -y meson
fi

if ! command -v ninja &> /dev/null; then
    echo "Installing ninja-build..."
    sudo dnf install -y ninja-build
fi

# Create necessary directories
mkdir -p ~/rpmbuild/{SOURCES,SPECS,BUILD}

# Create the tarball
cd $TEMP_DIR
tar czf ~/rpmbuild/SOURCES/capslock-delay-fix-1.0.tar.gz capslock-delay-fix

# Build the RPM
rpmbuild -ba ~/rpmbuild/SPECS/capslock-delay-fix.spec

# Exit the toolbox
exit
EOF

# Get the latest RPM file
LATEST_RPM=$(ls -t ~/rpmbuild/RPMS/noarch/capslock-delay-fix-*.noarch.rpm | head -n1)

# Install the latest generated package using rpm-ostree
rpm-ostree install --force-replacefiles "$LATEST_RPM"

# Clean up
rm -rf $TEMP_DIR

echo "Package built and installed. Please reboot to apply changes."