{
  config,
  flake,
  ...
}: let
  hmModule = flake.inputs.home-manager.nixosModules.home-manager;
  profileDevHome = flake.homeModules.profile-dev;
in {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    enableTun = true;
    config = {
      networking.firewall.enable = false;
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
        hmModule
        ./container/default.nix
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inputs = flake.inputs;
        };
        users.aster = {
          imports = [
            profileDevHome
          ];
        };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    2222
    2223
  ];
}
