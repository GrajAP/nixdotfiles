{...}:
# glue all configs together
{
  config.home.stateVersion = "24.11";
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    ./packages.nix
    ./cli
    ./scripts
    ./rice
    ./misc
  ];
}
