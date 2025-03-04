{pkgs, ...}: let
  wttr = pkgs.stdenv.mkDerivation {
    name = "wttr";
    propagatedBuildInputs = [
      (pkgs.python3.withPackages (pythonPackages:
        with pythonPackages; [
          consul
          six
          requests
        ]))
    ];
    dontUnpack = true;
    installPhase = "install -Dm755 ${./wttr.py} $out/wttr";
  };
in {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        width = 57;
        spacing = 7;
        modules-left = [
          "hyprland/workspaces"
          "battery"
        ];
        modules-center = ["custom/weather"];
        modules-right = ["pulseaudio" "network" "clock"];
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };

          persistent_workspaces = {
            "*" = 0;
          };
        };
        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = "${wttr}/wttr";
          return-type = "json";
        };
        clock = {
          format = ''
            {:%H
            %M}'';
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        backlight = {
          tooltip = false;
          format = "{icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        network = {
          format-wifi = "󰤨 essid";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          on-click = "pkill -f nm-connection-editor || ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = false;
          on-click = "pkill -9 pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{volume}%";
          format-bluetooth = "󰂯 {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            default = ["" "" " "];
          };
        };
      };
    };
  };
}
