{...}: {
  # nixpkgs.config is set at NixOS level (modules/nixos/base/system/base.nix)
  # to avoid conflict with home-manager.useGlobalPkgs

  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "zen-beta";
    TERMINAL = "alacritty";
    NIXOS_OZONE_WL = 1;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  news.display = "silent";
}
