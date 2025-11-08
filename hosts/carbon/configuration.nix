{flake, ...}: {
  imports = [
    flake.nixosModules.common
    flake.nixosModules.desktop
    ./hardware-configuration.nix
    ./system/networking.nix
    ./system/power.nix
    ./system/users.nix
    ./system/wifi-ap.nix
    ./services
  ];
}
