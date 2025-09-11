{pkgs, ...}: {
  # Development tools
  environment.systemPackages = with pkgs; [
    git
    helix
  ];

  # Common git configuration
  programs.git = {
    enable = true;
    config = {
      pull.rebase = true;
    };
  };

  # Enable comin for GitOps deployment
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