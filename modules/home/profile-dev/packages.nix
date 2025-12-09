{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv) system;
  nix-repository = inputs.nix-repository.packages.${system};
in {
  home.packages = with pkgs; [
    # Core utilities
    coreutils
    bash
    gnused
    gnumake
    tree
    lsof
    file
    psmisc
    gettext # i18n utilities
    appimage-run # run AppImage apps

    # File search & navigation
    ripgrep
    fd
    eza
    bat
    fzf
    yazi

    # System monitoring
    btop
    procs
    ncdu
    nitch
    bandwhich
    inotify-tools

    # Debug & tracing
    strace
    ltrace
    gdb

    # Development efficiency
    watchexec
    hyperfine

    # Containers
    podman

    # Network & Archive tools
    curl
    openssl
    mtr
    iperf3
    nmap
    tcpdump
    wireshark-cli # tshark packet analyzer
    socat
    netcat-openbsd
    bind.dnsutils
    traceroute
    iputils
    iproute2
    nettools
    mosh
    whois
    xh # friendly HTTP client
    wget # classic downloader
    avahi # mDNS/DNS-SD CLI tools
    speedtest-cli # network speed test
    cloudflared # Cloudflare tunnel/client CLI
    rsync
    zip
    unzip
    gnutar

    # Security & encryption
    age

    # Data processing & query
    jq
    yq-go
    sd
    jless
    moreutils
    nushell
    postgresql

    # Multimedia
    ffmpeg
    imagemagick
    inkscape

    # Terminal
    kitty.terminfo

    # Terminal multiplexers
    zellij
    tmux

    # Editors
    helix

    # Git & version control
    git
    gh
    ghq
    lazygit
    difftastic
    tokei # code statistics
    act
    wrkflw

    # Language servers & Formatter
    # OCaml
    ocamlPackages.ocaml-lsp
    ocamlformat
    # Crystal
    crystalline
    # C#
    csharp-ls
    omnisharp-roslyn
    csharpier
    # F#
    fsautocomplete
    fantomas
    # Go
    gopls
    # Shell
    bash-language-server
    fish-lsp
    # Rust
    rust-analyzer
    # Python
    pyright
    # YAML / TOML
    yaml-language-server
    taplo
    # Docker
    dockerfile-language-server
    # Lua
    lua-language-server
    # Web (JS/TS/HTML/CSS/JSON)
    typescript-language-server
    javascript-typescript-langserver
    biome
    prettier
    vscode-langservers-extracted
    astro-language-server
    emmet-ls
    superhtml
    svelte-language-server
    tailwindcss-language-server
    # Markdown
    markdown-oxide
    # Nix
    nil
    nixd
    alejandra
    # Typst
    typstyle
    # Elixir
    elixir
    # Swift
    nix-repository.swift-toolchain-bin
    # SQL
    postgres-language-server

    # Nix CLI
    nh
    nix-prefetch-scripts
    nix-search-cli

    # Development environments
    devenv
    devbox

    # AI assistants
    claude-code
    codex
    lsp-ai
    llm-ls

    # MCP servers
    nix-repository.mcp-language-server
    nix-repository.chrome-devtools-mcp
    nix-repository.context7-mcp
    nix-repository.climcp
    nix-repository.kiri
    nix-repository.osgrep

    # Repository management
    nix-repository.gwq
    nix-repository.zz

    # MCP NixOS
    mcp-nixos
  ];
}
