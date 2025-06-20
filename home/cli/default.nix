{...}: {
  imports = [
    ./zsh
    #   ./run-as-service.nix
    ./tmux.nix
    ./starship.nix
    ./bottom.nix
    ./git.nix
    ./packages.nix
    ./xdg.nix
  ];
}
