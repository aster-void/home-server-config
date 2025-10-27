{config, ...}: let
  dataDir = "/var/lib/syncthing";
  wallpaperDir = "${dataDir}/Pictures/Wallpapers";
  schoolDocsDir = "${dataDir}/Documents/School";
  secretId = "syncthing-password";
  passwordFile = config.age.secrets.${secretId}.path;
in {
  age.secrets.${secretId} = {
    file = ../../../secrets/syncthing-password.age;
    owner = "syncthing";
    group = "syncthing";
    mode = "400";
  };

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
        user = "aster";
      };

      folders = {
        "Wallpapers" = {
          path = wallpaperDir;
          type = "sendreceive";
          devices = ["amberwood" "server" "dusk"];
        };
        "School" = {
          path = schoolDocsDir;
          type = "sendreceive";
          devices = ["amberwood" "server" "dusk"];
        };
      };
      globalAnnounceEnabled = true;
      localAnnounceEnabled = true;

      devices = {
        "server" = {
          id = "FB3QSEV-JPUF3O2-GCJ4X67-NRT6BXY-KDZPDFF-GDV5ZKT-V2ZN5FF-PP532A7";
          name = "SoT Server (Carbon)";
          addresses = ["dynamic"];
          introducer = true;
        };
        "dusk" = {
          id = "LVI5EMJ-JQGPXLL-MDYFRKK-YCFRKQL-BJNPQSD-HJGNRZ6-HVREWL2-UCLGRQV";
          name = "dusk";
        };
      };
    };

    overrideDevices = true;
    overrideFolders = true;
  };

  systemd.tmpfiles.rules = [
    "d ${dataDir} 770 syncthing syncthing - -"
    "d ${wallpaperDir} 755 syncthing syncthing - -"
  ];

  users.users.syncthing = {
    isSystemUser = true;
    group = "syncthing";
    home = "/var/lib/syncthing";
    createHome = true;
  };

  users.groups.syncthing = {};
}
