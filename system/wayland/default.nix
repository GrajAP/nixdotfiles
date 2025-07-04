{pkgs, ...}: {
  imports = [./fonts.nix ./pipewire.nix ./services.nix];
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  environment = {
    variables = {
      __GL_GSYNC_ALLOWED = "1";
      __GL_VRR_ALLOWED = "1";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland,x11";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      DISABLE_QT_COMPAT = "0";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };
  };
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
