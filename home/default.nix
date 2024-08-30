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
    inputs.schizofox.homeManagerModule
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    ./packages.nix

    ./cli
    ./scripts
    ./rice
    ./misc
  ];
}
