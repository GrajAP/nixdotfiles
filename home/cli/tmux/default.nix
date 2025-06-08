{pkgs, ...}: let
  tmuxPlugins = pkgs.tmuxPlugins;
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
      tmuxPlugins.catppuccin
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

      set -g @catppuccin_flavour 'mocha'

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
    '';
  };
}
