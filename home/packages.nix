{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    safeeyes
    vlc
    firefox
    wlogout
    killall
    caprine-bin
    python3
    libreoffice-fresh
    inkscape
    tdesktop
    webcord
    calcurse
    pulseaudio
    signal-desktop
    transmission-gtk
    gimp
    wireshark
    keepassxc
    neovim
    wget
    git
    foot
    dconf
  ];
}

