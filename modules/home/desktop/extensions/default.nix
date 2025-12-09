{lib, ...}: {
  imports = [
    ./gaming.nix
  ];

  options.my.extensions = {
    gaming.enable = lib.mkEnableOption "gaming extension";
  };
}
