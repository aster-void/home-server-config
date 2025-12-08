{...}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $line_break$directory$git_branch
        $username$hostname$all
        $status$character
      '';

      palette = "aster";
      palettes.aster = {
        pink = "#FFC1CC";
        mustard = "#af8700";
      };

      status = {
        disabled = false;
        format = "[✖ $status]($style) ";
        style = "bold red";
        map_symbol = true;
        recognize_signal_code = true;
        pipestatus = false;
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

      hostname = {
        disabled = false;
        ssh_only = true;
        format = "[@$hostname]($style) ";
        style = "mustard dimmed";
      };

      username = {
        show_always = true;
        format = "[$user]($style) ";
        style_user = "cyan";
        style_root = "bold red";
      };

      git_branch = {
        format = "on [$symbol$branch]($style) ";
        symbol = " ";
        style = "pink";
      };

      directory = {
        truncate_to_repo = false;
        truncation_length = 0;
        read_only = " [readonly]";
        read_only_style = "yellow bold";
        repo_root_style = "blue";
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
        detect_files = [
          "yarn.lock"
          "package-lock.json"
          ".nvmrc"
        ];
        detect_folders = [];
      };

      bun = {
        symbol = " ";
        style = "bold pink";
      };

      java = {
        symbol = " ";
        detect_files = [
          "pom.xml"
          "build.gradle.kts"
          ".java-version"
          "deps.edn"
          "project.clj"
          "build.boot"
          ".sdkmanrc"
        ];
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

      kubernetes = {
        disabled = false;
        format = "[⎈ $context( \($namespace\))]($style) ";
        style = "cyan";
      };

      docker_context = {
        disabled = false;
        format = "[ $context]($style) ";
        only_with_files = false;
        style = "blue";
      };

      aws = {
        disabled = false;
        format = "[ $profile( \($region\))]($style) ";
        style = "yellow";
      };
    };
  };
}
