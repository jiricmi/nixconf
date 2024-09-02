{pkgs, input, config, lib, ...}:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    colorschemes.gruvbox.enable = true;

    plugins.lualine.enable = true;
    
    plugins.lsp = {
      enable = true;
      servers = {
        pyright.enable = true;
	tsserver.enable = true;
	lua-ls = {
	  enable = true;
          settings.telemetry.enable = false;
	};
      };
    };

    plugins.nvim-cmp = {
      enable = true;
      autoEnableSources = true;
    };
  };
}
