{
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
      gf = "git fetch --prune";
      gl = "git pull";
      gs = "git status -s";
    };
  };

  starship = {
    enable = true;
    settings = import ./starship.nix;
  };

  git = {
    enable = true;
    config = {
      alias = {
        aa = "add -A";
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
        last = "log -1 HEAD";
      };
      ghq.root = "~/workspace";
    };
  };

  zoxide.enable = true;
}
