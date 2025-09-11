{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./features/base.nix
    ./features/ops.nix
    ./features/networking.nix
    ./features/users.nix
  ];
}