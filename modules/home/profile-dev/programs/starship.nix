{...}: {
  programs.starship = {
    enable = true;
    settings = import ../../starship-settings.nix;
  };
}
