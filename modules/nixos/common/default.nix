{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
    inputs.playit-nixos-module.nixosModules.default
    ./system
  ];
}
