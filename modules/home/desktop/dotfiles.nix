# Static dotfiles from config/desktop/
# These are managed via xdg.configFile instead of home-manager options
{inputs, ...}: let
  configDir = "${inputs.self}/config/desktop";
in {
  xdg.configFile = {
    "kitty".source = "${configDir}/kitty";
    "alacritty".source = "${configDir}/alacritty";
    "ghostty".source = "${configDir}/ghostty";
    "waybar".source = "${configDir}/waybar";
    "lazygit".source = "${configDir}/lazygit";
    "yazi".source = "${configDir}/yazi";
    "cava".source = "${configDir}/cava";
    "dunst".source = "${configDir}/dunst";
    "eww".source = "${configDir}/eww";
    "fcitx5".source = "${configDir}/fcitx5";
    "caelestia".source = "${configDir}/caelestia";
    "uwsm".source = "${configDir}/uwsm";
    "vesktop".source = "${configDir}/vesktop";
    "zed".source = "${configDir}/zed";
  };
}
