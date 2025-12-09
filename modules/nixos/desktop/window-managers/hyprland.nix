{pkgs, ...}: {
  programs.hyprland = {
    # Install the packages from nixpkgs
    enable = true;
    xwayland.enable = true;
    # use Universal Wayland Session Manager
    withUWSM = true;
  };

  # Enable UWSM system-wide (configuration is handled by programs.hyprland.withUWSM)
  programs.uwsm.enable = true;

  environment.systemPackages = with pkgs; [
    # walker
    hyprland
    hyprland-protocols
    hyprcursor
    hyprpaper
    hypridle
    hyprlock
  ];

  security.pam.services.hyprlock = {};
}
