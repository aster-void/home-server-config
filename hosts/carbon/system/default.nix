{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./boot.nix
    ./gui.nix
    ./users.nix
    ./networking.nix
  ];
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
  ];

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

  programs.git = {
    enable = true;
    config = {
      user.name = "aster@carbon";
      user.email = "137767097+aster-void@users.noreply.github.com";
      pull.rebase = true;
    };
  };
  # Enable comin for GitOps deployment
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/aster-void/home-server-config.git";
        branches.main.name = "main";
      }
    ];
  };

  # Keyboard configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "workman";
    options = "caps:escape";
  };

  system.stateVersion = "25.05";
}
