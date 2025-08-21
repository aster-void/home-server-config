{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations."carbon" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/carbon/configuration.nix
      ];
      specialArgs = {
        inherit inputs;
        meta = {
          hostname = "carbon";
        };
      };
    };
  };
}
