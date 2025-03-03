{inputs, ...}: {
  imports = [
    ./hosts/dellap
    ./system
    ./theme
  ];
  home-manager = {
    #backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.grajap.imports = [./home];
  };
}
