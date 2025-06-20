{
  pkgs,
  config,
  ...
}: let
  tmuxPlugins = pkgs.tmuxPlugins;
  black = config.lib.stylix.colors.base00;
  text = config.lib.stylix.colors.base05;
  accent = config.lib.stylix.colors.base0D;
in {
  programs.tmux = {
    enable = true;
    plugins = [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    extraConfig = ''
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
      set-option -g status-position top

      set -g status-style bg=default,fg='#${text}'
      set -g status-interval 1
      set -g status-right-length 100
      set-window-option -g window-status-separator ""
      set -g status-left '#[bg=#${black}]#[fg=#${text}]'
      set -g status-left '#[bg=#${black}]#[fg=#${text}]#{?client_prefix,#[fg=#${accent}],} 󱄅 '
      set -ga status-left '#[bg=#${black}]#[fg=#${accent}]#{?window_zoomed_flag,   , }'
      set -g window-status-current-format '#[bold]#[fg=#${black}]#[bg=#${accent}] #I#[nobold] #W '
      set -g window-status-format '#[bold]#[fg=#${text}]#[bg=#${black}] #I#[nobold] #W '
      set -g status-right '#[fg=#${accent},bg=#${black}]  #{pane_current_path} #[fg=#${accent},bg=#${black}]  #S '
    '';
  };
}
