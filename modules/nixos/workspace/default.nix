{config, ...}: {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    config = {
      _module.args = {
        sshAuthorizedKeys = config.meta.sshAuthorizedKeys;
      };
      imports = [
        ./container/default.nix
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    2222
    2223
  ];
}
