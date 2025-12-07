{flake, ...}: {
  imports = [
    flake.nixosModules.common
    flake.nixosModules.desktop
    ./hardware-configuration.nix
    ./system/power.nix
    ./system/wifi-ap.nix
    ./services
  ];
}
