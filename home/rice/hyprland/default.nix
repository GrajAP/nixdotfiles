{
  pkgs,
  inputs,
  ...
}: {
  imports = [./config.nix ./binds.nix ./rules.nix];
  home.packages = with pkgs;
  with inputs.hyprcontrib.packages.${pkgs.system}; [
    libnotify
    swaybg
    wireplumber
    nwg-look
    wf-recorder
    brightnessctl
    pamixer
    #python39Packages.requests
    slurp
    grim
    swappy
    grimblast
    hyprpicker
    wl-clip-persist
    wl-clipboard
    pngquant
    cliphist
    (writeShellScriptBin
      "pauseshot"
      ''
        ${hyprpicker}/bin/hyprpicker -r -z &
        picker_proc=$!

        ${grimblast}/bin/grimblast save area - | tee ~/pics/$(date +'screenshot-%F').png | wl-copy

        kill $picker_proc
      '')
    (
      writeShellScriptBin "micmute"
      ''
        #!/bin/sh

        # shellcheck disable=SC2091
        if $(pamixer --default-source --get-mute); then
          pamixer --default-source --unmute
          sudo mic-light-off
        else
          pamixer --default-source --mute
          sudo mic-light-on
        fi
      ''
    )
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.default;
    package = pkgs.hyprland;
    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
  services = {
    wlsunset = {
      # TODO: fix opaque red screen issue
      enable = true;
      latitude = "52";
      longitude = "21";
      temperature = {
        day = 6200;
        night = 3500;
      };
      systemdTarget = "hyprland-session.target";
    };
  };
  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
