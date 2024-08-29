Name:           capslock-delay-fix
Version:        1.0
Release:        1%{?dist}
Summary:        Fix capslock delay for X11 and Xwayland

License:        MIT
URL:            https://github.com/rogerfk/capslock-fix-rpm
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  meson
BuildRequires:  ninja-build

Requires:       xkeyboard-config

%description
Fix capslock delay for X11 and Xwayland, thanks to https://forum.manjaro.org/t/caps-lock-behaviour-wayland/79868/8

%prep
%setup -q -n %{name}

%build
%meson
%meson_build

%install
%meson_install

# Create the bin directory if it doesn't exist
mkdir -p %{buildroot}%{_bindir}

# Install remap capslock script
install -m 755 remap_capslock.sh %{buildroot}%{_bindir}/remap_capslock.sh

%files
%attr(0644,root,root) %{_datadir}/X11/xkb/symbols/capslock
%attr(0644,root,root) %{_sysconfdir}/xdg/autostart/apply-custom-capslock.desktop
%attr(0755,root,root) %{_bindir}/remap_capslock.sh

%preun
if [ $1 -eq 0 ]; then
    %{_bindir}/remap_capslock.sh uninstall
fi


%changelog
* Thu Aug 29 2024 Jorge G <the@jor.gg> - 1.0-1
- Initial package