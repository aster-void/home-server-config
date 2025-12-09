{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.shell.glue;
in {
  config.systemd.user.services = lib.mkIf cfg.enable {
    # Waybar systemd service
    waybar = {
      Unit = {
        Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors";
        Documentation = "https://github.com/Alexays/Waybar/wiki";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
        Wants = ["graphical-session.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        Restart = "always";
        RestartSec = 3;
        TimeoutStopSec = 10;
        KillMode = "control-group";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    # Waybar config file watcher service
    waybar-watcher = {
      Unit = {
        Description = "Waybar Config File Watcher";
        After = ["waybar.service"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.writeShellScript "waybar-watcher" ''
          set -euo pipefail
          while true; do
            ${pkgs.inotify-tools}/bin/inotifywait -r -e modify,move,create,delete "$HOME/.config/waybar"
            echo "Waybar config changed, restart..."
            systemctl --user restart waybar || true
            sleep 0.5
          done
        ''}";
        Restart = "always";
        RestartSec = 5;
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };

    # Dunst notification daemon service
    dunst-session = {
      Unit = {
        Description = "Dunst notification daemon";
        Documentation = "man:dunst(1)";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.dunst}/bin/dunst";
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
