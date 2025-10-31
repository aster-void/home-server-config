{meta, ...}: let
  basePackages = pkgs:
    with pkgs; [
      coreutils
      lsof
      tree
      gnumake
      bash
      openssl
      openssh
      curl
      jq
      yq-go
      ripgrep
      fzf
      yazi
      nushell
      zip
      unzip
      gnutar
      ffmpeg
      imagemagick
      inkscape
      lazygit
      gnused
      git
      zellij
      tmux
      helix
      claude-code
      codex
    ];
in {
  containers.workspace = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "10.233.0.1";
    localAddress = "10.233.0.2";
    config = {pkgs, ...}: let
      workspacePackages = basePackages pkgs;
      fhs = pkgs.buildFHSEnv {
        name = "fhs";
        targetPkgs = pkgs: (basePackages pkgs) ++ [pkgs.nix];
        runScript = "fish";
      };
    in {
      networking.hostName = "workspace";
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = ["nix-command" "flakes"];

      services.openssh = {
        enable = true;
        ports = [2222 2223];
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
        };
        extraConfig = ''
          Match LocalPort 2223
            ForceCommand ${fhs}/bin/fhs
        '';
      };

      users.users.aster = {
        isNormalUser = true;
        home = "/home/aster";
        extraGroups = ["wheel"];
        openssh.authorizedKeys.keys = meta.sshAuthorizedKeys;
        shell = pkgs.fish;
      };

      programs.fish.enable = true;
      environment.systemPackages = workspacePackages ++ [fhs];

      fileSystems."/run/workspace-secrets" = {
        device = "/var/lib/workspace-secrets";
        fsType = "none";
        options = ["bind" "ro"];
      };

      system.stateVersion = "25.05";
    };
  };

  networking.nat.enable = true;
  networking.firewall.allowedTCPPorts = [2222 2223];
  networking.nat.internalInterfaces = ["ve-+"];
  networking.nat.externalInterface = "eth0";

  networking.nat.forwardPorts = [
    {
      sourcePort = 2222;
      destination = "10.233.0.2:2222";
      destinationPort = 2222;
    }
    {
      sourcePort = 2223;
      destination = "10.233.0.2:2223";
      destinationPort = 2223;
    }
  ];
}
