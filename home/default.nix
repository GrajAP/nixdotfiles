{pkgs, ...}:
# glue all configs together
{
  stylix = {
    enable = true;
    iconTheme = {
      enable = true;
      package = pkgs.catppuccin-papirus-folders;
      dark = "Papirus-Dark";
      light = "Papirus-Dark";
    };
  };
  home.stateVersion = "24.11";
  home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    ./packages.nix
    ./cli
    ./scripts
    ./rice
    ./misc
  ];
}
