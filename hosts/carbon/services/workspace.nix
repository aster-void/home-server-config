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
      nh
      claude-code
      codex
      kitty.terminfo
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
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        fish = {
          enable = true;
          shellAliases = {
            "..." = "cd ../..";
            "...." = "cd ../../..";
            "....." = "cd ../../../..";
            "......" = "cd ../../../../..";
            h = "hx";
            zel = "zellij";
          };
        };
        starship = {
          enable = true;
          settings = import ./starship.nix;
        };
        git = {
          enable = true;
          config.alias = {
            sync = "fetch --prune --all";
            behead = ''
              !bash -c '
                set -euo pipefail
                git fetch --prune --all
                git switch -d $(git symbolic-ref refs/remotes/''${1:-origin}/HEAD)
              ' _
            '';
            b = "branch";
            detach = "switch --detach";
            u = "push --set-upstream origin HEAD";
            vacuum = "!git branch | grep -v --fixed-string '*' | xargs --no-run-if-empty git branch -d";
            gf = "fetch --prune";
            gl = "pull";
            gs = "status -s";
          };
        };
        zoxide.enable = true;
      };
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
