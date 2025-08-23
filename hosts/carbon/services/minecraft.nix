{inputs, ...}: {
  services.minecraft = {
    enable = true;
    openFirewall = true;

    servers.astronaut = {
      type = "forge";
      dataDir = "/var/lib/minecraft/astronaut";
      symlinks = {
        mods = "${inputs.mc-astronaut-mods}";
        libraries = "${inputs.mc-astronaut-server}/libraries";
        "eula.txt" = "${inputs.mc-astronaut-server}/eula.txt"; # TODO: remove
        "run.sh" = "${inputs.mc-astronaut-server}/run.sh";
        "user_jvm_args.txt" = "${inputs.mc-astronaut-server.files.default}/user_jvm_args.txt";
      };
      ExecStart = "/var/lib/minecraft/astronaut/run.sh";
      serverProperties = {
        "server-port" = 25565;
        difficulty = "normal";
        "max-players" = 20;
        motd = "Astronaut Server - Powered by NixOS";
      };
    };
  };
}
