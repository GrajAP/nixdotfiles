{inputs, ...}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];

  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    #quickCss = "some CSS";  # quickCSS file
    config = {
      useQuickCss = true; # use out quickCSS
      themeLinks = [
        # or use an online theme
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-pink.theme.css"
      ];
      frameless = true; # set some Vencord options
      plugins = {
        hideAttachments.enable = true; # Enable a Vencord plugin
        youtubeAdblock.enable = true;
        showHiddenChannels.enable = true;
        ignoreActivities = {
          # Enable a plugin and set some options
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
          # ignoredActivities = [ "someActivity" ];
        };
      };
    };
  };
}
