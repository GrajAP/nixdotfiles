{...}: {
  xdg.configFile.nvim.source = ./nvim;
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
