{
  imports = [
    ./syncthing.nix
  ];

  # Manual systemd services for Hyprland session management
  systemd.user = {
    # Declare graphical-session.target
    targets.graphical-session = {
      Unit = {
        Description = "Graphical session";
        Documentation = "man:systemd.special(7)";
        RefuseManualStart = "no";
        StopWhenUnneeded = "no";
        Requires = ["default.target"];
        After = ["default.target"];
      };
    };
  };
}
