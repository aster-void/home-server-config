{
  inputs,
  flake,
  ...
}:
{
  config,
  ...
}:
{
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    enableTun = true;
    config = {
      imports = [
        ./container
      ];
      _module.args = {
        inherit flake inputs;
        sshAuthorizedKeys = config.meta.sshAuthorizedKeys;
      };
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
