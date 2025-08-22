{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # core utils
    coreutils-full
    bash
    fish
    curl
    ripgrep

    # monitor & analyze
    btop
    ncdu
    nushell
  ];

  # Enable systemd for service management
  systemd.enableEmergencyMode = false;

  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

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

  # Network configuration
  networking.firewall.allowedTCPPorts = [22 25565]; # SSH + Minecraft

  # Desktop environment configuration
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # don't sleep on display close
  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchDocked=ignore
  '';

  # Keyboard configuration
  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  # Enable Wayland
  services.displayManager.gdm.wayland = true;

  # NetworkManager for GNOME
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
