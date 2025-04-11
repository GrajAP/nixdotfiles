{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "brightnessctl set 100%"
        # foot terminal server
        "${lib.optionalString config.programs.foot.server.enable ''foot --server''}"
      ];

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        # keyboard layout
        kb_layout = "pl";
        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0.8;
      };

      general = {
        # gaps
        gaps_in = 6;
        gaps_out = 11;

        # border thiccness
        border_size = 2;

        #"col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base0E})";
        #"col.active_border" = lib.mkForce "rgb(${accent})";
        #"col.inactive_border" = "rgb(${surface0})";
      };

      decoration = {
        # fancy corners
        rounding = 7;

        # blur
        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          ignore_opacity = false;
          new_optimizations = 1;
          xray = true;
          contrast = 0.7;
          brightness = 0.8;
        };
      };

      misc = {
        # disable redundant renders
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;

        vfr = true;

        # window swallowing
        enable_swallow = true; # hide windows that spawn other windows
        swallow_regex = "^(foot)$";

        # dpms
        mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
        key_press_enables_dpms = true; # enable dpms on keyboard action
        disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
      };

      animations = {
        enabled = true;
        first_launch_animation = false;

        bezier = [
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "overshot, 0.4,0.8,0.2,1.2"
        ];

        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "border,1,10,default"

          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces,1,4,overshot,slidevert"
        ];
      };

      dwindle = {
        pseudotile = false;
        preserve_split = "yes";
      };

      "$kw" = "dwindle:no_gaps_when_only";

      monitor = [
        ",highrr,auto,1"
        #"eDP-1,1920x1080,0x0,1"
        #"HDMI-A-1,2560x1440, 0x0,1"
      ];
    };
  };
}
