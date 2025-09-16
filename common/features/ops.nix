{
  meta,
  pkgs,
  ...
}: {
  # Operational tools required for GitOps management
  environment.systemPackages = with pkgs; [
    git # Required for GitOps operations
    helix # Required for system administration
  ];

  # Git configuration for operations
  programs.git = {
    enable = true;
    config = {
      pull.rebase = true;
      user.name = "aster@${meta.hostname}";
      user.email = "137767097+aster-void@users.noreply.github.com";
    };
  };

  # Comin GitOps deployment - required for all hosts
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
