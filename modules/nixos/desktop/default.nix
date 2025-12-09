# Desktop environment module (Hyprland-based)
{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.lanzaboote.nixosModules.lanzaboote

    ./bootloader.nix
    ./fonts
    ./gui.nix
    ./packages.nix
    ./hardware
    ./services
    ./display-managers
    ./window-managers
    ./gaming
  ];

  options.my.profiles = {
    desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable desktop environment (Hyprland + SDDM)";
    };
    gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gaming profile (Steam, etc.)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Desktop-specific base config can go here
  };
}
