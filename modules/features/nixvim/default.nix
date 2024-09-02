{pkgs, input, config, lib, ...}:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };

}
