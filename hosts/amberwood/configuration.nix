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

  # Intel HDA audio codec doesn't respond, causing 4 second boot delay
  # USB/HDMI/DisplayPort audio still works
  boot.blacklistedKernelModules = ["snd_hda_intel"];
}
