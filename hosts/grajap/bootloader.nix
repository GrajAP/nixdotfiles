{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
in {
  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.os-prober
    pkgs.sbctl
  ];
  boot = {
    initrd.luks.devices."luks-b02f9d12-7cd0-44dd-a637-c9b7a4f84049".device = "/dev/disk/by-uuid/b02f9d12-7cd0-44dd-a637-c9b7a4f84049";
    binfmt.emulatedSystems = ["aarch64-linux"];
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    # some kernel parameters, i dont remember what half of this shit does but who cares
    consoleLogLevel = mkDefault 0;
    initrd.verbose = false;
    kernelPackages = mkDefault pkgs.linuxPackages_zen;
    kernelParams = [
      "psmouse.synaptics_intertouch=1"
      "intel_pstate=disable"
    ];
    extraModprobeConfig = ''
      options i915 enable_fbc=1 enable_guc=2
      options snd-intel-dspcfg dsp_driver=1
      options snd_hda_intel enable=1,1 power_save=1 power_save_controller=Y
    '';
    supportedFilesystems = ["ntfs"];

    bootspec.enable = mkDefault true;
    loader = {
      #systemd-boot.enable = mkDefault true;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      }; # spam space to get to boot menu
      #timeout = 0;
    };
  };
}
