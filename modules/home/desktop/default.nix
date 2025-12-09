{inputs, ...}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.nix-hazkey.homeModules.hazkey

    ./options.nix
    ./home.nix
    ./env.nix
    ./packages.nix
    ./xdg.nix
    ./system
    ./programs
    ./hyprland
    ./shells
    ./services
    ./extensions
  ];
}
