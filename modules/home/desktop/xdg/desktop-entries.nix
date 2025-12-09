{pkgs, ...}: {
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
      # TODO: use config.programs.vscode.package if it exists
      icon = "${pkgs.vscode}/share/pixmaps/vscode.png";
    };
  };
}
