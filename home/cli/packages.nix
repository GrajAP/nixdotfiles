{pkgs, ...}: let
  texlive = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-small
      noto
      mweights
      cm-super
      cmbright
      fontaxes
      beamer
      ;
  };
in {
  home.packages = with pkgs; [
    fastfetch
    ollama
    texlive
    python3
    gcc
    nodejs
    lsix
    rustup
    neovim
    neovide
    killall
    zoxide
    wget
    # Tbh should be preinstalled
    gnumake
    # Runs programs without installing them
    comma

    # grep replacement
    ripgrep

    # ping, but with cool graph
    gping

    # dns client
    dogdns

    # neofetch but for git repos
    onefetch

    # neofetch but for cpu's
    cpufetch

    # download from yt and other websites
    yt-dlp
    catimg

    # man pages for tiktok attention span mfs
    tealdeer

    # markdown previewer
    glow

    # profiling tool
    hyperfine

    # gimp for acoustic people
    krita

    # premiere pro for acoustic people
    ffmpeg-full

    # networking stuff
    nmap
    wget

    # faster find
    fd

    # http request thingy
    xh

    # generate regex
    grex

    # todo app for acoustic people (wrriten by me :3)
    todo

    # json thingy
    jq

    # syncthnig for acoustic people
    rsync

    figlet
    # Generate qr codes
    qrencode

    # script kidde stuff
    hcxdumptool
    hashcat

    unzip
    # tshark
    # termshark
  ];
}
