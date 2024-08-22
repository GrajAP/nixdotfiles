{
  pkgs,
  lib,
  theme,
  ...
}:
with lib; let
  waybar-wttr = pkgs.stdenv.mkDerivation {
    name = "waybar-wttr";
    buildInputs = [
      (pkgs.python39.withPackages
        (pythonPackages: with pythonPackages; [requests]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./waybar-wttr.py} $out/bin/waybar-wttr
      chmod +x $out/bin/waybar-wttr
    '';
  };
in {
  home.packages = [waybar-wttr];
  programs.waybar = {
    enable = true;
    style = with theme.colors; ''
  * {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: Material Design Icons, Iosevka Nerd Font;
  }

  window#waybar {
    background-color: #${base};
    border-radius: 0px;
    color: #${accent};
    font-size: 20px;
    /* transition-property: background-color; */
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #workspaces {
    font-size: 15px;
    background-color: #${surface0};
  }

  #pulseaudio {
    color: #${accent};
  }
  #network {
    color: #${accent};
  }

  #workspaces button {
    background-color: transparent;
    color: #${blue};
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
  }

  /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
  #workspaces button:hover {
    color: #${sapphire};
  }

  #custom-power {
      color: #${red};
  }

  #custom-lock {
      color: #${accent};
  }

  #workspaces button.active {
    color: #${accent};
  }

  #workspaces button.urgent {
    background-color: #${red};
  }

  #clock,
  #network,
  #cpu,
  #battery,
  #backlight,
  #memory,
  #workspaces,
  #custom-search,
  #custom-power,
  #custom-todo,
  #custom-lock,
  #custom-weather,
  #custom-btc,
  #custom-eth,
  #volume,
  #pulseaudio {
    border-radius: 15px;
    margin: 0px 7px 0px 7px;
    background-color: #${surface0}; 
    padding: 10px 0px 10px 0px;
  }

  #custom-power {
    margin-bottom: 7px;
    padding-right: 6px;
  }
  #custom-search {
    background-image: url("${theme.sakura}");
    background-size: 60%;
    background-position: center;
    background-repeat: no-repeat;
    margin-top: 7px;
  }
  #clock {
    font-weight: 700;
    font-size: 20px;
    padding: 5px 0px 5px 0px;
    font-family: "Iosevka Term";
  }
  #backlight {
    padding-right: 2px;
    color: #${accent};
  }
  #battery {
    color: #${accent};
  }

  #battery.warning {
    color: #${peach};
  }

  #battery.critical:not(.charging) {
    color: #${red};
  }
  tooltip {
    font-family: 'Lato', sans-serif;
    border-radius: 15px;
    padding: 20px;
    margin: 30px;
    color: #${accent}
  }
  tooltip label {
    font-family: 'Lato', sans-serif;
    padding: 20px;
  }
'';
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
          "custom/weather"
          "backlight"
          "battery"
        ];
        modules-center = [];
        modules-right = ["pulseaudio" "network" "clock" "custom/power"];
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
        "custom/search" = {
          format = " ";
          tooltip = false;
          on-click = "${pkgs.tofi}/bin/tofi-drun";
        };

        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = "waybar-wttr";
          return-type = "json";
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "sh -c '(sleep 0.5s; hyprlock)' & disown";
          format = "";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "";
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
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "{icon}\n󰚥";
          tooltip-format = "{timeTo} {capacity}% 󱐋{power}";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰤨";
          format-alt = "󰤨";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          scroll-step = 5;
          tooltip = true;
          tooltip-format = "{volume}% {format_source}";
          on-click = "pkill -9 pavucontrol || ${pkgs.pavucontrol}/bin/pavucontrol";
          format = " {icon}\n{volume}%";
          format-bluetooth = "󰂯 {icon} {volume}%";
          format-muted = "󰝟 ";
          format-icons = {
            default = ["" "" " "];
          };
        };
      };
    };
  };
}

