{
  imports = [
    ./features/networking.nix
    ./features/power.nix
    ./features/users.nix
    ./features/wifi-ap.nix
    ../../common/features/desktop.nix
    ./services
  ];
}
