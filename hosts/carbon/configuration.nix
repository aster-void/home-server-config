{flake, ...}: {
  imports = [
    flake.nixosModules.base
    flake.nixosModules.desktop
    ./hardware-configuration.nix
    ./system/power.nix
    ./system/wifi-ap.nix
    ./services
  ];
}
