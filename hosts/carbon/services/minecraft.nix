{
  inputs,
  pkgs,
  config,
  ...
}: {
  # Minecraft server user and group
  users.users.minecraft = {
    isSystemUser = true;
    group = "minecraft";
    home = "/srv/minecraft";
    createHome = true;
  };
  users.groups.minecraft = {};

  # System user for playit service
  users.groups.playit = {};
  users.users.playit = {
    isSystemUser = true;
    group = "playit";
  };

  # Minecraft server ports
  networking.firewall.allowedTCPPorts = [
    25565
    25566
    25567
    25568
    25569
    25570
  ];

  # Minecraft server configuration
  imports = [
    inputs.nix-mc.nixosModules.nix-mc
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  environment.systemPackages = [pkgs.minecraftctl];

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
        "eula.txt" = "${inputs.mc-astronaut-server}/eula.txt";
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
