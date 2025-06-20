{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "bcn" (builtins.readFile ./bcn))
    (pkgs.writeShellScriptBin "katana-switch" (builtins.readFile ./katana-switch))
  ];
}
