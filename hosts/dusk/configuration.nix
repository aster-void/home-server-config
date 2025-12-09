{flake, ...}: {
  imports = [
    flake.nixosModules.base
    flake.nixosModules.profile-dev
    flake.nixosModules.desktop
    ./hardware-configuration.nix
  ];

  my.profiles.desktop.enable = true;
  my.profiles.gaming.enable = true;
  my.boot.enableLanzaboote = true;
}
