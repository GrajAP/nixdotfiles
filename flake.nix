{
  description = "nixAP";
  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.grajap = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./grajap.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };
    nixosConfigurations.dellap = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};

      modules = [
        (import ./disko.nix {device = "/dev/sda";})
        ({inputs, ...}: {
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
        })
        inputs.disko.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprcontrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };
}
