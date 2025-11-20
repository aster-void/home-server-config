{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./programs
  ];

  environment.systemPackages =
    (import ./packages.nix pkgs)
    ++ [
      inputs.mcp-nixos.packages.${pkgs.system}.default
    ];

  environment.variables.EDITOR = "hx";
}
