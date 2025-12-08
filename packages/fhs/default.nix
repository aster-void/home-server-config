{pkgs, ...}: let
  fhsPromptProfile = pkgs.writeTextFile {
    name = "fhs-fish-prompt";
    destination = "/etc/fish/conf.d/fhs-prompt.fish";
    text = "set -gx __fish_prompt_hostname FHS\n";
  };
in
  pkgs.buildFHSEnv {
    name = "fhs";
    targetPkgs = pkgs': [
      pkgs'.nix
      fhsPromptProfile
    ];
    runScript = "fish";
  }
