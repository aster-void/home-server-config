{pkgs, ...}: {
  home.file.".ssh/sockets/.keep".text = "";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*.aster-void.dev" = {
      proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
    };
    matchBlocks."*" = {
      # Multiplexing
      controlMaster = "auto";
      controlPath = "~/.ssh/sockets/%r@%h-%p";
      controlPersist = "10m";
      # Defaults (from home-manager)
      forwardAgent = false;
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };
}
