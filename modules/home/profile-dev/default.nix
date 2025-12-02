{
  pkgs,
  inputs,
  lib ? pkgs.lib,
  ...
}: let
  packages =
    (import ./packages.nix {inherit pkgs inputs;})
    ++ [
      inputs.mcp-nixos.packages.${pkgs.system}.default
    ];
in {
  _class = "homeManager";

  imports = [
    ./programs
  ];

  home = {
    stateVersion = lib.mkDefault "26.05";
    packages = packages;
    sessionVariables.EDITOR = "hx";
  };
}
