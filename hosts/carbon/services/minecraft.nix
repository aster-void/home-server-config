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
    openFirewall = true;

    servers =
      {
        hardcore = {
          enable = true;
          package = pkgs.paperServers.paper;
          serverProperties = {
            server-port = 25566;
            gamemode = 0;
            hardcore = true;
          };
          enableReload = true;
          extraReload = ''
            minecraftctl send hardcore reload
            minecraftctl send hardcore whitelist reload
          '';
        };
      }
      // (
        let
          mkServer = package: port: manager: {
            enable = true;
            inherit package;
            serverProperties = {
              server-port = port;
              gamemode = 1;
              difficulty = 0;
            };
            managementSystem.tmux.enable = manager == "tmux";
            managementSystem.systemd-socket.enable = manager == "systemd-socket";
          };
        in {
          van = mkServer pkgs.vanillaServers.vanilla 25567 "tmux";
          fab = mkServer pkgs.fabricServers.fabric 25568 "systemd-socket";
          qui = mkServer pkgs.quiltServers.quilt 25569 "tmux";
          vel = mkServer pkgs.velocityServers.velocity 25570 "systemd-socket";
        }
      );
  };

  services.minecraft = {
    enable = false;
    openFirewall = true;

    servers.astronaut = {
      type = "forge";
      dataDir = "/var/lib/minecraft/astronaut";
      symlinks = {
        mods = "${inputs.mc-astronaut-mods}";
        libraries = "${inputs.mc-astronaut-server}/libraries";
        "eula.txt" = "${inputs.mc-astronaut-server}/eula.txt"; # TODO: remove
        "run.sh" = "${inputs.mc-astronaut-server}/run.sh";
        "user_jvm_args.txt" = "${inputs.mc-astronaut-server}/user_jvm_args.txt";
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
