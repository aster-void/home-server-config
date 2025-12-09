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

    home-manager = {
      url = "github:nix-community/home-manager";
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

    nix-repository.url = "github:aster-void/nix-repository";
    nix-repository.inputs = {
      nixpkgs.follows = "nixpkgs";
      blueprint.follows = "blueprint";
      treefmt-nix.follows = "treefmt-nix";
    };

    # Desktop inputs (from dotfiles)
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.inputs.rust-overlay.follows = "rust-overlay";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";

    caelestia-cli.url = "github:caelestia-dots/cli";
    caelestia-cli.inputs.nixpkgs.follows = "nixpkgs";

    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    mcp-servers-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-hazkey.url = "github:aster-void/nix-hazkey";
    nix-hazkey.inputs.nixpkgs.follows = "nixpkgs";
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
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [
        (_final: _prev: {
          inherit inputs;
        })
        # hyprshot fix overlay
        (final: prev: {
          hyprshot = prev.callPackage ./overlays/hyprshot-fix/package.nix {};
        })
      ];
    };

  nixConfig = {
    extra-substituters = [
      "https://playit-nixos-module.cachix.org"
      "https://nix-repository--aster-void.cachix.org"
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "playit-nixos-module.cachix.org-1:22hBXWXBbd/7o1cOnh+p0hpFUVk9lPdRLX3p5YSfRz4="
      "nix-repository--aster-void.cachix.org-1:A+IaiSvtaGcenevi21IvvODJoO61MtVbLFApMDXQ1Zs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };
}
