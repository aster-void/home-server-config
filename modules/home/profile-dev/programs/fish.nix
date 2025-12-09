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
  };
}
