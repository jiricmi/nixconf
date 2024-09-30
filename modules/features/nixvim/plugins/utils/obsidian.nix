
_ : {
  programs.nixvim = {
    plugins.obsidian = {
      enable = true;
      settings = {
        workspaces = [
          {
            name = "SecondBrain";
            path = "~/repos/second_brain/Welcome.md";
          }
        ];
        dailyNotes = {
          folder = "0_Daily_Notes";
          dateFormat = "%Y-%m-%d";
          aliasFormat = "%B %-d, %Y";
        };
      };
    };
  };
}
