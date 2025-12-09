{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.my.profiles.desktop;
  myPkgs = inputs.nix-repository.packages.${system};
in {
  services = lib.mkIf cfg.enable {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtdeclarative
        kdePackages.qtvirtualkeyboard
      ];
    };
  };

  environment.systemPackages = lib.mkIf cfg.enable [myPkgs.sddm-astronaut-theme];
}
