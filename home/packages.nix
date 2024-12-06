{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    udev
    vlc
    firefox
    opera
    brave
    wlogout
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
