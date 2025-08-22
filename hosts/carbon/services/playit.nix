{config, ...}: {
  # System user for playit service
  users.groups.playit = {};
  users.users.playit = {
    isSystemUser = true;
    group = "playit";
  };

  # Age identity paths for decryption
  age.identityPaths = [
    "/root/.ssh/id_ed25519"
    "/home/aster/.ssh/id_ed25519"
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  # Age secret for playit configuration
  age.secrets.playit-secret = {
    file = ../../../secrets/playit.toml.age;
    owner = "playit";
    group = "playit";
    mode = "0400";
  };

  # playit.gg service configuration
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = config.age.secrets.playit-secret.path;
  };
}
