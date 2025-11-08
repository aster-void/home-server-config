{flake, ...}: {
  imports = [
    ./docker.nix
    ./dokploy.nix

    ./minecraft.nix
    ./syncthing.nix
    flake.nixosModules.workspace
  ];
}
