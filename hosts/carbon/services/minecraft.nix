{
  pkgs,
  inputs,
  lib,
  ...
}: {
  systemd.services.minecraft-astronaut = {
    description = "Minecraft Astronaut Server";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      Type = "simple";
      User = "minecraft";
      Group = "minecraft";
      WorkingDirectory = "/srv/minecraft";
      Restart = "on-failure";
      RestartSec = "2s";

      # Run the server using flake package
      ExecStart = lib.getExe inputs.mc-astronaut-server.packages.${pkgs.system}.default;

      # Security settings
      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
    };
  };
}
