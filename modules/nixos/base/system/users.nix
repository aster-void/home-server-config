{
  config,
  pkgs,
  ...
}: {
  # Common admin user with SSH keys
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

  users.users.root = {
    openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
    shell = pkgs.fish;
  };
}
