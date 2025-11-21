{ inputs, home, ... }:
{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };
  home.shellAliases = {
    ls = "eza --icons";
    ll = "eza -lh --icons --git --time-style=relative";
    la = "eza -la --icons --git --header";
    lt = "eza --tree --level=2 --icons";
  };
}
