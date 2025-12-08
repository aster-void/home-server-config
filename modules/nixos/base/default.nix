{inputs, ...}: {
  imports = [
    inputs.comin.nixosModules.comin
    inputs.agenix.nixosModules.default
    ./system
  ];

  home-manager.backupFileExtension = "backup";
}
