{
  imports = [
    ./features/gaming.nix
    ./features/tunneling.nix
    ./features/power.nix
    ../../common/features/desktop.nix
  ];

  # Host-specific git configuration
  programs.git.config = {
    user.name = "aster@carbon";
    user.email = "137767097+aster-void@users.noreply.github.com";
  };
}
