{ config, pkgs, inputs, meta, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./services
  ];

  system.stateVersion = "24.05";
  
  networking.hostName = meta.hostname;
  
  # Enable systemd for service management
  systemd.enableEmergencyMode = false;
  
  # Basic system configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Enable SSH for remote management
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  
  # Network configuration
  networking.firewall.allowedTCPPorts = [ 22 25565 ]; # SSH + Minecraft
}
