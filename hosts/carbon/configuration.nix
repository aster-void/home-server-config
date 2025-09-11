{
  inputs,
  meta,
  ...
}: {
  imports = [
    ../../common
    ./hardware-configuration.nix
    ./services
    ./system

    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = meta.hostname;
}
