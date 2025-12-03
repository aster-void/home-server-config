{lib, ...}: let
  inherit (lib) concatStringsSep filterAttrs mapAttrs mapAttrsToList unique;
  removeNullAttrs = attrs: filterAttrs (_: v: v != null) attrs;

  formatters = {
    alejandra = ["alejandra" "-" "--quiet"];
    biome = ext: ["biome" "format" "--stdin-file-path=a.${ext}"];
    prettier = parser: ["prettier" "--parser" parser];
    mix = ext: ["mix" "format" "--stdin-filename" "a.${ext}" "-"];
    typstyle = ["typstyle"];
  };

  languages = {
    nix = {
      language-servers = [
        "nil"
        "nixd"
      ];
      formatter = formatters.alejandra;
      auto-pairs = {
        "(" = ")";
        "{" = "}";
        "[" = "]";
        "\"" = "\"";
        "`" = "`";
        "=" = ";";
      };
    };

    markdown = {
      auto-format = true;
    };

    mdx = {
      auto-format = true;
      file-types = ["mdx"];
      scope = ".mdx";
      language-servers = ["markdown-oxide"];
    };

    html = {
      language-servers = [
        "emmet-ls"
        "tailwind"
        "superhtml"
        "vscode-html-language-server"
      ];
    };

    css = {
      language-servers = [
        "vscode-css-language-server"
        "tailwind"
      ];
    };

    typescript = {
      formatter = formatters.biome "ts";
      language-servers = [
        {
          name = "typescript-language-server";
          except-features = ["format"];
        }
        {
          name = "biome";
          except-features = ["format"];
        }
      ];
    };

    tsx = {
      language-servers = [
        "biome"
        "emmet-ls"
        "typescript-language-server"
        "tailwind"
      ];
    };

    svelte = {
      formatter = formatters.prettier "svelte";
      language-servers = [
        "emmet-ls"
        "tailwind"
        "svelteserver"
        "typescript-language-server"
      ];
    };

    astro = {
      formatter = formatters.prettier "astro";
      scope = "source.astro";
      injection-regex = "astro";
      file-types = ["astro"];
      roots = [
        "package.json"
        "astro.config.mjs"
      ];
      language-servers = [
        "tailwind"
        "astro-ls"
      ];
    };

    typst.formatter = formatters.typstyle;
    elixir.formatter = formatters.mix "elixir";
    heex.formatter = formatters.mix "heex";

    json.formatter = formatters.biome "json";
    jsonc.formatter = formatters.biome "jsonc";
  };

  language-servers = {
    astro-ls.command = [
      "astro-ls"
      "--stdio"
    ];
    biome.command = [
      "bun"
      "biome"
      "lsp-proxy"
    ];
    deno.command = [
      "deno"
      "lsp"
    ];
    emmet-ls.command = ["emmet-ls"];
    javascript-typescript-langserver.command = [
      "javascript-typescript-langserver"
      "--stdio"
    ];
    markdown-oxide.command = ["markdown-oxide"];
    superhtml.command = ["superhtml" "lsp"];
    nil.command = ["nil"];
    nixd.command = ["nixd"];
    rust-analyzer = {
      command = ["rust-analyzer"];
      config.checkOnSave.command = "clippy";
    };
    svelteserver.command = ["svelteserver"];
    tailwind.command = [
      "tailwindcss-language-server"
      "--stdio"
    ];
    typescript-language-server.command = [
      "typescript-language-server"
      "--stdio"
    ];
    vscode-css-language-server.command = [
      "vscode-css-language-server"
      "--stdio"
    ];
    vscode-html-language-server.command = [
      "vscode-html-language-server"
      "--stdio"
    ];
  };

  toCmdAttrs = cmdList:
    if cmdList == null
    then null
    else
      removeNullAttrs {
        command = builtins.head cmdList;
        args =
          if builtins.length cmdList > 1
          then builtins.tail cmdList
          else null;
      };

  serverNameRefs = servers:
    builtins.map (server:
      if builtins.isString server
      then server
      else server.name)
    servers;

  referencedLanguageServers = builtins.concatMap (
    def:
      if def ? language-servers
      then serverNameRefs def.language-servers
      else []
  ) (builtins.attrValues languages);

  missingLanguageServers =
    unique (builtins.filter (name: !(builtins.hasAttr name language-servers)) referencedLanguageServers);
in {
  assertions = [
    {
      assertion = missingLanguageServers == [];
      message = "Undefined Helix language servers referenced: " + concatStringsSep ", " missingLanguageServers;
    }
  ];
  programs.helix.languages = {
    language-server =
      mapAttrs (
        _: server: removeNullAttrs (toCmdAttrs server.command // {config = server.config or null;})
      )
      language-servers;
    language =
      mapAttrsToList (
        name: {
          auto-format ? true,
          language-servers ? null,
          formatter ? null,
          auto-pairs ? null,
          scope ? null,
          roots ? null,
          file-types ? null,
          injection-regex ? null,
        }:
          removeNullAttrs {
            inherit
              name
              auto-format
              auto-pairs
              language-servers
              scope
              roots
              file-types
              injection-regex
              ;
            formatter = toCmdAttrs formatter;
          }
      )
      languages;
  };
}
