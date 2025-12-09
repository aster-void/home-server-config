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

    ./options.nix
    ./packages.nix
    ./system
    ./hardware
    ./services
    ./extensions
  ];

  config = lib.mkIf cfg.enable {
    # Desktop-specific base config can go here
  };
}
