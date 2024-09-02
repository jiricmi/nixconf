{pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';

    ohMyZsh = {
      enable = true;
      plugins = [
        "sudo"
        "git"
	"docker"
	"vi-mode"
      ];
    };
  };   
  
  users.defaultUserShell = pkgs.zsh;
}
