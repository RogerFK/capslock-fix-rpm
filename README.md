# capslock-fix-rpm

This repository contains the source code for a RPM package that fixes the delay in the capslock key on Fedora Silverblue.

## Installation

To install the latest release from GitHub, run the following command:

```bash
curl https://github.com/rogerfk/capslock-fix-rpm/releases/latest/download/install-capslock.sh | sh
```
Smaller link, directly from my server:

```bash
curl https://rhel.jor.gg/capslock.sh | sh
```

## Building the RPM package

To build the RPM package, you need to have the following tools installed:

* `rpmbuild`
* `meson`
* `ninja-build`

Then, run the following command to run in Silverblue:

```bash
./build-install-silverblue.sh
```

## Hold on, why isn't it a Makefile?

Silverblue doesn't have `make` installed by default, and I just wanted to try out `meson` to build the package as (xkeyboard-config)[https://rpmfind.net/linux/RPM/fedora/40/x86_64/x/xkeyboard-config-2.41-1.fc40.noarch.html] uses it and it was a good opportunity to learn how `.spec` files are made.

## Credits

* [xkeyboard-config](https://rpmfind.net/linux/RPM/fedora/40/x86_64/x/xkeyboard-config-2.41-1.fc40.noarch.html) for the `.spec` file and `capslock` file as a base.
* [paulozane](https://forum.manjaro.org/t/caps-lock-behaviour-wayland/79868/8) for the `capslock` hack as well as the concept behind the `remap_capslock.sh` file.
* [rogerfk](https://github.com/rogerfk) for everything else.