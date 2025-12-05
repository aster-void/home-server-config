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
        auto-format = true;
        line-number = "relative";
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "error";
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };
        mouse = true;
        soft-wrap = {
          enable = true;
        };
        true-color = true;
        rulers = [80 100];
        indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 2;
        };
        file-picker = {
          hidden = false;
        };
        whitespace = {
          characters = {
            space = " ";
            nbsp = "⍽";
            nnbsp = "␣";
            tab = "→";
          };
        };
      };
      keys = {
        insert = {
          C-c = ["completion"];
        };
      };
    };
  };
}
