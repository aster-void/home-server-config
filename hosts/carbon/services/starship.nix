{
  # Two-line prompt: all modules on line 1, PWD on line 2
  # `$all` excludes modules explicitly placed in `format` (like `directory`).
  add_newline = false;
  # Line 1: CWD + git branch
  # Line 2: username@host {all modules}
  # Line 3: exit_status >
  format = ''
    $line_break$directory$git_branch
    $username$hostname$all
    $status$character
  '';
  palette = "aster";
  palettes.aster = {
    pink = "#FFC1CC"; # bubble pink
    mustard = "#af8700";
  };

  golang = {
    symbol = " ";
    style = "cyan";
  };

  rust = {
    symbol = " ";
  };

  gleam = {
    symbol = " ";
  };

  nodejs = {
    symbol = "󰎙 ";
    style = "bold green";
    detect_extensions = [];
    detect_files = ["yarn.lock" "package-lock.json" ".nvmrc"];
    detect_folders = [];
  };
  bun = {
    symbol = " ";
    style = "bold pink";
  };

  java = {
    symbol = " ";
    detect_files = ["pom.xml" "build.gradle.kts" ".java-version" "deps.edn" "project.clj" "build.boot" ".sdkmanrc"];
  };
  scala = {
    symbol = " ";
    style = "red dimmed";
  };

  c = {
    symbol = " ";
    style = "bold blue";
  };

  python = {
    symbol = "[p](blue)[y](yellow) ";
  };

  nix_shell = {
    format = "in [$symbol$state( \($name\))]($style) ";
    symbol = "󱄅 ";
  };

  # Show non-zero exit status of the last command (on line 1 via $all)
  status = {
    disabled = false;
    format = "[✖ $status]($style) ";
    style = "bold red";
    map_symbol = true;
    recognize_signal_code = true;
    pipestatus = false; # set true to show all statuses in a pipeline
  };

  git_status = {
    format = "([< $ahead_behind $all_status>]($style) )";
    style = "yellow";

    conflicted = "<=>";
    ahead = "^";
    behind = "v";
    stashed = "stash";
    modified = "*";
    staged = "+";
    renamed = ">";
    deleted = "d";
  };

  # Host name (SSH only) at the start (subdued)
  hostname = {
    disabled = false;
    ssh_only = true;
    format = "[@$hostname]($style) ";
    style = "mustard dimmed";
  };

  # Username (always show locally; subdued). Root remains prominent.
  username = {
    show_always = true;
    format = "[$user]($style) ";
    style_user = "cyan";
    style_root = "bold red";
  };

  # Show branch with conditional prefix; prints nothing outside git repos
  git_branch = {
    format = "on [$symbol$branch]($style) ";
    symbol = " ";
    style = "pink";
  };

  directory = {
    # Show full path from ~, do not cut at repo root
    truncate_to_repo = false;
    truncation_length = 0; # 0 = no truncation
    read_only = " [readonly]";
    read_only_style = "yellow bold";
    repo_root_style = "blue";
  };

  # Cloud/Container contexts
  kubernetes = {
    disabled = false;
    # e.g., kind-kind (ns) or prod (kube-system)
    format = "[⎈ $context( \($namespace\))]($style) ";
    style = "cyan";
  };

  docker_context = {
    disabled = false;
    format = "[ $context]($style) ";
    only_with_files = false; # show regardless of docker files
    style = "blue";
  };

  aws = {
    disabled = false;
    format = "[ $profile( \($region\))]($style) ";
    style = "yellow";
  };
}
