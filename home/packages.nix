{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    udev
    vlc
    wlogout
    firefox
    caprine-bin
    python3
    libreoffice-fresh
    tdesktop
    webcord
    calcurse
    pulseaudio
    signal-desktop
    transmission_3-gtk
    gimp
    wireshark
    dconf
  ];
}
