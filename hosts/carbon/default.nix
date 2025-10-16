{
  imports = [
    ./features/networking.nix
    ./features/power.nix
    ./features/users.nix
    ../../common/features/desktop.nix
    ./services
  ];
}
