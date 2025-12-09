_: let
  term = "kitty";
  mainMod = "SUPER";
in {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = mainMod;
    "$TERM" = term;

    bind = [
      # System commands
      "${mainMod}, L, exec, hyprlock"

      # App launching + closing
      "${mainMod}, N, exec, ${term}"
      "${mainMod}, E, killactive"
      "${mainMod}, O, exec, fuzzel"
      "${mainMod}, K, exec, rofi -show"
      "${mainMod}, I, exec, caelestia shell drawers toggle launcher"
      "${mainMod}, delete, exec, systemctl --user stop graphical-session.target && hyprctl dispatch exit"
      "${mainMod}, F, togglefloating"
      "${mainMod} SHIFT, F, fullscreen"
      "${mainMod}, J, togglesplit"

      # Screenshots
      "${mainMod}, P, exec, hyprshot -m region"
      "${mainMod} SHIFT, P, exec, hyprshot -m output"
      "${mainMod} CTRL, P, exec, hyprshot -m window"

      # Brightness
      "${mainMod}, f4, exec, brightnessctl s 10%-"
      "${mainMod}, f5, exec, brightnessctl s +10%"

      # Move focus (WASD in workman = DASH)
      "${mainMod}, D, movefocus, u"
      "${mainMod}, A, movefocus, l"
      "${mainMod}, S, movefocus, d"
      "${mainMod}, H, movefocus, r"

      # Move windows
      "${mainMod} SHIFT, D, movewindow, u"
      "${mainMod} SHIFT, A, movewindow, l"
      "${mainMod} SHIFT, S, movewindow, d"
      "${mainMod} SHIFT, H, movewindow, r"

      # Switch workspaces
      "${mainMod}, 1, workspace, 1"
      "${mainMod}, 2, workspace, 2"
      "${mainMod}, 3, workspace, 3"
      "${mainMod}, 4, workspace, 4"
      "${mainMod}, 5, workspace, 5"
      "${mainMod}, 6, workspace, 6"
      "${mainMod}, 7, workspace, 7"
      "${mainMod}, 8, workspace, 8"
      "${mainMod}, 9, workspace, 9"
      "${mainMod}, 0, workspace, 10"

      # Swipe between workspaces
      "${mainMod}, left, workspace, r-1"
      "${mainMod}, right, workspace, r+1"

      # Move to workspace
      "${mainMod} SHIFT, 1, movetoworkspace, 1"
      "${mainMod} SHIFT, 2, movetoworkspace, 2"
      "${mainMod} SHIFT, 3, movetoworkspace, 3"
      "${mainMod} SHIFT, 4, movetoworkspace, 4"
      "${mainMod} SHIFT, 5, movetoworkspace, 5"
      "${mainMod} SHIFT, 6, movetoworkspace, 6"
      "${mainMod} SHIFT, 7, movetoworkspace, 7"
      "${mainMod} SHIFT, 8, movetoworkspace, 8"
      "${mainMod} SHIFT, 9, movetoworkspace, 9"
      "${mainMod} SHIFT, 0, movetoworkspace, 10"

      # Special workspace (scratchpad)
      "${mainMod}, M, togglespecialworkspace, magic"
      "${mainMod} SHIFT, M, movetoworkspace, special:magic"

      # Scroll through workspaces
      "${mainMod}, mouse_down, workspace, e-1"
      "${mainMod}, mouse_up, workspace, e+1"

      # Middle mouse button (no-op)
      ",mouse:274, exec, ;"
    ];

    # Move/resize with mouse
    bindm = [
      "${mainMod}, mouse:272, movewindow"
      "${mainMod}, mouse:273, resizewindow"
    ];

    # Non-consuming bind (passes key to other apps too)
    bindn = [
      ", escape, exec, eww close power-menu"
    ];
  };
}
