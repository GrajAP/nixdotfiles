{lib, ...}: {
  programs.neovim.extraConfig = lib.fileContents ./nvim/init.lua;
  imports = [
    ./zsh
    ./starship.nix
    ./bottom.nix
    ./git.nix
    ./run-as-service.nix
    ./packages.nix
    ./xdg.nix
  ];
}
