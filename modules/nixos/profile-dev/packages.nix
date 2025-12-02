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
  fd
  eza
  bat
  fzf
  yazi

  # System monitoring
  btop
  procs
  ncdu
  bandwhich

  # Network & Archive tools
  curl
  openssl
  openssh
  mtr
  iperf3
  nmap
  tcpdump
  socat
  netcat-gnu
  bind.dnsutils
  traceroute
  iputils
  iproute2
  nettools
  mosh
  zip
  unzip
  gnutar

  # Data processing & query
  jq
  yq-go
  sd
  jless
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
  bash-language-server
  fish-lsp
  rust-analyzer
  pyright
  yaml-language-server
  dockerfile-language-server-nodejs
  lua-language-server
  taplo
  vscode-langservers-extracted
  nil
  nixd
  alejandra

  # Nix CLI
  nh
  nix-prefetch-scripts
  nix-search-cli

  # AI assistants
  claude-code
  codex

  # MCP servers
  pkgs.inputs.nix-repository.packages.${system}.mcp-language-server
  pkgs.inputs.nix-repository.packages.${system}.chrome-devtools-mcp
  pkgs.inputs.nix-repository.packages.${system}.kiri
  pkgs.inputs.nix-repository.packages.${system}.osgrep
]
