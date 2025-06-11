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
        position = "top";
        height = 36;
        spacing = 7;
        fixed-center = false;
        margin-left = null;
        margin-top = null;
        margin-bottom = null;
        margin-right = null;
        exclusive = true;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = ["bluetooth" "pulseaudio" "network" "clock"];
        modules-center = ["hyprland/window"];
        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) — Mozilla Firefox" = "🌎 $1";
            "(.*) - zsh " = "> [$1]";
          };
          separate-outputs = true;
          icon = true;
        };
        clock = {
          format = "{%d-%m-%Y}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        bluetooth = {
          on-click = ''
            bash -c 'bluetoothctl power $(bluetoothctl show | grep -q "Powered: yes" && echo off || echo on)'
          '';
        };
        backlight = {
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        cpu = {
          interval = 5;
          format = "  {}%";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-alt = "{icon}";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          on-click = "${pkgs.killall}/bin/killall pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = "{icon}  {volume}%";
          format-muted = "󰝟 ";
          format-bluetooth = "󰂯 {volume}%";
          format-icons = {
            default = ["" "" " "];
          };
        };
        network = let
          nm-editor = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        in {
          format-wifi = "󰤨 {essid}";
          format-ethernet = "󰈀";
          format-alt = "󱛇";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
          on-click-right = "${nm-editor}";
        };
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          active-only = false;
          format-icons = {
            default = "";
            active = "";
          };

          persistent_workspaces = {
            "*" = 5;
          };
        };
      };
    };
  };
}
