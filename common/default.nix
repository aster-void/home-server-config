{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default

    ./features/base.nix
    ./features/ops.nix
    ./features/networking.nix
    ./features/users.nix
  ];
}
