{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hosts/dellap
    ./system
  ];
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.grajap = {
      imports = [./home];
      _module.args.theme = import ./theme;
    };
  };
}
