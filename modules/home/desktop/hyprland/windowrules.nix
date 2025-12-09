_: let
  term = "kitty";
in {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Base opacity rules
      "opacity 0.8, focus:0"
      "opacity 1, focus:1"
      "opacity 1, fullscreen:1"

      # Terminal
      "opacity 0.8, class:${term}"
      "opacity 0.95, class:${term}, focus:1, floating:0"

      # Windsurf
      "opacity 0.85, class:windsurf"
      "opacity 0.7, class:windsurf, focus:0"

      # Tearing for games
      "immediate, class:^myfavouritegame$"
    ];

    layerrule = [
      "blur, waybar"
      "blur, gtk-layer-shell"
      "blur, eww"
    ];
  };
}
