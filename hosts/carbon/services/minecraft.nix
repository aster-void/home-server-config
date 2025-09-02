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
    servers =
      {
        my-fabric = {
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
      }
      # === debugging ===
      // (let
        whitelist = {
          Frgd = "1cb95bd4-beeb-4940-a3b2-ab5dac408d71";
        };
        mkServerProperties = port: {
          whitelist = true;
          server-port = port;
          gamemode = 1;
          difficulty = 0;
        };
      in {
        # from nixpkgs
        dbg-nixpkgs-minecraft = {
          enable = true;
          package = pkgs.minecraft-server;
          inherit whitelist;
          serverProperties = mkServerProperties 25568;
        };
        dbg-nixpkgs-paper = {
          enable = true;
          package = pkgs.papermc;
          inherit whitelist;
          serverProperties = mkServerProperties 25567;
        };
        dbg-nixpkgs-purpur = {
          enable = true;
          package = pkgs.purpur;
          inherit whitelist;
          serverProperties = mkServerProperties 25569;
        };
        dbg-nixpkgs-mchprs = {
          enable = true;
          package = pkgs.mchprs;
          inherit whitelist;
          serverProperties = mkServerProperties 25570;
        };
        dbg-nixpkgs-velocity = {
          enable = true;
          package = pkgs.velocity;
          inherit whitelist;
          serverProperties = mkServerProperties 25571;
        };
        # from nix-minecraft
        dbg-vanilla = {
          enable = true;
          package = pkgs.vanillaServers.vanilla;
          inherit whitelist;
          serverProperties = mkServerProperties 25573;
        };
        dbg-quilt = {
          enable = true;
          package = pkgs.quiltServers.quilt;
          inherit whitelist;
          serverProperties = mkServerProperties 25572;
        };
        dbg-legacy-fabric = {
          enable = true;
          package = pkgs.legacyFabricServers.legacy-fabric-1_13_2;
          inherit whitelist;
          serverProperties = mkServerProperties 25572;
        };
        dbg-paper = {
          enable = true;
          package = pkgs.paperServers.paper;
          inherit whitelist;
          serverProperties = mkServerProperties 25572;
        };
        dbg-velocity = {
          enable = true;
          package = pkgs.paperServers.paper;
          inherit whitelist;
          serverProperties = mkServerProperties 25572;
        };
      });
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
