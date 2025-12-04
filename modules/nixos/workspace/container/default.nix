{
  sshAuthorizedKeys,
  pkgs,
  inputs,
  flake,
  ...
}: let
  packageList = pkgs':
    import ../../../home/profile-dev/packages.nix {
      pkgs = pkgs';
      inherit inputs;
    };
  fhsPromptProfile = pkgs.writeTextFile {
    name = "fhs-fish-prompt";
    destination = "/etc/fish/conf.d/fhs-prompt.fish";
    text = "set -gx __fish_prompt_hostname FHS\n";
  };
  fhs = pkgs.buildFHSEnv {
    name = "fhs";
    targetPkgs = pkgs':
      (packageList pkgs')
      ++ [
        pkgs'.nix
        fhsPromptProfile
      ];
    runScript = "fish";
  };
in {
  networking.hostName = "workspace";
  networking.firewall.enable = false;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Home Manager
  imports = [
    inputs.home-manager.nixosModules.home-manager
    flake.nixosModules.profile-dev
  ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit flake inputs;
    };
    users.aster = {
      imports = [
        flake.homeModules.profile-dev
      ];
    };
  };

  services.openssh = {
    enable = true;
    ports = [
      2222
      2223
    ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      GatewayPorts = "clientspecified";
    };
    extraConfig = ''
      Match LocalPort 2223
        ForceCommand ${fhs}/bin/fhs
    '';
  };
  systemd.services.sshd = {
    restartIfChanged = false;
    reloadIfChanged = true;
  };

  users.users.aster = {
    isNormalUser = true;
    home = "/home/aster";
    createHome = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = sshAuthorizedKeys;
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.systemPackages = [fhs];

  system.stateVersion = "26.05";
}
