{
  pkgs,
  config,
  lib,
  ...
}: let
  vscodePackage =
    if config.programs.vscode.enable
    then config.programs.vscode.package
    else pkgs.vscode;
in {
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
}
