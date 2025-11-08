{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
    inputs.playit-nixos-module.nixosModules.default

    ./system/meta.nix
    ./system/secrets.nix
    ./system/base.nix
    ./system/ops.nix
    ./system/networking.nix
    ./system/users.nix
  ];
}
