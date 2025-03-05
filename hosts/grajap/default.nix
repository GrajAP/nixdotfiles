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

  networking.hostName = "grajap"; # Define your hostname.
  services = {
    immich = {
      enable = true;
      port = 2283;
      mediaLocation = "/home/grajap/dev/imich-app/library";
    };
    ollama = {
      enable = true;
      #acceleration = "rocm";
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx803"; # used to be necessary, but doesn't seem to anymore
      };
      rocmOverrideGfx = "8.0.3";
    };

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
    thermald.enable = true;
    xserver.videoDrivers = ["amdgpu"];
    undervolt = {
      enable = true;
      tempBat = 75;
    };
  };
  boot = {
    initrd.luks.devices."luks-b02f9d12-7cd0-44dd-a637-c9b7a4f84049".device = "/dev/disk/by-uuid/b02f9d12-7cd0-44dd-a637-c9b7a4f84049";
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
