{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-mc.nixosModules.nix-mc
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];
  nixpkgs.overlays = [
    inputs.nix-minecraft.overlay
  ];

  environment.systemPackages = with pkgs; [
    minecraftctl
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    servers.my-fabric = {
      enable = true;
      package = pkgs.fabricServers.fabric;
      serverProperties = {
        server-port = 25566;
        gamemode = 0;
        difficulty = 3;
        hardcore = true;

        whitelist = true;
      };
      whitelist = {
        Frgd = "1cb95bd4-beeb-4940-a3b2-ab5dac408d71";
      };
      enableReload = true;
      extraReload = ''
      '';
    };
  };

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
      startScript = "/var/lib/minecraft/astronaut/run.sh";
      serverProperties = {
        "server-port" = 25565;
        difficulty = "normal";
        "max-players" = 20;
        motd = "Astronaut Server - Powered by NixOS";
      };
    };
  };
}
