{...}: {
  imports = [
    ./languages.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = false;
    settings = {
      theme = "dark+";
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
