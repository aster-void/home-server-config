{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  # Use bibata-cursors-translucent from nix-repository
  cursor = {
    name = "Bibata_Spirit";
    package = inputs.nix-repository.packages.${system}.bibata-cursors-translucent;
  };
in {
  home.pointerCursor =
    cursor
    // {
      x11.enable = true;
      gtk.enable = true;
      hyprcursor.enable = true;
      hyprcursor.size = 48;
    };
}
