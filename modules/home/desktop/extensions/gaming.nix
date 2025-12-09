{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop.gaming;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Minecraft
      prismlauncher
      lunar-client
    ];

    services.flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://flathub.org/repo/flathub.flatpakrepo";
        }
        {
          name = "launcher.moe";
          location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
        }
      ];
      packages = [
        "org.gnome.Platform//49"
        {
          appId = "moe.launcher.the-honkers-railway-launcher";
          origin = "launcher.moe";
        }
        {
          appId = "moe.launcher.sleepy-launcher";
          origin = "launcher.moe";
        }
        {
          appId = "io.mrarm.mcpelauncher";
          origin = "flathub";
        }
      ];
    };
  };
}
