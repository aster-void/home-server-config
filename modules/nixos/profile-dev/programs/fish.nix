{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      # Navigation
      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";

      # Editor
      h = "hx";
      "h." = "hx .";

      # Git shortcuts
      g = "git";
      gs = "git status -s";
      gd = "git diff";
      gsv = "git diff --cached";
      ga = "git add -A";
      gp = "git push";
      gl = "git pull";
      lg = "lazygit";

      # Directory navigation with fuzzy finder
      zz = "cd $(ghq root)/$(ghq list | fzf)";

      # Utilities
      dush = "du -sh";
      fetch = "nitch";

      # Typo fixes
      claer = "clear";
      cl = "clear";
      c = "clear";
      sl = "ls";

      # ls replacements
      la = "ls -a";
      ez = "eza --icons --group-directories-first";

      # Nix shortcuts
      flake = "nix flake";
      home = "home-manager";
      nixgc = "nix-collect-garbage";

      # Other tools
      yz = "yazi";
      zel = "zellij";
      sd = "shutdown";
    };
  };
}
