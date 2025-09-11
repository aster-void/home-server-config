{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./boot.nix
    ./gui.nix
    ./users.nix
    ./networking.nix
    ./locale.nix
    ./power.nix
  ];

  # Host-specific git configuration
  programs.git.config = {
    user.name = "aster@carbon";
    user.email = "137767097+aster-void@users.noreply.github.com";
  };

  # Enable comin for GitOps deployment (host-specific)
  services.comin = {
    enable = true;
    remotes = [
      {
        name = "origin";
        url = "https://github.com/aster-void/home-server-config.git";
        branches.main.name = "main";
        poller.period = 5;
      }
    ];
  };
}
