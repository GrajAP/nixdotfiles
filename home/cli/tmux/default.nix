{
  pkgs,
  config,
  ...
}: let
  tmuxPlugins = pkgs.tmuxPlugins;
  black = config.lib.stylix.colors.base00;
  background = config.lib.stylix.colors.base02;
  text = config.lib.stylix.colors.base05;
  accent = config.lib.stylix.colors.base0D;
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

    plugins = [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    clock24 = true;
    extraConfig = ''
               set -g mouse on
               set -g default-terminal "tmux-256color"
               set -g default-terminal "screen-256color"

               unbind C-b
               set -g prefix C-Space
               bind C-Space send-prefix
               bind h select-pane -L
               bind j select-pane -D
               bind k select-pane -U
               bind l select-pane -R
               set -g base-index 1
               set -g pane-base-index 1
               set-option -g renumber-windows on
               set-window-option -g mode-keys vi
               bind-key -T copy-mode-vi v send-keys -X begin-selection
               bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
               bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
               bind '"' split-window -v -c "#{pane_current_path}"
               bind % split-window -h -c "#{pane_current_path}"
               set-option -g status-position top

              set -g pane-border-style fg='#{@thm_blue}'
              set -g pane-active-border-style fg='#{@thm_blue}'
              set -g status-style bg='#{@thm_bg}',fg='#{@thm_fg}'
              set -g status-interval 1
              set -g status-right-length 60
              set-window-option -g window-status-separator ""
              set -g status-left "#[bg=#{@thm_crust}]#[fg=#{@thm_fg}]"
              set -g status-left '#[bg=#{@thm_crust}]#[fg=#{@thm_fg}]#{?client_prefix,#[fg=#{@thm_blue}],} 󱄅 '
              set -g window-status-current-format "#[bold]#[fg=#{@thm_crust}]#[bg=#{@thm_blue}] #I#[nobold] #W "
              set -g window-status-format "#[bold]#[fg=#{@thm_fg}]#[bg=#{@thm_crust}] #I#[nobold] #W "
              set -g status-right '#[fg=#{@thm_fg},bg=#{@thm_bg}] #(${pkgs.tmux-mem-cpu-load}/bin/tmux-mem-cpu-load -g 0 -a 0 --interval 2) '
              set -ga status-right '#[fg=#{@thm_fg},bg=#{@thm_crust}] %a %H:%M:%S #[fg=#{@thm_crust},bg=#{@thm_blue}] %Y-%m-%d '

      set -g mouse on

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

      set -g pane-border-style fg='#${black}'
      set -g pane-active-border-style fg='#${accent}'

      set -g status-style bg='#${background}',fg='#${text}'
      set -g status-interval 1
      set -g status-right-length 60
      set-window-option -g window-status-separator ""
      set -g status-left "#[bg=#${black}]#[fg=#${text}]"
      set -g status-left '#[bg=#${black}]#[fg=#${text}]#{?client_prefix,#[fg=#${accent}],} 󱄅 '
      set -ga status-left '#[bg=#${black}]#[fg=#${accent}]#{?window_zoomed_flag,   , }'
      set -g window-status-current-format "#[bold]#[fg=#${text}]#[bg=#${accent}] #I#[nobold] #W "
      set -g window-status-format "#[bold]#[fg=#${text}]#[bg=#${black}] #I#[nobold] #W "
      set -g status-right '#[fg=#${text},bg=#${background}] #(${pkgs.tmux-mem-cpu-load}/bin/tmux-mem-cpu-load -g 0 -a 0 --interval 2) '
      set -ga status-right '#[fg=#${text},bg=#${black}] %a %H:%M:%S #[fg=#${text},bg=#${accent}] %Y-%m-%d '
    '';
  };
}
