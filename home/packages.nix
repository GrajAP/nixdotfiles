{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    github-desktop
    brave
    #google-chrome
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
