{inputs, ...}: {
  imports = [
    inputs.nix-dokploy.nixosModules.default
  ];

  services.dokploy = {
    enable = true;

    # Use private IP (default - recommended for security)
    swarm.advertiseAddress = "private";
    swarm.autoRecreate = true;
  };
}
