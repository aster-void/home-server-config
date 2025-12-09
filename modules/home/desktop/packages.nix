{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  myPkgs = inputs.nix-repository.packages.${system};
in {
  home.packages = with pkgs;
    [
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

      # Dev Tools
      devenv
      devbox
      claude-code
      crush
      codex
      postgresql
      litecli
      tokei
      act
      ## dep graph
      cargo-depgraph
      graphviz

      # editors
      code-cursor
      cursor-cli

      # LSPs
      ## Rust
      rustfmt
      rust-analyzer
      clippy

      ## C / C++
      llvmPackages.clang-tools

      ## Go
      gopls
      golangci-lint
      golangci-lint-langserver

      ## TS/JS/CSS/HTML/ESLint/Svelte
      biome
      typescript-language-server
      emmet-ls
      tailwindcss-language-server
      svelte-language-server
      vscode-langservers-extracted # HTML/CSS/JSON/ESLint all in one
      astro-language-server

      ## F#
      fsautocomplete

      ## Nix
      alejandra
      nixfmt-rfc-style # some repos require this as the formatter
      nil
      nixd
      statix
      nix-search
      diffoscope # useful for determining non-reproducibility

      ## Scala
      metals

      ## Bash
      bash-language-server

      ## GLSL
      glsl_analyzer

      # Markup
      ## Markdown
      marksman
      markdown-oxide

      ## TOML
      taplo

      ## Dockerfile, docker compose
      dockerfile-language-server
      docker-compose-language-service

      ## YAML
      yaml-language-server

      ## Hyprlang
      hyprls

      ## Typst
      tinymist
      typstyle

      ## JSON
      fixjson

      # General LSPs
      lsp-ai
      llm-ls
      helix-gpt

      # mcp servers
      mcp-nixos
    ]
    ++ [
      myPkgs.ccusage
      myPkgs.ccusage-codex
      myPkgs.ccusage-mcp
      myPkgs.chrome-devtools-mcp
      myPkgs.kiri
    ]
    ++ (with inputs.mcp-servers-nix.packages.${system}; [
      mcp-server-filesystem
      serena
      context7-mcp
    ]);
}
