{pkgs, ...}: {
  services.dunst = {
    enable = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders;
      name = "Papirus";
    };
    settings = {
      global = {
        width = 220;
        height = "(0 ,280)";
        offset = "(0,15)";
        corner_radius = 10;
        origin = "top-center";
        notification_limit = 3;
        idle_threshold = 120;
        ignore_newline = "no";
        mouse_left_click = "close_current";
        mouse_right_click = "close_all";
        sticky_history = "yes";
        history_length = 20;
        show_age_threshold = 60;
        ellipsize = "middle";
        padding = 10;
        always_run_script = true;
        frame_width = 2;
        transparency = 10;
        progress_bar = true;
        progress_bar_frame_width = 0;
        #       highlight = x pink;
      };
      fullscreen_delay_everything.fullscreen = "delay";
      urgency_low = {
        #       background = "#${base}83";
        #       foreground = x text;
        timeout = 5;
      };
      urgency_normal = {
        #       background = "#${base}83";
        #       foreground = "#c6d0f5";
        timeout = 6;
      };
      urgency_critical = {
        #       background = "#${base}83";
        #foreground = x text;
        #       frame_color = "#${red}80";
        timeout = 0;
      };
    };
  };
}
