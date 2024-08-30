{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    vlc
    firefox
    wlogout
    killall
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
    neovim
    wget
    git
    dconf
  ];
}
