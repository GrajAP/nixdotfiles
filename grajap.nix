{inputs, ...}: {
  imports = [
    ./hosts/grajap
    ./system
    ./theme
  ];
  home-manager = {
    #backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.grajap.imports = [./home];
  };
}
