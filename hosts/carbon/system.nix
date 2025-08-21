{...}: {
  # Enable systemd for service management
  systemd.enableEmergencyMode = false;

  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable sudo for wheel group
  security.sudo.enable = true;

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
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Enable Wayland
  services.xserver.displayManager.gdm.wayland = true;
  
  # NetworkManager for GNOME
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
