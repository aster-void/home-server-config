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
          set -l session_name (basename $repo)

          # Check if session exists
          if zellij list-sessions -s 2>/dev/null | rg -qx "$session_name"
              zellij attach $session_name
          else
              zellij -s $session_name options --default-cwd $repo_path
          end
        '';
      };
    };
    # Shell aliases are defined in desktop/shell/default.nix
    # This module only provides dev-specific fish functions
  };
}
