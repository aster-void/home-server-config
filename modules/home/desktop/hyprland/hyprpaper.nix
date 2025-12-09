{config, ...}: let
  wallpaperPath = "${config.xdg.configHome}/wallpaper";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [wallpaperPath];
      wallpaper = [",${wallpaperPath}"];
      splash = false;
    };
  };
}
