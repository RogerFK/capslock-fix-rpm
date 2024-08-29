project('capslock-delay-fix',
        version: '1.0',
        license: 'MIT',
        meson_version: '>= 0.54.0')

dir_data = join_paths(get_option('prefix'), get_option('datadir'))
dir_xkb_base = join_paths(dir_data, 'X11', 'xkb')

install_data('capslock',
             install_dir: join_paths(dir_xkb_base, 'symbols'))
install_data('apply-custom-capslock.desktop',
             install_dir: join_paths(get_option('sysconfdir'), 'xdg', 'autostart'))