{ config, pkgs, ... }:

{
  systemd.services.minecraft-astronaut = {
    description = "Minecraft Astronaut Server";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    
    serviceConfig = {
      Type = "simple";
      User = "minecraft";
      Group = "minecraft";
      WorkingDirectory = "/var/lib/minecraft";
      Restart = "always";
      RestartSec = "10s";
      
      # Git clone and update the server
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p /var/lib/minecraft"
        "${pkgs.bash}/bin/bash -c 'cd /var/lib/minecraft && if [ ! -d mc-astronaut-server ]; then ${pkgs.git}/bin/git clone https://github.com/aster-void/mc-astronaut-server.git; else cd mc-astronaut-server && ${pkgs.git}/bin/git pull; fi'"
      ];
      
      # Start the server
      ExecStart = "${pkgs.bash}/bin/bash -c 'cd /var/lib/minecraft/mc-astronaut-server && ${pkgs.openjdk17}/bin/java -Xmx2G -Xms1G -jar server.jar nogui'";
      
      # Security settings
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = [ "/var/lib/minecraft" ];
    };
  };
  
  # Create minecraft user
  users.users.minecraft = {
    isSystemUser = true;
    group = "minecraft";
    home = "/var/lib/minecraft";
    createHome = true;
  };
  
  users.groups.minecraft = {};
  
  # Ensure git and java are available
  environment.systemPackages = with pkgs; [
    git
    openjdk17
  ];
}