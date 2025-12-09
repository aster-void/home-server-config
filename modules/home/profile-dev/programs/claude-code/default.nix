{...}: {
  programs.claude-code = {
    enable = true;
    memory.source = ./claude.md;
  };
}
