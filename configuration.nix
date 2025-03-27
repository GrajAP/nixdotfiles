{inputs, ...}: {
  imports = [
    ./system
    ./theme
  ];
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useUserPackages = true;
    users.grajap.imports = [./home];
  };
}
