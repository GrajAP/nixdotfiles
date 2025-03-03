{inputs, ...}:
# glue all configs together
{
  config.home.stateVersion = "24.11";
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    ./packages.nix
    ./cli
    ./scripts
    ./rice
    ./misc
  ];
}
