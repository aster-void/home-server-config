{
  pkgs,
  config,
  inputs,
  ...
}: let
  vscodePackage =
    if config.programs.vscode.enable
    then config.programs.vscode.package
    else pkgs.vscode;
  configDir = "${inputs.self}/config/desktop";
in {
  # Enable XDG Base Directory Specification support
  # This automatically sets XDG_CONFIG_HOME, XDG_DATA_HOME, XDG_STATE_HOME, XDG_CACHE_HOME
  xdg.enable = true;

  # MIME type associations
  xdg.mime.enable = true;
  xdg.mimeApps = let
    browser = "zen-beta.desktop";
    mailing = "userapp-Thunderbird-7X5TC3.desktop";
    calendar = "userapp-Thunderbird-7X5TC3.desktop";
  in {
    enable = true;
    defaultApplications = {
      "text/html" = browser;
      "text/xml" = browser;
      "image/png" = browser;
      "image/jpeg" = browser;
      "image/jpg" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
      "application/xhtml+xml" = browser;
      "application/pdf" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/discord" = "discord.desktop";
      "x-scheme-handler/slack" = "slack.desktop";
      "x-scheme-handler/notion" = "notion-app-enhanced.desktop";
      "application/x-zoom" = "us.zoom.Zoom.desktop";
      "x-scheme-handler/zoommtg" = "us.zoom.Zoom.desktop";
      "x-scheme-handler/mailto" = mailing;
      "message/rfc822" = mailing;
      "x-scheme-handler/mid" = mailing;
      "x-scheme-handler/webcal" = calendar;
      "text/calendar" = calendar;
      "application/x-extension-ics" = calendar;
      "x-scheme-handler/webcals" = calendar;
    };
  };

  # Desktop entries
  xdg.desktopEntries = {
    slack = {
      name = "Slack";
      exec = "slack --enable-wayland-ime %U";
      icon = "${pkgs.slack}/share/pixmaps/slack.png";
    };
    discord = {
      name = "Discord";
      exec = "discord --enable-wayland-ime %U";
      icon = "${pkgs.discord}/share/pixmaps/discord.png";
    };
    vscode = {
      name = "VS Code";
      exec = "code --enable-wayland-ime %U";
      icon = "${vscodePackage}/share/pixmaps/vscode.png";
    };
  };

  # Static dotfiles from config/desktop/
  # These are managed via xdg.configFile instead of home-manager options
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
