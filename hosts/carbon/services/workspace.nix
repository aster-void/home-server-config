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
      btop
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
      kitty.terminfo

      # LS
      nil
      nixd
    ];
in {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    config = {pkgs, ...}: let
      workspacePackages = basePackages pkgs;
      fhsPromptProfile = pkgs.writeTextFile {
        name = "fhs-fish-prompt";
        destination = "/etc/fish/conf.d/fhs-prompt.fish";
        text = "set -gx __fish_prompt_hostname FHS\n";
      };
      fhs = pkgs.buildFHSEnv {
        name = "fhs";
        targetPkgs = pkgs: (basePackages pkgs) ++ [pkgs.nix fhsPromptProfile];
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
      systemd.services.sshd = {
        restartIfChanged = false;
        reloadIfChanged = true;
      };

      users.users.aster = {
        isNormalUser = true;
        home = "/home/aster";
        extraGroups = ["wheel"];
        openssh.authorizedKeys.keys = meta.sshAuthorizedKeys;
        shell = pkgs.fish;
      };

      programs.fish.enable = true;
      programs.zoxide.enable = true;
      environment.systemPackages = workspacePackages ++ [fhs];

      fileSystems."/run/workspace-secrets" = {
        device = "/var/lib/workspace-secrets";
        fsType = "none";
        options = ["bind" "ro"];
      };

      system.stateVersion = "25.05";
    };
  };

  networking.firewall.allowedTCPPorts = [2222 2223];
}
