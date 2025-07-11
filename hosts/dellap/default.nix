{
  pkgs,
  config,
  ...
}: let
  mic-light-on = pkgs.writeShellScriptBin "mic-light-on" ''
    #!bin/sh
    echo 1 > /sys/class/leds/platform::micmute/brightness
  '';
  mic-light-off = pkgs.writeShellScriptBin "mic-light-off" ''
    #!bin/sh
    echo 0 > /sys/class/leds/platform::micmute/brightness
  '';
in {
  imports = [
    ./hardware-configuration.nix
  ];
  environment.systemPackages = with pkgs; [
    acpi
    powertop
    mic-light-on
    mic-light-off
  ];

  networking.hostName = "dellap"; # Define your hostname.

  services = {
    kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
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
    auto-cpufreq.enable = false;
    fprintd.enable = true;
    thermald.enable = true;
    # DBus service that provides power management support to applications.
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "Hibernate";
    };
  };
  # superior power management (brought to you by raf :3)

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
  #security.pam.services.login.fprintAuth = true;
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    speed = 255;
    sensitivity = 100;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental;
  };
  # https://github.com/NixOS/nixpkgs/issues/114222
  systemd.user.services.telephony_client.enable = false;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [vaapiIntel libva libvdpau-va-gl vaapiVdpau ocl-icd intel-compute-runtime];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
