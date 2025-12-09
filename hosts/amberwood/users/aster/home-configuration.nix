{flake, ...}: {
  imports = [
    flake.homeModules.profile-dev
    flake.homeModules.desktop
  ];

  my.shell = {
    glue.enable = true;
    glue.type = "glassy";
  };
  my.desktop.gaming.enable = true;
  my.hyprland = {
    primaryMonitor = "DP-1";
    sensitivity = "0.3";
    touchpadScrollFactor = "0.15";
  };
}
