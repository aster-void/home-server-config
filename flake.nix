{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-mc.url = "github:aster-void/nix-mc";
    mc-astronaut-server = {
      url = "github:aster-void/mc-astronaut-server";
      flake = false;
    };
    mc-astronaut-mods = {
      url = "github:aster-void/mc-astronaut-mods/server";
      flake = false;
    };
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";
  };

  outputs = {
    nixpkgs,
    nix-mc,
    agenix,
    playit-nixos-module,
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
        nix-mc.nixosModules.nix-mc
        agenix.nixosModules.default
        playit-nixos-module.nixosModules.default
      ];
    };

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        env = {
          RULES = "./secrets/secrets.nix";
        };
        packages = [
          agenix.outputs.packages.${system}.default
          playit-nixos-module.outputs.packages.${system}.playit-cli
        ];
      };
    });
  };
}
