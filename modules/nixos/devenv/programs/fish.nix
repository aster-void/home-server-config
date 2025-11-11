{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      h = "hx";
      zel = "zellij";
      gd = "git diff";
      gf = "git fetch --prune";
      gl = "git pull";
      gs = "git status -s";
    };
  };
}
