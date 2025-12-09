{pkgs, ...}: {
  gtk.enable = true;

  home.packages = [
    pkgs.papirus-icon-theme
    pkgs.adwaita-icon-theme
    pkgs.kdePackages.breeze-icons
    pkgs.qt6Packages.qt6ct
  ];
}
