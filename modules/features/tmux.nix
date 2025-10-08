{ inputs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      ...
      set -g status-right '#[fg=black,bg=color15] #{cpu_percentage}  %H:%M '
    '';
  };
}
