{...}: {
  programs.fish = {
    enable = true;
    functions = {
      zz = {
        description = "Fuzzy-find ghq repo and attach/create zellij session";
        body = ''
          set -l repo (ghq list | fzf)
          test -z "$repo" && return 1

          set -l repo_path (ghq root)/$repo
          set -l session_name (string replace -a '/' '_' $repo)

          # Check if session exists
          if zellij list-sessions 2>/dev/null | grep -q "^$session_name\$"
              zellij attach $session_name
          else
              zellij -s $session_name options --default-cwd $repo_path
          end
        '';
      };
    };
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
