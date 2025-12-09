# todo
{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        mechatroner.rainbow-csv
        oderwat.indent-rainbow
        yoavbls.pretty-ts-errors
        svelte.svelte-vscode
        jnoortheen.nix-ide
        hediet.vscode-drawio
      ];
    };
  };
}
