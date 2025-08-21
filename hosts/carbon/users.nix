{
  meta,
  pkgs,
  ...
}: {
  # Create admin user with SSH keys
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

  users.users.minecraft = {
    isSystemUser = true;
    group = "minecraft";
    home = "/srv/minecraft";
    createHome = true;
  };
  users.groups.minecraft = {};
}
