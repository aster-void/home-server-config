{pkgs, ...}:
pkgs.writeShellApplication {
  name = "setpaper";
  runtimeInputs = [pkgs.hyprpaper];
  text = builtins.readFile ./main.sh;
}
