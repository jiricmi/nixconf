{pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    ohMyZsh = {
      enable = true;
      plugins = [
        "sudo"
        "git"
	"docker"
	"vi-mode"
      ];
      theme = "robbyrussell";
    };
  };   
  
  users.defaultUserShell = pkgs.zsh;
}
