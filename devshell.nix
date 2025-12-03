{
  pkgs,
  inputs,
  system,
  ...
}:
pkgs.mkShell {
  env.RULES = "./secrets/secrets.nix";
  packages = [
    inputs.agenix.outputs.packages.${system}.default
    inputs.playit-nixos-module.outputs.packages.${system}.playit-cli
    inputs.nix-minecraft.outputs.packages.${system}.minecraftctl
    pkgs.lefthook
    pkgs.alejandra
    pkgs.bun
  ];
  shellHook = ''
    lefthook install
  '';
}
