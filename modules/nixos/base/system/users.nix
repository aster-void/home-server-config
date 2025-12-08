{
  config,
  pkgs,
  ...
}: {
  # Root user with SSH keys
  users.users.root = {
    openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
    shell = pkgs.fish;
  };
}
