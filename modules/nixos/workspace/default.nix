{
  config,
  flake,
  ...
}: {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    enableTun = true;
    config = {
      _module.args = {
        sshAuthorizedKeys = config.meta.sshAuthorizedKeys;
        inputs = flake.inputs;
      };
      nixpkgs.overlays = [
        (_final: _prev: {
          inputs = flake.inputs;
        })
      ];
      imports = [
        flake.nixosModules.profile-dev
        ./container/default.nix
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    2222
    2223
  ];
}
