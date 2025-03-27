{inputs, ...}: {
  imports = [
    ./system
    ./theme
  ];
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useUserPackages = true;
    users.grajap = {
      home.stateVersion = "24.11";
      imports = [
        ./home
      ];
    };
  };
}
