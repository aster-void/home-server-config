{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";

    # gaming
    nix-minecraft.url = "github:aster-void/nix-minecraft?ref=wip/minecraftctl";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    nix-mc.url = "github:aster-void/nix-mc";
    mc-astronaut-server = {
      url = "github:aster-void/mc-astronaut-server";
      flake = false;
    };
    mc-astronaut-mods = {
      url = "github:aster-void/mc-astronaut-mods/server";
      flake = false;
    };

    aster-void-dev = {
      url = "github:aster-void/aster-void.dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # with patch https://github.com/el-kurto/nix-dokploy/pull/4
    nix-dokploy.url = "github:songpola/nix-dokploy?ref=fix-sc2034";
  };

  outputs = {
    nixpkgs,
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
      modules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          modules
          ++ [
            ./common
            ./hosts/${hostname}
            ./hosts/${hostname}/hardware-configuration.nix
            agenix.nixosModules.default
            playit-nixos-module.nixosModules.default
          ];
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
    };

    formatter = forAllSystems (system: let pkgs = nixpkgs.legacyPackages.${system}; in pkgs.alejandra);
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
          inputs.nix-minecraft.outputs.packages.${system}.minecraftctl
        ];
      };
    });
  };
}
