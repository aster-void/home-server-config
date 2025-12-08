{
  flake,
  pkgs,
  ...
}: {
  imports = [
    flake.homeModules.profile-dev
  ];

  # FHS environment
  home.packages = [
    flake.packages.${pkgs.stdenv.hostPlatform.system}.fhs
  ];
}
