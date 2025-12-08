{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./users.nix
    ./context7.nix
  ];

  # Enable nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;
}
