{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
    ./services
    ./system
  ];

  home-manager.backupFileExtension = "backup";
}
