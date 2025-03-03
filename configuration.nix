{inputs, ...}: {
  imports = [
    ./system
    ./theme
  ];
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.grajap.imports = [./home];
  };
}
