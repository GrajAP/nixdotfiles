{
  pkgs,
  config,
  ...
}: {
  imports = [./hardware-configuration.nix];
  environment.systemPackages = with pkgs; [
    acpi
    powertop
  ];

  networking.hostName = "grajap"; # Define your hostname.
  services = {
    fprintd.enable = true;
    thermald.enable = true;
    xserver.videoDrivers = ["amdgpu"];
    undervolt = {
      enable = true;
      tempBat = 75;
    };
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
