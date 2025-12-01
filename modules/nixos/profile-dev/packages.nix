pkgs:
with pkgs; [
  # Core utilities
  coreutils
  bash
  gnused
  gnumake
  tree
  lsof

  # File search & navigation
  ripgrep
  fzf
  yazi

  # System monitoring
  btop

  # Network & Archive tools
  curl
  openssl
  openssh
  zip
  unzip
  gnutar

  # Data processing & query
  jq
  yq-go
  nushell

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

  # Language servers & Formatter
  gopls
  typescript-language-server
  nil
  nixd
  alejandra

  # Nix CLI
  nh
  nix-prefetch-scripts

  # AI assistants
  claude-code
  codex

  # MCP servers
  pkgs.inputs.nix-repository.packages.${system}.mcp-language-server
  pkgs.inputs.nix-repository.packages.${system}.kiri
]
