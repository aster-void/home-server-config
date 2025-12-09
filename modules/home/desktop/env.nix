{...}: {
  home.sessionVariables = {
    # Default applications
    EDITOR = "hx";
    BROWSER = "zen-beta";
    TERMINAL = "alacritty";

    # Wayland
    NIXOS_OZONE_WL = 1;

    # XDG directories
    XDG_PICTURES_DIR = "Pictures";

    # Hyprshot
    HYPRSHOT_DIR = "Pictures/Screenshot";
  };
}
