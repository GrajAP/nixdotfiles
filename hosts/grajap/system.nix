{
  pkgs,
  lib,
  ...
}: {
  services = {
    wordpress.sites."localhost" = {};
    ollama = {
      enable = true;
      #acceleration = "rocm";
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx803"; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = "8.0.3";
    };

    #open-webui.enable = true;
    kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            "/dev/input/by-path/pci-0000:0e:00.3-usb-0:1:1.0-event-kbd"
            #"/dev/input/by-path/pci-0000:0e:00.3-usb-0:2:1.1-event-kbd"
            #"/dev/input/by-path/pci-0000:0e:00.3-usb-0:1:1.2-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''

            (defsrc
              caps a s d f j k l ;
            )
            (defvar
              tap-time 200
              hold-time 200
            )

            (defalias
              escctrl (tap-hold $tap-time $hold-time esc lctl)
              a (multi f24 (tap-hold $tap-time $hold-time a lmet))
              s (multi f24 (tap-hold $tap-time $hold-time s ralt))
              d (multi f24 (tap-hold $tap-time $hold-time d lsft))
              f (multi f24 (tap-hold $tap-time $hold-time f lctl))
              j (multi f24 (tap-hold $tap-time $hold-time j lctl))
              k (multi f24 (tap-hold $tap-time $hold-time k lsft))
              l (multi f24 (tap-hold $tap-time $hold-time l ralt))
              ; (multi f24 (tap-hold $tap-time $hold-time ; lmet))
            )

            (deflayer base
              @escctrl @a @s @d @f @j @k @l @;
            )


          '';
        };
      };
    };
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
  };

  # compress half of the ram to use as swap
  zramSwap = {
    enable = lib.mkDefault false;
    algorithm = "zstd";
  };

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };
  environment.systemPackages = with pkgs; [
    git
    uutils-coreutils-noprefix
    btrfs-progs
    cifs-utils
    appimage-run
    starship # having starship here means pkgs.startship will be stored during build and not during promptInit
  ];

  time = {
    timeZone = "Europe/Warsaw";
    hardwareClockInLocalTime = true;
  };
  hardware.ledger.enable = true;

  i18n = let
    defaultLocale = "en_US.UTF-8";
    pl = "pl_PL.UTF-8";
  in {
    inherit defaultLocale;
    extraLocaleSettings = {
      LANG = defaultLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MESSAGES = defaultLocale;

      LC_ADDRESS = pl;
      LC_IDENTIFICATION = pl;
      LC_MEASUREMENT = pl;
      LC_MONETARY = pl;
      LC_NAME = pl;
      LC_NUMERIC = pl;
      LC_PAPER = pl;
      LC_TELEPHONE = pl;
      LC_TIME = pl;
    };
  };
  console = let
    variant = "u24n";
  in {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-${variant}.psf.gz";
    earlySetup = true;
    keyMap = "pl";
  };

  boot.binfmt.registrations = lib.genAttrs ["appimage" "AppImage"] (ext: {
    recognitionType = "extension";
    magicOrExtension = ext;
    interpreter = "/run/current-system/sw/bin/appimage-run";
  });

  programs.nix-ld.enable = true;
  systemd = let
    extraConfig = ''
      DefaultTimeoutStopSec=15s
    '';
  in {
    inherit extraConfig;
    user = {inherit extraConfig;};
    services."getty@tty1".enable = false;
    services."autovt@tty1".enable = false;
    services."getty@tty7".enable = false;
    services."autovt@tty7".enable = false;
    # Systemd OOMd
    # Fedora enables these options by default. See the 10-oomd-* files here:
    # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
    oomd.enableRootSlice = true;

    # TODO channels-to-flakes
    tmpfiles.rules = [
      "D /nix/var/nix/profiles/per-user/root 755 root root - -"
    ];
  };

  programs = {
    # allow users to mount fuse filesystems with allow_other
    fuse.userAllowOther = true;

    # help manage android devices via command line
    adb.enable = true;

    # "saying java is good because it runs on all systems is like saying
    # anal sex is good because it works on all species"
    # - sun tzu
    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}
