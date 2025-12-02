{lib, ...}: let
  inherit (lib) mapAttrsToList optionalAttrs;

  languages = {
    nix = {
      language-servers = ["nil"];
      formatter = [
        "alejandra"
        "-q"
      ];
    };

    go = {
      language-servers = ["gopls"];
      formatter = ["gofmt"];
    };

    rust = {
      language-servers = ["rust-analyzer"];
      formatter = ["rustfmt"];
    };

    bash = {
      language-servers = ["bash"];
      formatter = [
        "shfmt"
        "-i"
        "2"
        "-ci"
      ];
    };

    fish = {
      language-servers = ["fish"];
      formatter = ["fish_indent"];
    };

    typescript = {
      language-servers = ["typescript"];
      formatter = [
        "prettier"
        "--parser"
        "typescript"
      ];
    };

    tsx = {
      language-servers = ["typescript"];
      formatter = [
        "prettier"
        "--parser"
        "typescript"
      ];
    };

    javascript = {
      language-servers = ["typescript"];
      formatter = [
        "prettier"
        "--parser"
        "babel"
      ];
    };

    json = {
      language-servers = ["json"];
      formatter = [
        "jq"
        "."
      ];
    };

    yaml = {
      language-servers = ["yaml"];
      formatter = [
        "prettier"
        "--parser"
        "yaml"
      ];
    };

    toml = {
      language-servers = ["taplo"];
      formatter = [
        "taplo"
        "format"
        "-"
      ];
    };

    lua = {
      language-servers = ["lua"];
      formatter = [
        "stylua"
        "-"
      ];
    };

    dockerfile = {
      language-servers = ["docker"];
    };

    python = {
      language-servers = ["pyright"];
      formatter = [
        "black"
        "-"
      ];
    };
  };

  language-server = {
    gopls.command = "gopls";
    rust-analyzer.command = "rust-analyzer";
    bash = {
      command = "bash-language-server";
      args = ["start"];
    };
    fish.command = "fish-lsp";
    nil.command = "nil";
    typescript = {
      command = "typescript-language-server";
      args = ["--stdio"];
    };
    yaml = {
      command = "yaml-language-server";
      args = ["--stdio"];
    };
    json = {
      command = "vscode-json-language-server";
      args = ["--stdio"];
    };
    taplo = {
      command = "taplo";
      args = [
        "lsp"
        "stdio"
      ];
    };
    lua.command = "lua-language-server";
    docker = {
      command = "docker-langserver";
      args = ["--stdio"];
    };
    pyright = {
      command = "pyright-langserver";
      args = ["--stdio"];
    };
  };
in {
  programs.helix.languages = {
    language-server = language-server;
    language =
      mapAttrsToList (
        name: def:
          {
            inherit name;
            auto-format = def.auto-format or true;
          }
          // optionalAttrs (def ? language-servers) {
            language-servers = def.language-servers;
          }
          // optionalAttrs (def ? formatter) {
            formatter =
              {
                command = builtins.head def.formatter;
              }
              // optionalAttrs (builtins.length def.formatter > 1) {
                args = builtins.tail def.formatter;
              };
          }
      )
      languages;
  };
}
