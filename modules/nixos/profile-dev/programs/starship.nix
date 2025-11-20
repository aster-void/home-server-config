{...}: {
  programs.starship = {
    enable = true;
    settings = import ./starship-config.nix;
  };
}
