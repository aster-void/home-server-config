{...}: {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/sockets/%r@%h-%p";
    controlPersist = "10m";
  };
}
