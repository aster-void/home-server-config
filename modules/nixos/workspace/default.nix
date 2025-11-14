{
  config,
  flake,
  ...
}: {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    config = {
      _module.args = {
        sshAuthorizedKeys = config.meta.sshAuthorizedKeys;
        inputs = flake.inputs;
      };
      imports = [
        flake.nixosModules.devenv
        ./container/default.nix
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    2222
    2223
  ];
}
