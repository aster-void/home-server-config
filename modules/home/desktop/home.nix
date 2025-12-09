{...}: {
  # nixpkgs.config is set at NixOS level (modules/nixos/base/system/base.nix)
  # to avoid conflict with home-manager.useGlobalPkgs

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";
}
