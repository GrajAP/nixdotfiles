{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    udev
    vlc
    wlogout
    google-chrome
    netflix
    caprine-bin
    python3
    libreoffice-fresh
    tdesktop
    webcord
    calcurse
    pulseaudio
    signal-desktop
    transmission-gtk
    gimp
    wireshark
    dconf
  ];
}
