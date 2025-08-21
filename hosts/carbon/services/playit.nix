{config, ...}: {
  # System user for playit service
  users.groups.playit = {};
  users.users.playit = {
    isSystemUser = true;
    group = "playit";
  };

  # Age secret for playit configuration
  age.secrets.playit-secret.file = ../../../secrets/playit.toml.age;

  # playit.gg service configuration
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = config.age.secrets.playit-secret.path;
  };
}
