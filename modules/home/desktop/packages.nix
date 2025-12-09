{pkgs, ...}: {
  home.packages = with pkgs; [
    # Core
    ## core utils
    coreutils
    lsof
    tree
    gnumake
    stow
    most # view with less functions
    platinum-searcher # find but better
    wget

    ## core utils rebuilt
    fzf
    bat
    eza # ls
    ripgrep

    ## extra utils
    xsel # copy & paste
    killall
    gettext
    nmap # internet
    # helix # to be replaced by gj1118
    vim

    ## Drivers
    edid-decode # decode video transfer protocols?
    avahi # internet

    ## network
    curl
    wget
    netcat-gnu
    openssh
    openssl
    cloudflared

    ## Others
    dex # generate desktop entries

    # sys info
    libnotify
    speedtest-cli
    usbutils

    # CLI / term
    ## Tmux
    zellij
    tmux
    ## Shell
    bash
    fish
    zsh
    nushell
    # bash-completion
    zsh-completions
    zsh-syntax-highlighting

    ## shell prompt
    starship
    blesh

    ## system info
    btop
    cpufetch
    fastfetch
    nitch

    ## hardware info
    baobab # harddisk usage visualizer
    duf # cli harddisk usage visualizer
    hwinfo # hw info in a long, long stream of characters
    lshw # this looks similar to hwinfo because I can't read either
    inxi # human readable hwinfo
    hw-probe # collect hardware info and send

    # CLI Apps
    ## git
    git
    lazygit
    tig
    difftastic
    gitleaks
    gh
    ghq

    ## Other CLI Apps
    ncdu # tui disk usage

    # utils
    ## file
    yazi # cli file manager
    zip
    unzip # unzips files
    ffmpeg # convert any music/video files
    inotify-tools
    fsearch # a file searcher

    ## image
    imagemagick # image editor

    ## others
    volumeicon # edit volume from sys tray
    appimage-run

    filezilla # a free ftp client + server
    networkmanagerapplet # network manager in systray

    # nix
    nix-index
    nixos-generators # convert the config into other formats
    hydra-check
  ];
}
