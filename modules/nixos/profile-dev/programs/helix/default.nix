{pkgs, ...}: {
  # System-wide Helix configuration under /etc/xdg/helix
  environment.etc."xdg/helix/config.toml".text = ''
    theme = "dark+"

    [editor]
    auto-format = true
    line-number = "relative"
    mouse = true
    true-color = true
    rulers = [80, 100]
  '';

  environment.etc."xdg/helix/languages.toml".text = import ./languages.nix {inherit pkgs;};
}
