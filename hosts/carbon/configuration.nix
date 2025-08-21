{
  inputs,
  meta,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services
    ./users.nix
    ./system.nix

    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
  ];

  networking.hostName = meta.hostname;
}
