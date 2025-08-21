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
  ];

  networking.hostName = meta.hostname;
}
