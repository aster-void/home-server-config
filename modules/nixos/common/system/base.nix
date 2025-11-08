{
  pkgs,
  inputs,
  ...
}: {
  # Core system packages
  environment.systemPackages = with pkgs; [
    # core utils
    coreutils-full
    bash
    fish
    curl
    ripgrep
    zellij
    jq

    # monitor & analyze
    btop
    ncdu
    macchina
    nushell
    inputs.nix-mc.packages.${pkgs.system}.nix-mc-cli

    # terminal compatibility
    kitty.terminfo
  ];

  # Enable comprehensive terminal support
  environment.enableAllTerminfo = true;

  # Enable systemd for service management
  systemd.enableEmergencyMode = false;

  # Enable sudo for wheel group
  security.sudo.enable = true;

  # Enable fish shell
  programs.fish.enable = true;
  programs.zoxide.enable = true;

  # Nix configuration
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # Common keyboard configuration
  services.xserver.xkb = {
    layout = "us";
    variant = "workman";
    options = "caps:escape";
  };

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Locale settings
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.extraLocaleSettings = {
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  time.timeZone = "Asia/Tokyo";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
