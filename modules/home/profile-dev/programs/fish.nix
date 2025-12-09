{...}: let
  shellAliases = {
    ".." = "cd ../";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";

    h = "hx";
    "h." = "hx .";

    g = "git";
    glog = "git log --oneline";
    gb = "git branch";
    gba = "git branch -a";
    gco = "git checkout";
    gcob = "git checkout -b";
    gsw = "git switch";
    gf = "git fetch --prune";
    gs = "git status -s";
    gsr = "git status";
    ga = "git add -A";
    gp = "git push";
    gu = "git push --set-upstream origin HEAD";
    gl = "git pull";
    gsv = "git diff --cached";
    gd = "git diff";
    lg = "lazygit";

    dush = "du -sh";
    fetch = "nitch";
    claer = "clear";
    cl = "clear";

    sl = "ls";
    lsa = "ls -a";
    la = "ls -a";
    ls = "ez";
    ez = "eza --icons --group-directories-first";
    l = "ls";
    c = "clear";

    flake = "nix flake";
    hs = "nh home switch";
    hb = "nh home build";
    home = "home-manager";
    nixgc = "nix-collect-garbage";
    rbs = "nh os switch";
    rbb = "nh os boot";
    rbbb = "nh os boot && reboot";
    rbt = "nh os test";
    yz = "yazi";
    zel = "zellij";
    sd = "shutdown";

    # bash/fish specific
    cg = "cd $(git root)";
    sizeof = "du -sh";
    nixman = "cd /etc/nixos/; sudo -s;";
  };
in {
  programs.fish = {
    enable = true;
    inherit shellAliases;
    interactiveShellInit = ''
      set -g fish_greeting
      set -g __starship_fish_use_job_groups "false"
    '';
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
  };
}
