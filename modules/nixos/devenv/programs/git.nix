{...}: {
  programs.git = {
    enable = true;
    config = {
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
        sw = "switch";
        detach = "switch --detach";
        u = "push --set-upstream origin HEAD";
        vacuum = "!git branch | grep -v --fixed-string '*' | xargs --no-run-if-empty git branch -d";
        last = "log -1 HEAD";
      };
      ghq.root = "~/workspace";
      diff.external = "difft";
      pager.difftool = true;
    };
  };
}
