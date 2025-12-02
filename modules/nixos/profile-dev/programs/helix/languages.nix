{pkgs ? null}: ''
  # Language servers
  [language-server.gopls]
  command = "gopls"

  [language-server.rust-analyzer]
  command = "rust-analyzer"

  [language-server.bash]
  command = "bash-language-server"
  args = ["start"]

  [language-server.fish]
  command = "fish-lsp"

  [language-server.nil]
  command = "nil"

  [language-server.typescript]
  command = "typescript-language-server"
  args = ["--stdio"]

  [language-server.yaml]
  command = "yaml-language-server"
  args = ["--stdio"]

  [language-server.json]
  command = "vscode-json-language-server"
  args = ["--stdio"]

  [language-server.taplo]
  command = "taplo"
  args = ["lsp", "stdio"]

  [language-server.lua]
  command = "lua-language-server"

  [language-server.docker]
  command = "docker-langserver"
  args = ["--stdio"]

  [language-server.pyright]
  command = "pyright-langserver"
  args = ["--stdio"]

  # Languages and formatters
  [[language]]
  name = "nix"
  language-servers = ["nil"]
  formatter = { command = "alejandra", args = ["-q"] }

  [[language]]
  name = "go"
  language-servers = ["gopls"]
  formatter = { command = "gofmt" }

  [[language]]
  name = "rust"
  language-servers = ["rust-analyzer"]
  formatter = { command = "rustfmt" }

  [[language]]
  name = "bash"
  language-servers = ["bash"]
  formatter = { command = "shfmt", args = ["-i", "2", "-ci"] }

  [[language]]
  name = "fish"
  language-servers = ["fish"]
  formatter = { command = "fish_indent" }

  [[language]]
  name = "typescript"
  language-servers = ["typescript"]
  formatter = { command = "prettier", args = ["--parser", "typescript"] }

  [[language]]
  name = "tsx"
  language-servers = ["typescript"]
  formatter = { command = "prettier", args = ["--parser", "typescript"] }

  [[language]]
  name = "javascript"
  language-servers = ["typescript"]
  formatter = { command = "prettier", args = ["--parser", "babel"] }

  [[language]]
  name = "json"
  language-servers = ["json"]
  formatter = { command = "jq", args = ["."] }

  [[language]]
  name = "yaml"
  language-servers = ["yaml"]
  formatter = { command = "prettier", args = ["--parser", "yaml"] }

  [[language]]
  name = "toml"
  language-servers = ["taplo"]
  formatter = { command = "taplo", args = ["format", "-"] }

  [[language]]
  name = "lua"
  language-servers = ["lua"]
  formatter = { command = "stylua", args = ["-"] }

  [[language]]
  name = "dockerfile"
  language-servers = ["docker"]
  # no widely used formatter for dockerfile; rely on LSP diagnostics

  [[language]]
  name = "python"
  language-servers = ["pyright"]
  formatter = { command = "black", args = ["-"] }
''
