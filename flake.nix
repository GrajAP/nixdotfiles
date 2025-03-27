{
  description = "nixAP";
  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations.grajap = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        (import ./hosts/grajap)
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
      ];
    };
    nixosConfigurations.dellap = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};

      modules = [
        (import ./disko.nix {device = "/dev/sda";})
        (import ./hosts/dellap)
        ./configuration.nix
        inputs.disko.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            useUserPackages = true;
            users.grajap.imports = [./home];
          };
        }
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
