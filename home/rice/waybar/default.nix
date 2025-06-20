{pkgs, ...}: {
  home.file.".config/uair/uair.toml".text = ''
    [defaults]
    format = "{time}\n"
    paused_state_text = "paused"
    resumed_state_text = "resumed"

    [[sessions]]
    id = "work"
    name = "Work"
    duration = "25m"
    time_format = "%M:%S"
    command = "notify-send 'Rest!' && hyprlock"

    [[sessions]]
    id = "rest"
    autostart = true
    name = "Rest"
    duration = "5m"
    time_format = "%M:%S"
    command = "notify-send 'Work!' && curl -d 'Work time 😄!' ntfy.sh/atavism && killall uair || uair "

  '';
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
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
        margin-left = null;
        margin-top = null;
        margin-bottom = null;
        margin-right = null;
        exclusive = true;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-right = ["custom/uair" "bluetooth" "pulseaudio" "network" "clock"];
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
          format = "{:%Y-%m-%d %H:%M:%S}";
          interval = 1;
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

        "custom/uair" = {
          format = "{icon} {}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          tooltip = false;
          return-type = "json";
          interval = 1;
          on-click = "uairctl toggle";
          on-click-middle = "uairctl prev";
          on-click-right = "uairctl next";
          exec-if = "which uairctl";
          exec = "uairctl fetch '{\"text\":\"{name} {time} {percent}% \",\"class\":\"{state}\",\"percentage\":{percent}}'";
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
