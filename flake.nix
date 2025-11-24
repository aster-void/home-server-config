{
  description = "Home server infrastructure managed with Blueprint";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    comin.url = "github:nlewo/comin";
    comin.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nix-dokploy.url = "github:el-kurto/nix-dokploy";
    mcp-nixos.url = "github:utensils/mcp-nixos";

    nix-repository.url = "github:aster-void/nix-repository";
    nix-repository.inputs = {
      nixpkgs.follows = "nixpkgs";
      blueprint.follows = "blueprint";
      treefmt-nix.follows = "treefmt-nix";
    };
  };

  outputs = inputs:
    inputs.blueprint {
      inherit inputs;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      nixpkgs.overlays = [
        (_final: _prev: {
          inherit inputs;
        })
      ];
    };

  nixConfig = {
    extra-substituters = ["https://playit-nixos-module.cachix.org"];
    extra-trusted-public-keys = ["playit-nixos-module.cachix.org-1:22hBXWXBbd/7o1cOnh+p0hpFUVk9lPdRLX3p5YSfRz4="];
  };
}
