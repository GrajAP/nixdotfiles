{...}: {
  imports = [
    ./system.nix
#   ./impernamence.nix
    ./schizo.nix
    ./network.nix
#   ./secrets.nix
    ./nix.nix
    ./users.nix
    ./bootloader.nix
#   ./openssh.nix
  ];
}
