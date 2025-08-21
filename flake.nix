{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mc-astronaut-server.url = "github:aster-void/mc-astronaut-server";
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
  };

  outputs = {
    nixpkgs,
    agenix,
    ...
  } @ inputs: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

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

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = [
          agenix.outputs.packages.${system}.default
        ];
      };
    });
  };
}
