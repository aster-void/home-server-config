{
  # Desktop environment configuration
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable Wayland
  services.displayManager.gdm.wayland = true;
}
