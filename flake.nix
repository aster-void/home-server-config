{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mc-astronaut-server.url = "github:aster-void/mc-astronaut-server";
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    sshAuthorizedKeys = builtins.fromJSON (builtins.readFile ./config/ssh-authorized-keys.json);

    mkSystem = {
      system,
      hostname,
      modules,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = {
          inherit inputs;
          meta = {
            inherit hostname sshAuthorizedKeys;
          };
        };
      };
  in {
    nixosConfigurations."carbon" = mkSystem {
      system = "x86_64-linux";
      hostname = "carbon";
      modules = [
        ./hosts/carbon/configuration.nix
      ];
    };
  };
}
