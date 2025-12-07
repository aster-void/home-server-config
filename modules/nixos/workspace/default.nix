{
  inputs,
  flake,
  ...
}: {config, ...}: {
  age.secrets.nix-conf = {
    file = ../../../secrets/nix.conf.age;
    owner = "root";
    group = "root";
    mode = "0644";
  };

  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    enableTun = true;
    bindMounts."/etc/nix/nix.conf.d/github-token.conf" = {
      hostPath = config.age.secrets.nix-conf.path;
      isReadOnly = true;
    };
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
