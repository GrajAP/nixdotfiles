{...}: {
  stylix.targets.neovim = {
    enable = true;
  };
  programs.neovide = {
    enable = true;
    settings = {
      transparency = 0.8;
      normal_opacity = 0.8;
    };
  };
}
