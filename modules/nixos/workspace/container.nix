{config, ...}: let
  packagesFor = import ./packages.nix;
  programsConfig = import ./programs.nix;
in {
  containers.workspace = {
    autoStart = true;
    privateNetwork = false;
    config = {pkgs, ...}: let
      workspacePackages = packagesFor pkgs;
      fhsPromptProfile = pkgs.writeTextFile {
        name = "fhs-fish-prompt";
        destination = "/etc/fish/conf.d/fhs-prompt.fish";
        text = "set -gx __fish_prompt_hostname FHS\n";
      };
      fhs = pkgs.buildFHSEnv {
        name = "fhs";
        targetPkgs = pkgs':
          (packagesFor pkgs')
          ++ [
            pkgs'.nix
            fhsPromptProfile
          ];
        runScript = "fish";
      };
    in {
      networking.hostName = "workspace";
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      services.openssh = {
        enable = true;
        ports = [
          2222
          2223
        ];
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
        openssh.authorizedKeys.keys = config.meta.sshAuthorizedKeys;
        shell = pkgs.fish;
      };
      programs = programsConfig;
      environment.systemPackages = workspacePackages ++ [fhs];

      fileSystems."/run/workspace-secrets" = {
        device = "/var/lib/workspace-secrets";
        fsType = "none";
        options = [
          "bind"
          "ro"
        ];
      };

      system.stateVersion = "25.05";
    };
  };
}
