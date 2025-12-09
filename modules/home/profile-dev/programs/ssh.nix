{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks."*" = {
      controlMaster = "auto";
      controlPath = "~/.ssh/sockets/%r@%h-%p";
      controlPersist = "10m";
    };
  };
}
