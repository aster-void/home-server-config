{...}: {
  imports = [
    ./languages.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        "auto-format" = true;
        "line-number" = "relative";
        mouse = true;
        "true-color" = true;
        rulers = [80 100];
      };
    };
  };
}
