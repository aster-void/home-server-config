{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.profiles.desktop;
in {
  environment = lib.mkIf cfg.enable {
    systemPackages = with pkgs; [wl-clipboard];
    variables = {
      QT_QPA_PLATFORM = "wayland;xcb"; # allow fallback to x11 (xwayland) when wayland is not found
      ELECTRON_OZONE_PLATFORM_HINT = "auto"; # hyprland wiki says it should be "auto"
    };
  };
  services = lib.mkIf cfg.enable {
    speechd.enable = true;
    xserver.enable = true;
    libinput.enable = true;
    xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    '';
  };
  programs = lib.mkIf cfg.enable {
    xwayland.enable = true;
    dconf.enable = true;
  };

  qt = lib.mkIf cfg.enable {
    enable = true;
  };

  xdg.portal = lib.mkIf cfg.enable {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
