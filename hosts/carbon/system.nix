{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    coreutils-full
    bash
    fish
    nushell
    curl
    btop
    ncdu
    git
  ];

  # Enable systemd for service management
  systemd.enableEmergencyMode = false;

  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable sudo for wheel group
  security.sudo.enable = true;

  # Enable fish shell
  programs.fish.enable = true;

  # Nix configuration
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
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

  # Enable Wayland
  services.displayManager.gdm.wayland = true;

  # NetworkManager for GNOME
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
