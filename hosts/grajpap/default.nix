{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  environment.systemPackages = with pkgs; [
    acpi
    powertop
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  networking.hostName = "grajpap"; # Define your hostname.
  services = {
    #     immich = {
    #       enable = true;
    #       port = 2283;
    #       mediaLocation = "/home/grajpap/dev/imich-app/library";
    #     };
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
    fprintd.enable = true;
    xserver.videoDrivers = ["amdgpu"];
  };
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez5-experimental;
    };
    # https://github.com/NixOS/nixpkgs/issues/114222
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        amdvlk
        libvdpau-va-gl
        vaapiVdpau
        mesa.opencl
        ocl-icd
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        driversi686Linux.amdvlk
        libvdpau-va-gl
      ];
    };
  };
}
