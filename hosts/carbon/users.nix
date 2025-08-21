{meta, pkgs, ...}: {
  # Create admin user with SSH keys
  users.users.aster = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = meta.sshAuthorizedKeys;
  };

  # Create minecraft user
  users.users.minecraft = {
    isSystemUser = true;
    group = "minecraft";
    home = "/srv/minecraft";
    createHome = true;
  };

  users.groups.minecraft = {};

  # Set default shell for root user
  users.users.root.shell = pkgs.fish;
}
