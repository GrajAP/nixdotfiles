{...}: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, ^(gtk-layer-shell)$"
      "blur, ^(launcher)$"
      "blur, anyrun"
      " ignorealpha 0.6, anyrun"
      "ignorezero, ^(gtk-layer-shell)$"
      "ignorezero, ^(launcher)$"
      "blur, notifications"
      "ignorezero, notifications"
      "blur, bar"
      "ignorezero, bar"
      "ignorezero, ^(gtk-layer-shell|anyrun)$"
      "blur, ^(gtk-layer-shell|anyrun)$"
      "noanim, launcher"
      "noanim, bar"
    ];
    windowrulev2 = [
      # only allow shadows for floating windows
      "noshadow, floating:0"

      "idleinhibit focus, class:^(mpv)$"
      "idleinhibit focus,class:foot"
      "idleinhibit fullscreen, class:^(firefox)$"

      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "float, class:^(imv)$"
      "opacity 0.8, class:^(neovide)$"

      # throw sharing indicators away

      "idleinhibit fullscreen, class:^(Counter)$"
      "workspace 3, title:^(.*(Disc|WebC)ord.*)$"
      "workspace 3, class:^(Caprine)$"
      "workspace 1, class:^(Counter)$"
      "workspace 2, class:^(firefox)$"
      "workspace 2, class:(firefox|librewolf|brave)"
      "workspace 4 silent, class:(signal|vesktop)"
      "suppressevent maximize, class:.*"
      "scrolltouchpad 0.23, class:^(zen|firefox|brave|chromium-browser|chrome-.*)$"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };
}
