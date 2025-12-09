{...}: {
  imports = [
    ./users.nix
    ./env.nix
  ];

  # Enable nix-ld for running unpatched binaries
  programs.nix-ld.enable = true;
}
