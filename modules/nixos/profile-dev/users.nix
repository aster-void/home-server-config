{
  config,
  pkgs,
  ...
}: {
  # Development user with SSH keys
  users.users.aster = {
    isNormalUser = true;
    home = "/home/aster";
    createHome = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "users"
      "syncthing"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
  };
}
