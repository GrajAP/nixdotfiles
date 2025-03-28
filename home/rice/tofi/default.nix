{
  pkgs,
  config,
  ...
}: let
  tofi-emoji = pkgs.writeShellScriptBin "tofi-emoji" ''
    #!/bin/sh
    cat ${./emojis} | tofi --prompt-text "Emoji: " | awk '{print $1}' | tr -d '\n' | tee >(wl-copy) >(xargs -I % notify-send "% Emoji" "Emoji copied to clipboard")
  '';
in {
  home.packages = [pkgs.tofi tofi-emoji];
  xdg.configFile."tofi/config".text = ''
    anchor = right
    width = 500
    height = 300
    horizontal = false
    font-size = 14
    prompt-text = "Run "
    font = monospace
    ascii-input = false
    outline-width = 5
    border-width = 2
    min-input-width = 120
    late-keyboard-init = true
    result-spacing = 10
    padding-top = 15
    padding-bottom = 15
    padding-left = 15
    padding-right = 15
    outline-color = ${config.lib.stylix.colors.withHashtag.base02}
    border-color = ${config.lib.stylix.colors.withHashtag.base0D}
    background-color = ${config.lib.stylix.colors.withHashtag.base00}
    text-color = ${config.lib.stylix.colors.withHashtag.base05}
    selection-color = ${config.lib.stylix.colors.withHashtag.base0D}

  '';
}
