{
  config,
  pkgs,
  ...
}: {
  # Common admin user with SSH keys
  users.users.aster = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
  };

  users.users.root = {
    openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
    shell = pkgs.fish;
  };
}
