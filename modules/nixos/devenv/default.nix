{pkgs, ...}: {
  imports = [
    ./programs
  ];

  environment.systemPackages = import ./packages.nix pkgs;
}
