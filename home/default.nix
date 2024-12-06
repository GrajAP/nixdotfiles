{
  inputs,
  config,
  ...
}:
# glue all configs together
{
  config.home.stateVersion = "24.05";
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    inputs.nix-index-db.hmModules.nix-index
    inputs.barbie.homeManagerModule
    inputs.nix-colors.homeManagerModule
    inputs.schizofox.homeManagerModule
    ./packages.nix

    ./cli
    ./scripts
    ./rice
    ./misc
  ];
}
