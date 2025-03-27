{inputs, ...}:
# glue all configs together
{
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
