{pkgs, ...}:
pkgs.writeShellApplication {
  name = "waydroid-ui";
  runtimeInputs = [pkgs.waydroid];

  text = ''
    waydroid show-full-ui
  '';
}
