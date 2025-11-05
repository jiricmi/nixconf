{inputs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "accounts@mjiricek.eu";
        name = "jiricmi";
      };
    };
  };
}


