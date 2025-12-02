{
  inputs,
  flake,
  ...
}: {config, ...}: {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    enableTun = true;
    specialArgs = {
      inherit flake inputs;
      sshAuthorizedKeys = config.meta.sshAuthorizedKeys;
    };
    config = {
      imports = [
        ./container
      ];
      nixpkgs.overlays = [
        (_final: _prev: {
          inputs = flake.inputs;
        })
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    2222
    2223
  ];
}
