{config, ...}: let
  dataDir = "/var/lib/syncthing";
  wallpaperDir = "${dataDir}/Pictures/Wallpapers";
  secretId = "syncthing-password";
  passwordFile = config.age.secrets.${secretId}.path;
in {
  age.secrets.${secretId}.file = ../../../secrets/syncthing-password.age;

  # Enable Syncthing service
  services.syncthing = {
    enable = true;
    user = "syncthing";
    group = "syncthing";

    configDir = "${dataDir}/.config/syncthing";
    dataDir = dataDir;
    guiPasswordFile = passwordFile;

    settings = {
      gui = {
        address = "127.0.0.1:8384";
      };

      folders = {
        "Wallpapers" = {
          path = wallpaperDir;
          type = "sendreceive";
          devices = ["server"];
        };
      };
      globalAnnounceEnabled = true;
      localAnnounceEnabled = true;

      devices = {
        "server" = {
          id = "default";
          name = "SoT Server (Carbon)";
          addresses = ["dynamic"];
          introducer = true;
        };
      };
    };

    overrideDevices = true;
    overrideFolders = true;
  };

  systemd.tmpfiles.rules = [
    "d ${dataDir} 770 syncthing syncthing - -"
  ];

  users.users.syncthing = {
    isSystemUser = true;
    group = "syncthing";
    home = "/var/lib/syncthing";
    createHome = true;
  };

  users.groups.syncthing = {};
}
