{pkgs, ...}: {
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
        ];
        modules-center = ["sway/window"];
        modules-right = ["pulseaudio" "bluetooth" "network" "clock"];
        "custom/window" = {
          format = "{icon} {title}";
        };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon} ";
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
          format = "{icon} {percent}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}";
          format-charging = "󰂄 {capacity}";
          format-plugged = "󰂄 {capacity}";
          format-alt = "{icon}";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        bluetooth = {
          format-connected = "con";
          on-click = ''
            bash -c 'bluetoothctl power $(bluetoothctl show | grep -q "Powered: yes" && echo off || echo on)'
          '';
        };

        network = let
          nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        in {
          format-wifi = "󰤨 ";
          format-ethernet = "󰈀";
          format-alt = "󱛇";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          on-click-right = "${nm-editor}";
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
