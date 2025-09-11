{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./features/base.nix
    ./features/development.nix
    ./features/networking.nix
    ./features/users.nix
  ];
}