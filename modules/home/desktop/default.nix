{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.nix-hazkey.homeModules.hazkey

    ./home.nix
    ./packages.nix
    ./dev.nix
    ./dotfiles.nix
    ./gui
    ./services
    ./xdg
    ./apps
    ./i18n
    ./secrets
    ./hyprland
    ./shells
    ./extensions
  ];
}
