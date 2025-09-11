{
  pkgs,
  inputs,
  ...
}: {
  # Common system packages for all hosts
  environment.systemPackages = with pkgs; [
    # core utils
    coreutils-full
    bash
    fish
    curl
    ripgrep
    zellij

    # monitor & analyze
    btop
    ncdu
    macchina
    nushell
    inputs.nix-mc.packages.${pkgs.system}.nix-mc-cli

    # devel
    git
    helix
    
    # terminal compatibility
    kitty.terminfo
  ];

  # Enable comprehensive terminal support
  environment.enableAllTerminfo = true;

  # Enable systemd for service management
  systemd.enableEmergencyMode = false;

  # Enable sudo for wheel group
  security.sudo.enable = true;

  # Enable fish shell
  programs.fish.enable = true;

  # Nix configuration
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Common git configuration
  programs.git = {
    enable = true;
    config = {
      pull.rebase = true;
    };
  };

  # Common keyboard configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "workman";
    options = "caps:escape";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}