{lib, ...}: {
  imports = [
    ./packages.nix
    ./programs
  ];

  home = {
    stateVersion = lib.mkDefault "26.05";
    sessionVariables.EDITOR = "hx";
  };
}
