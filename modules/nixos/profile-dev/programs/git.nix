{...}: {
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "aster";
        email = "137767097+aster-void@users.noreply.github.com";
      };
      alias = {
        aa = "add -A";
        amend = "commit --amend --no-edit";
        sync = "fetch --prune --all";
        behead = ''
          !bash -c '
            set -euo pipefail
            git fetch --prune --all
            git switch -d $(git symbolic-ref refs/remotes/''${1:-origin}/HEAD)
          ' _
        '';
        b = "branch";
        co = "checkout";
        sw = "switch";
        detach = "switch --detach";
        ls = "ls-files";
        u = "push --set-upstream origin HEAD";
        uncommit = "reset HEAD~";
        unstage = "reset HEAD --";
        nuke = "!git checkout -f HEAD && git clean -f";
        recommit = "commit --amend";
        vacuum = "!git branch | grep -v --fixed-string '*' | xargs --no-run-if-empty git branch -d";
        last = "log -1 HEAD";
      };
      ghq.root = "~/workspace";
      diff.external = "difft";
      pager.difftool = true;
    };
  };
}
