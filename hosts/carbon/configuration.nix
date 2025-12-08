{flake, ...}: {
  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    ./hardware-configuration.nix
    ./system/power.nix
    ./system/wifi-ap.nix
    ./services
  ];
}
