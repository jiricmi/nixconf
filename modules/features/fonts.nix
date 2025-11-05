{ pkgs, ... }:
{

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v18n.psf.gz";
    packages = with pkgs; [ terminus_font ];
  };
  fonts.packages =
    with pkgs;
    [
      helvetica-neue-lt-std
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      terminus_font
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
