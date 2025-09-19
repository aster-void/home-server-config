{
  meta,
  pkgs,
  ...
}: {
  # Common admin user with SSH keys
  users.users.aster = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = meta.sshAuthorizedKeys;
  };

  users.users.root = {
    openssh.authorizedKeys.keys = meta.sshAuthorizedKeys;
    shell = pkgs.fish;
  };
}
