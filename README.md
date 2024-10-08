# capslock-fix-rpm

This repository contains the source code for a RPM package that fixes the delay in the capslock key on Fedora Workstation, Fedora Silverblue and other Fedora flavours, most notably OSTree like Fedora Kinoite, Sway Atomic and Budgie Atomic.

I hope it also serves as a relatively decent example for anyone trying to make an RPM to edit a file in OSTree based systems without requiring a `ostree admin unlock --hotfix`.

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

Silverblue doesn't have `make` installed by default, and I just wanted to try out `meson` to build the package as [xkeyboard-config](https://rpmfind.net/linux/RPM/fedora/40/x86_64/x/xkeyboard-config-2.41-1.fc40.noarch.html) uses it and it was a good opportunity to learn how `.spec` files are made.

## It didn't work on <another distro other than Fedora Silverblue>
First things first: I used `build-install-silverblue.sh` for myself. Should work on OSTree RPM based distros with toolbox, but that's it.

Second: if it didn't change, in GNOME with GNOME Tweaks you can go to **`Additional Layout Options` -> `Caps Lock behaviour` -> `Make Caps Lock an additional Ctrl`** so I'm expecting your DE to work the same. The `remap_capslock.sh` file was generated by Claude 3.5 Sonnet, so it could work or could be a command from 2016, fill an issue / PR with the fix if you have any trouble and manage to fix it yourself :)

## Future of this project
Best case: It works for me, the 10 people who use CapsLock for their caps are happy knowing Silverblue has "a fix for it" and I forget about it.

Worst case: If enough people want this behaviour also for the Steam Deck and nobody has done it I have a Steam Deck, I just don't use it for programming / work, believe it or not. As far as I know, the main results for CapsLock and Steam Deck are [this guy on Reddit who wanted to make Caps-Lock a Shift-Lock without the delay](https://www.reddit.com/r/linux_gaming/comments/s6hfpy/removing_the_delay_on_the_caps_lock_while_keeping/) and [this other guy on Reddit who wanted to change ShiftLock to CapsLock](https://www.reddit.com/r/SteamDeck/comments/ymzx3r/change_capslock_to_shift_key_in_desktop_mode/) but nobody was assed enough to tell him to do `sudo steamos-readonly disable` or to do an (OverlayFS or something.)[https://www.reddit.com/r/SteamDeck/comments/t6w9at/comment/hzdy59w/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button].

## Credits

* [xkeyboard-config](https://rpmfind.net/linux/RPM/fedora/40/x86_64/x/xkeyboard-config-2.41-1.fc40.noarch.html) for the `.spec` file and `capslock` file as a base.
* [paulozane](https://forum.manjaro.org/t/caps-lock-behaviour-wayland/79868/8) for the `capslock` hack as well as the concept behind the `remap_capslock.sh` file.
* [rogerfk](https://github.com/rogerfk) for everything else.
