_: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Environment variables for portals/tray/notifications
      "dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP"
      "systemctl --user start graphical-session.target xdg-desktop-autostart.target"

      # Launch apps on startup
      "[workspace 1 silent] kitty"
      "[workspace 2 silent] zen-beta"
      "[workspace 3 silent] discord"
      "[workspace 4 silent] slack"
      "hyprctl dispatch workspace 1"

      # IME
      "systemctl --user restart fcitx5-daemon"
    ];
  };
}
