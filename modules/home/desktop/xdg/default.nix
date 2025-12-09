{
  imports = [
    ./mime.nix
    ./desktop-entries.nix
    ./env-vars.nix
  ];

  # Enable XDG Base Directory Specification support
  # This automatically sets XDG_CONFIG_HOME, XDG_DATA_HOME, XDG_STATE_HOME, XDG_CACHE_HOME
  xdg.enable = true;
}
