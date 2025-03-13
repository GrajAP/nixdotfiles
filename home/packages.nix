{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    chromium
    electron
    vscode
    github-desktop
    brave
    udev
    vlc
    caprine-bin
    nemo
    libreoffice-fresh
    calcurse
    spotify-player
    signal-desktop
  ];
}
