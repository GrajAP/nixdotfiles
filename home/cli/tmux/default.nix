{pkgs, ...}: let
  plugins = ["vim-tmux-navigator" "sensible" "yank"];
in {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    clock24 = true;
    extraConfig = ''
                 set -g mouse on
      set -g default-terminal "tmux-256color"
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_window_status_style "rounded"

      # Make the status line pretty and add some modules
      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -ag status-right "#{E:@catppuccin_status_session}"
      set -ag status-right "#{E:@catppuccin_status_uptime}"
      set -agF status-right "#{E:@catppuccin_status_battery}"
                 unbind C-b
                 set -g prefix C-Space
                 bind C-Space send-prefix

                 bind h select-pane -L
                 bind j select-pane -D
                 bind k select-pane -U
                 bind l select-pane -R

                 # Start windows and panes at 1, not 0
                 set -g base-index 1
                 set -g pane-base-index 1
                 set-window-option -g pane-base-index 1
                 set-option -g renumber-windows on

            ${builtins.concatStringsSep "\n" (map (x: "run-shell ${pkgs.tmuxPlugins.${x}}/share/tmux-plugins/${x}.tmux") plugins)}

                 # set vi-mode
                 set-window-option -g mode-keys vi
                 # keybindings
                 bind-key -T copy-mode-vi v send-keys -X begin-selection
                 bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
                 bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

                 bind '"' split-window -v -c "#{pane_current_path}"
                 bind % split-window -h -c "#{pane_current_path}"


                 set -g status-interval 1
                 set -g status-right-length 60
                 set-window-option -g window-status-separator ""

    '';
  };
}
