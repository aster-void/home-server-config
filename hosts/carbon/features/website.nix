{inputs, ...}: {
  imports = [inputs.aster-void-dev.nixosModules.default];

  services."aster-void.dev" = {
    enable = true;
    port = 4001;
  };
}
