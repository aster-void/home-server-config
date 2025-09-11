{
  inputs,
  meta,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./default.nix

    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = meta.hostname;
}
